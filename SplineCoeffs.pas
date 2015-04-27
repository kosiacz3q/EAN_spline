unit SplineCoeffs;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, IntervalArithmetic32and64,
  Vcl.Mask;

type
  TSplineCoeffsForm = class(TForm)
    buttonResult: TButton;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    editN: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    ErrorMemo: TMemo;
    StringGrid2: TStringGrid;
    procedure editNChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

  type
  TExtendedArray = array of Extended;

  procedure naturalsplinecoeffns (n      : Integer;
                                  x,f    : array of Extended;
                                  var a  : array of TExtendedArray;
                                  var st : Integer); external 'dll.dll';
var
  SplineCoeffsForm: TSplineCoeffsForm;

implementation

{$R *.dfm}


procedure TSplineCoeffsForm.buttonResultClick(Sender: TObject);
var
  n      : Integer;
  x,f    : array of Extended;
  a  : array of TExtendedArray;
  st : Integer ;
  i,j : Integer;
begin

  if Length(editN.Text) = 0 then
  begin
    ShowMessage('Wartoœæ N nie mo¿e byæ pusta!');
    Exit;
  end;

  n := StrToInt(editN.Text);

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

  SetLength(a, 10);
  for i := 0 to 10 do
    SetLength(a[i], 10);

  naturalsplinecoeffns(n,f,x,a,st);

  if st <> 0 then
  begin
    StringGrid2.RowCount := 0;
    StringGrid2.ColCount := 0;
  end
  else
  begin
      StringGrid2.RowCount := n - 1;
      StringGrid2.ColCount := 3;

      for i := 0 to 3 do
      begin
        for j := 0 to n - 1 do
          StringGrid2.Cells[i,j] := resultToString(a[i,j]);
      end;
  end;

  showError(st);
end;

procedure TSplineCoeffsForm.editNChange(Sender: TObject);
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

procedure TSplineCoeffsForm.FormCreate(Sender: TObject);
begin
  StringGrid1.ColCount := 1;
  StringGrid1.RowCount := 0;
  StringGrid1.RowCount := 2;
end;


function TSplineCoeffsForm.resultToString(const res : Extended) : string;
var
    outLeft, outRight : string;
begin
    iends_to_strings (res, outLeft , outRight);
    Result := outLeft;
end;

procedure TSplineCoeffsForm.StringGrid1SetEditText(Sender: TObject; ACol,
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

procedure TSplineCoeffsForm.showError(errorCode : Integer);
begin
  case errorCode of
    0   :  ErrorMemo.Text := '';
    1   :  ErrorMemo.Text := 'Wartoœæ N nie mo¿e byæ mniejsza od 1!';
    2   :  ErrorMemo.Text := 'Dwa ró¿ne wêz³y nie mog¹ mieæ tej samej wartoœci!';
    3   :  ErrorMemo.Text := 'Szukana wartoœæ nie zawiera siê w przedziale wynikaj¹cym z wêz³ów!';
  end;
end;

end.
