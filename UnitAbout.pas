unit UnitAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Gradient;

type
  TFormAbout = class(TForm)
    Gradiente1: TGradiente;
    Label2: TLabel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    PhysMem: TLabel;
    FreeRes: TLabel;
    Image2: TImage;
    Label5: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation

{$R *.dfm}

procedure TFormAbout.FormActivate(Sender: TObject);
var
  MS: TMemoryStatus;
begin
  GlobalMemoryStatus(MS);
  PhysMem.Caption := FormatFloat('#,###" KB"', MS.dwTotalPhys / 1024);
  FreeRes.Caption := Format('%d %%', [MS.dwMemoryLoad]);
end;

end.
