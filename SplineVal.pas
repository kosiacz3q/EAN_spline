unit SplineVal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, IntervalArithmetic32and64,
  Vcl.Mask;

type
  TSplineValForm = class(TForm)
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
    procedure editNChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure editXXChange(Sender: TObject);
    procedure buttonResultClick(Sender: TObject);

    procedure showError(errorCode : Integer);

    function resultToString(const res : Extended) : string; overload;
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function naturalsplinevalue (n      : Integer;
                             x,f    : array of Extended;
                             xx     : Extended;
                             var st : Integer) : Extended; external 'dll.dll';
var
  SplineValForm: TSplineValForm;

implementation

{$R *.dfm}


procedure TSplineValForm.buttonResultClick(Sender: TObject);
var
  n      : Integer;
  x,f    : array of Extended;
  xx     : Extended;
  st,i   : Integer ;
  outVal: Extended;
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

  xx := StrToFloat(editXX.Text);

  SetLength(x, n + 1);
  SetLength(f, n + 1);

  for i := 0 to n - 1 do
  begin
    if StringGrid1.Cells[i,0] <> '' then
      x[i] := StrToFloat(StringGrid1.Cells[i,0])
    else
    begin
      ShowMessage('Wartoœæ komórki [' + IntToStr(i) + ',0] nie mo¿e byæ pusta!');
      Exit;
    end;
  end;

  for i := 0 to n - 1 do
  begin
    if StringGrid1.Cells[i,1] <> '' then
      f[i] := StrToFloat(StringGrid1.Cells[i,1])
    else
    begin
      ShowMessage('Wartoœæ komórki [' + IntToStr(i) + ',1] nie mo¿e byæ pusta!');
      Exit;
    end;
  end;

  outVal := naturalsplinevalue(n - 1, x,f, xx, st);

  if st = 0 then
    ResultMemo.Text := resultToString(outVal)
  else
    ResultMemo.Text := '';

  showError(st);
end;

procedure TSplineValForm.editNChange(Sender: TObject);
var
  iVal,iCode : Integer;
begin
  Val(editN.Text, iVal, iCode);

  if iCode = 0 then
    StringGrid1.ColCount := iVal
  else
  begin
    ShowMessage('Wprowadzona wartoœæ musi byæ liczb¹');
    editN.Text := '1';
  end;

end;

procedure TSplineValForm.editXXChange(Sender: TObject);
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

procedure TSplineValForm.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount := 1;
  StringGrid1.RowCount := 0;
  StringGrid1.RowCount := 2;
end;


function TSplineValForm.resultToString(const res : Extended) : string;
var
    outLeft, outRight : string;
begin
    iends_to_strings (res, outLeft , outRight);
    Result := outLeft;
end;

procedure TSplineValForm.StringGrid1SetEditText(Sender: TObject; ACol,
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

procedure TSplineValForm.showError(errorCode : Integer);
begin
  case errorCode of
    0   :  ErrorMemo.Text := '';
    1   :  ErrorMemo.Text := 'Wartoœæ N nie mo¿e byæ mniejsza od 1!';
    2   :  ErrorMemo.Text := 'Dwa ró¿ne wêz³y nie mog¹ mieæ tej samej wartoœci!';
    3   :  ErrorMemo.Text := 'Szukana wartoœæ nie zawiera siê w przedziale podanych w wêz³ach!';
  end;
end;

end.
