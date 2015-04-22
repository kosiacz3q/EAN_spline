program Project1;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  CreateMutex(nil, FALSE, 'spline value');
   if GetLastError() <> 0 then Halt;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
