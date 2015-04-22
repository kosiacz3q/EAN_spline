unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ValEdit, StrUtils, XPMan, jpeg,
  ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    XPManifest1: TXPManifest;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
     selectedID : integer;
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

type
  TExtendedArray = array of Extended;

function naturalsplinevalue (n      : Integer;
                             x,f    : array of Extended;
                             xx     : Extended;
                             var st : Integer) : Extended; external 'dll.dll';

procedure naturalsplinecoeffns (n      : Integer;
                                x,f    : array of Extended;
                                var a  : array of TExtendedArray;
                                var st : Integer); external 'dll.dll';

procedure TForm1.Button1Click(Sender: TObject);
var
  n      : Integer;
  x,f    : array of Extended;
  xx     : Extended;
  var st : Integer ;
  outVal: Extended;
  outString : string;
begin
  SetLength(x, 9);
  SetLength(f, 9);

  xx := 4;

  x[1] := 1;
  x[2] := 2;
  x[3] := 3;
  x[5] := 5;

  f[1] := 1;
  f[2] := 2;
  f[3] := 3;
  f[5] := 5;

  n := 4;

  outVal := naturalsplinevalue(n - 1, x,f, xx, st);

  //outString := FormatFloat('0.0000000000000',outVal)   ;
  Edit1.Text :=FloatToStr(outVal);

  //Edit1.Text := outString;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  n      : Integer;
  x,f    : array of Extended;
  a  : array of TExtendedArray;
  st : Integer ;
  i : Integer;
begin

    SetLength(a, 10);

    for i := 0 to 10 do
      SetLength(a[i], 10);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin

    

    Refresh();
end;


end.
