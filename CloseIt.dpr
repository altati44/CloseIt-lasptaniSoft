program CloseIt;

uses
  Forms,
  UnitCerrar in 'UnitCerrar.pas' {Form1},
  UnitAbout in 'UnitAbout.pas' {FormAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'CloseIt-lasptaniSoft';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.Run;
end.
