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
    procedure Refresh();
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

uses addForm;

{$R *.dfm}

type
  TExtendedArray = array of Extended;

function naturalsplinevalue (n      : Integer;
                             x,f    : array of Extended;
                             xx     : Extended;
                             var st : Integer) : Extended; stdcall external 'dll.dll';

procedure naturalsplinecoeffns (n      : Integer;
                                x,f    : array of Extended;
                                var a  : array of TExtendedArray;
                                var st : Integer); stdcall external 'dll.dll';

procedure TForm1.Refresh();
var
 output : string;
 outputValue : Extended;
begin


end;

procedure TForm1.Button1Click(Sender: TObject);
var
  n      : Integer;
  x,f    : array of Extended;
  xx     : Extended;
  var st : Integer ;
  outVal: Extended;
  outString : string;
begin
  SetLength(x, 8);
  SetLength(f, 8);
  
  n := 4;

  outVal := naturalsplinevalue(n - 1, x,f, xx, st);

  Str(outVal,outString);

  Edit1.Text := outString;
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
