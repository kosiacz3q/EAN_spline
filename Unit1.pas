unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, ValEdit, StrUtils, XPMan, jpeg,
  ExtCtrls, ComCtrls,
  IntervalArithmetic32and64;

type
  TForm1 = class(TForm)
    XPManifest1: TXPManifest;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    ButtonIntervalValue: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonIntervalValueClick(Sender: TObject);

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

function naturalsplinevalueInterval (n      : Integer;
                             x,f    : array of interval;
                             xx     : interval;
                             var st : Integer) : interval; external 'dll.dll';

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
begin
  SetLength(x, 9);
  SetLength(f, 9);
  xx := 4;

  x[1] := 1;
  x[2] := 2;
  x[3] := 3;
  x[4] := 5;

  f[1] := 1;
  f[2] := 2;
  f[3] := 3;
  f[4] := 5;

  n := 4;

  outVal := naturalsplinevalue(n, x,f, xx, st);

  if st <> 0 then
    Memo1.Text := 'some error occured ' + IntToStr(st)
  else
    Memo1.Text := FloatToStr(outVal);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  n      : Integer;
  x,f    : array of Extended;
  a  : array of TExtendedArray;
  st : Integer ;
  i,j : Integer;
begin
    n := 6;

    SetLength(x, 10);
    SetLength(f, 10);

    f[1] := 4;
    f[2] := 1;
    f[3] := 1.1;
    f[4] := 9;
    f[5] := 3;
    f[6] := 0.2;

    x[1] := 1;
    x[2] := 2;
    x[3] := 3;
    x[4] := 5;
    x[5] := 9;
    x[6] := 10;

    SetLength(a, 10);

    for i := 0 to 10 do
      SetLength(a[i], 10);

    for i := 0 to 10 do
      for j := 0 to 10 do
        a[i,j] := 0;

    naturalsplinecoeffns(n,f,x,a,st);

    if st <> 0 then
       Memo1.Text := 'some error occured ' + IntToStr(st)
    else
    begin
        Memo1.Text := '';
        for j := 0 to 9 do
        begin
          for i := 0 to 9 do
            Memo1.Text :=  Memo1.Text +  ' ' +  FloatToStr(a[i,j]);
          Memo1.Text := Memo1.Text + sLineBreak;
        end;
    end;

end;

procedure TForm1.ButtonIntervalValueClick(Sender: TObject);
var
  n      : Integer;
  x,f    : array of interval;
  xx     : interval;
  var st : Integer ;
  outVal: interval;
begin
  SetLength(x, 9);
  SetLength(f, 9);
  xx := 4;

  x[1] := 1;
  x[2] := 2;
  x[3] := 3;
  x[4] := 5;

  f[1] := 1;
  f[2] := 2;
  f[3] := 3;
  f[4] := 5;

  n := 4;

  outVal := naturalsplinevalueInterval(n, x,f, xx, st);

  if st <> 0 then
    Memo1.Text := 'some error occured ' + IntToStr(st)
  else
    Memo1.Text := 'works';// FloatToStr(outVal);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    Application.UpdateFormatSettings := false;

    Refresh();
end;

end.
