unit SplineIntervalVal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, IntervalArithmetic32and64,
  Vcl.Mask;

type
  TSplineIntervalValForm = class(TForm)
    buttonResult: TButton;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    editN: TEdit;
    ResultMemo: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    editXX: TEdit;
    ErrorMemo: TMemo;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    editXX_l: TEdit;
    procedure editNExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editXXExit(Sender: TObject);
    procedure buttonResultClick(Sender: TObject);

    procedure showError(errorCode : Integer);

    function resultToString(const res : Interval) : string;
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure editXX_lExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function naturalsplinevalueInterval (n      : Integer;
                             x,f    : array of interval;
                             xx     : interval;
                             var st : Integer) : interval; external 'dll.dll';
var
  SplineIntervalValForm: TSplineIntervalValForm;

implementation

{$R *.dfm}


procedure TSplineIntervalValForm.buttonResultClick(Sender: TObject);
var
  n      : Integer;
  x,f    : array of interval;
  xx     : interval;
  st,i   : Integer ;
  outVal: interval;
begin
  if Length(editN.Text) = 0 then
  begin
    ShowMessage('Wartoœæ N nie mo¿e byæ pusta!');
    Exit;
  end;

  n := StrToInt(editN.Text);

  if Length(editXX.Text) = 0 then
  begin
    ShowMessage('Wartoœæ XX nie mo¿e byæ pusta!');
    Exit;
  end;

  xx.a := StrToFloat(editXX.Text);
  xx.b := StrToFloat(editXX_l.Text);

  SetLength(x, n + 1);
  SetLength(f, n + 1);

  for i := 0 to n - 1 do
  begin
    if ((StringGrid1.Cells[i,0] <> '') and (StringGrid1.Cells[i,0] <> '-')) then
      x[i].a := StrToFloat(StringGrid1.Cells[i,0])
    else
    begin
      ShowMessage('Wartoœæ komórki [' + IntToStr(i) + ',0] nie mo¿e byæ pusta!');
      Exit;
    end;
  end;

    for i := 0 to n - 1 do
  begin
    if((StringGrid1.Cells[i,1] <> '') and (StringGrid1.Cells[i,1] <> '-')) then
      x[i].b := StrToFloat(StringGrid1.Cells[i,1])
    else
    begin
      ShowMessage('Wartoœæ komórki [' + IntToStr(i) + ',1] nie mo¿e byæ pusta!');
      Exit;
    end;
  end;

  for i := 0 to n - 1 do
  begin
    if ((StringGrid1.Cells[i,2] <> '') and (StringGrid1.Cells[i,2] <> '-')) then
      f[i].a := StrToFloat(StringGrid1.Cells[i,2])
    else
    begin
      ShowMessage('Wartoœæ komórki [' + IntToStr(i) + ',2] nie mo¿e byæ pusta!');
      Exit;
    end;
  end;

  for i := 0 to n - 1 do
  begin
    if ((StringGrid1.Cells[i,3] <> '') and (StringGrid1.Cells[i,3] <> '-')) then
      f[i].b := StrToFloat(StringGrid1.Cells[i,3])
    else
    begin
      ShowMessage('Wartoœæ komórki [' + IntToStr(i) + ',3] nie mo¿e byæ pusta!');
      Exit;
    end;
  end;

  outVal := naturalsplinevalueInterval(n - 1, x,f, xx, st);

  if st = 0 then
    ResultMemo.Text := resultToString(outVal)
  else
    ResultMemo.Text := '';

  showError(st);
end;

procedure TSplineIntervalValForm.editXX_lExit(Sender: TObject);
var
  iVal : Extended;
begin

  if not (( editXX_l.Text = ''))  then
    if not TryStrToFloat(editXX_l.Text, iVal) then
    begin
      ShowMessage('Wprowadzona wartoœæ musi byæ liczb¹');
      editXX.Text := '';
    end;
end;

procedure TSplineIntervalValForm.editNExit(Sender: TObject);
var
  iVal,iCode : Integer;
begin
  Val(editN.Text, iVal, iCode);

  if (iCode = 0 ) and (iVal > 0) then
    StringGrid1.ColCount := iVal
  else
  begin
    ShowMessage('Wprowadzona wartoœæ musi byæ liczb¹ dodatni¹');
    editN.Text := '1';
  end;

end;

procedure TSplineIntervalValForm.editXXExit(Sender: TObject);
var
  iVal : Extended;
begin

  if not ( editXX.Text = '') then
    if not TryStrToFloat(editXX.Text, iVal) then
    begin
      ShowMessage('Wprowadzona wartoœæ musi byæ liczb¹');
      editXX.Text := '';
    end;
end;

procedure TSplineIntervalValForm.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount := 1;
  StringGrid1.RowCount := 0;
  StringGrid1.RowCount := 4;
end;


function TSplineIntervalValForm.resultToString(const res : Interval) : string;
var
    outLeft, outRight : string;
begin
    iends_to_strings (res, outLeft , outRight);
    Result := '[' + outLeft + ',' + outRight + ']';
end;

procedure TSplineIntervalValForm.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
var
  outVal : Extended;
begin
  if not (Length(StringGrid1.Cells[ACol,ARow]) = 0) then
    if not TryStrToFloat(StringGrid1.Cells[ACol,ARow],outVal) then
    begin
       ShowMessage('Dozwolone tylko wartoœci zmiennoprzecinkowe!');
       StringGrid1.Cells[ACol,ARow] := '';
    end;
end;

procedure TSplineIntervalValForm.showError(errorCode : Integer);
begin
  case errorCode of
    0   :  ErrorMemo.Text := '';
    1   :  ErrorMemo.Text := 'Wartoœæ N nie mo¿e byæ mniejsza od 1!';
    2   :  ErrorMemo.Text := 'Dwa ró¿ne wêz³y nie mog¹ mieæ tej samej wartoœci!';
    3   :  ErrorMemo.Text := 'Szukana wartoœæ nie zawiera siê w przedziale wynikaj¹cym z wêz³ów!';
  end;
end;

end.
