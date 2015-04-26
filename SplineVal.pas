unit SplineVal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, DynamicStringGrid,
  Vcl.Mask;

type
  TSplineValForm = class(TForm)
    Button1: TButton;
    StringGrid1: TStringGrid;
    Label1: TLabel;
    editN: TEdit;
    DebugMemo: TMemo;
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGrid1Exit(Sender: TObject);
    procedure editNChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SplineValForm: TSplineValForm;

implementation

{$R *.dfm}


procedure TSplineValForm.editNChange(Sender: TObject);
begin
  DebugMemo.Text := editN.Text;

  if True then

  if not (editN.Text[Length(editN.Text)] in ['0' .. '9']) then
  begin
      editN.Text := Copy(editN.Text, 0 , Length(editN.Text - 1));
     //DebugMemo.Text := 'gfd';
  end;

 // DebugMemo.Text := 'asf';

end;

procedure TSplineValForm.StringGrid1Exit(Sender: TObject);
var
  i : Integer;
begin
   if StringGrid1.Cells[StringGrid1.ColCount - 1,1] = '' then
  begin
   // StringGrid1.ColCount :=  StringGrid1.ColCount - 1;
  end;

   //StringGrid1.ColCount :=  StringGrid1.ColCount - 1;
end;



procedure TSplineValForm.StringGrid1SetEditText(Sender: TObject; ACol,
  ARow: Integer; const Value: string);
var
  i : Integer;
begin

//

end;

end.
