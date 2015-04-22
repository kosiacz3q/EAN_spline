program Project1;

uses
  Forms,
  Windows,
  Unit1 in 'Unit1.pas' {Form1},
  addForm in 'addForm.pas' {Form2};

{$R *.res}

begin
  CreateMutex(nil, FALSE, 'ALCOHOLIZATOR');
   if GetLastError() <> 0 then Halt;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
