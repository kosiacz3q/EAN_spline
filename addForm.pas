unit addForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TForm2 = class(TForm)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


type
   plist = ^element;
   element = record
         key : integer;
         name : string[20];
         producer : string[20];
         alkType : string[20];
         country : string[20];
         region : string[30];
         description : string[200];
         alkCount : integer;
         capacity : integer;
         imageFile : string[100];
         wsk : plist;
   end;
var
  Form2: TForm2;
  el : element;

implementation

uses Unit1;

{$R *.dfm}

//procedure add(el : element); stdcall external 'dll.dll';
//procedure edit(el : element; id : integer); stdcall external 'dll.dll';
//function get(id : integer) : element; stdcall external 'dll.dll';

procedure TForm2.FormShow(Sender: TObject);
begin
     if Form1.selectedID >= 0 then
     begin

    end;
end;

end.
