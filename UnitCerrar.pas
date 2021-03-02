unit UnitCerrar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TLHelp32, ExtCtrls,WinXP, Menus, abfComponents,
  JvComponentBase, JvBalloonHint, JvHint;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    ListBox1: TListBox;
    Ejecutables: TButton;
    CloseIt: TButton;
    Desmarcar: TButton;
    Cerrar: TButton;
    PopupMenu1: TPopupMenu;
    Salir1: TMenuItem;
    Acercade1: TMenuItem;
    CheckBox1: TCheckBox;
    abfAutoRun1: TabfAutoRun;
    abfOneInstance1: TabfOneInstance;
    Button1: TButton;
    CheckBox2: TCheckBox;
    abfTrayIcon1: TabfTrayIcon;
    procedure CloseItClick(Sender: TObject);
    procedure EjecutablesClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DesmarcarClick(Sender: TObject);
    procedure CerrarClick(Sender: TObject);
    procedure Salir1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure PopupMenuItemsClick(Sender: TObject);
    procedure PopupMenuItemsClickAbout(Sender: TObject);
    procedure PopupMenuItemsClickcierra(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FicheroCerrar: String;

implementation

uses UnitAbout;

{$R *.dfm}

function KillTask(FileName:String):integer;
var
  FProcessEntry32:TProcessEntry32;
  ContinueLoop:BOOL;
  FSnapshotHandle:THandle;
const
  PROCESS_TERMINATE=$0001;
begin
  FSnapshotHandle:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
  FProcessEntry32.dwSize:=Sizeof(FProcessEntry32);
  ContinueLoop:=Process32First(FSnapshotHandle,FProcessEntry32);
  while integer(ContinueLoop)<>0 do
  begin
    if
      ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile))=UpperCase(FileName))
        or (UpperCase(FProcessEntry32.szExeFile)=UpperCase(FileName))) then
      Result:=Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE,BOOL(0),
                                    FProcessEntry32.th32ProcessID),0));
          ContinueLoop:=Process32Next(FSnapshotHandle,FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;


procedure TForm1.CloseItClick(Sender: TObject);
var
  i: Integer;
begin
  if listbox1.SelCount>0 then
  {If Application.MessageBox ('¿Estás seguro que deseas cerrar el programa?   ',
                             'Cerrando ',MB_OKCANCEL+MB_ICONWARNING) =
                             ID_CANCEL Then
  Abort else }
  begin
    for i:=0 to listbox1.Count-1 do
    begin
      if listbox1.Selected[i] then
      begin
        FicheroCerrar:=ListBox1.Items.Strings[i];
        try
          KillTask(FicheroCerrar);
        except
        end;
      end;
    end;
    //Panel5.Caption:='Programas en ejecución --> '+IntToStr(ListBox1.Count);
    EjecutablesClick(Sender);
  end;
end;

procedure TForm1.EjecutablesClick(Sender: TObject);

    function SacaExe(MangoW:HWND):string;
    var
      Datos    :TProcessEntry32;
      hID       : DWord;
      Snap    : Integer;
    begin 
      GetWindowThreadProcessId(MangoW,@hID);
      Snap:=CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS,0);
      try
        Datos.dwSize:=SizeOf(Datos);
        if(Process32First(Snap,Datos))then
        begin 
          repeat 
            if Datos.th32ProcessID=hID then
            begin
              Result:=StrPas(Datos.szExeFile);
              Break;
            end; 
          until not(Process32Next(Snap,Datos));
        end;
      finally
        Windows.CloseHandle(Snap);
      end; 
    end; 

   function ObtieneVentanas(Mango: HWND;Nada: Pointer): Boolean; stdcall;
   var 
      sTemp:string;
   begin
     Result := True;
     sTemp:=SacaExe(Mango);
      with Form1.ListBox1.Items do
      try
        if IndexOf(sTemp) = - 1 then Add(sTemp);
      except;
      end;
   end; 
 
begin
  ListBox1.Clear;
  EnumWindows(@ObtieneVentanas, 0);
  Panel5.Caption:='Programas en ejecución --> '+IntToStr(ListBox1.Count);
end; 


procedure TForm1.FormActivate(Sender: TObject);
begin
  EjecutablesClick(Sender);
  Panel5.Caption:='Programas en ejecución --> '+IntToStr(ListBox1.Count);
end;

procedure TForm1.DesmarcarClick(Sender: TObject);
var
  i: Integer;
begin
  if listbox1.SelCount<>-1 then
  for i:=0 to listbox1.Count-1 do
  begin
    if ListBox1.Selected[i] then ListBox1.Selected[i]:=false;
  end;
end;

procedure TForm1.CerrarClick(Sender: TObject);
begin
  close;
end;

procedure TForm1.Salir1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
var
  indice: Integer;
  NuevoItem: TMenuItem;
begin
  EjecutablesClick(Sender);
  PopupMenu1.Items.Clear;
  for indice := 0 to listbox1.Items.Count-1 do
  begin
    NuevoItem := TMenuItem.Create(PopupMenu1); // crea el nuevo item
    PopupMenu1.Items.Add(NuevoItem);// lo adiciona al Popupmenu
    NuevoItem.Caption := listbox1.Items.Strings[indice];
    NuevoItem.Tag := indice;
    NuevoItem.OnClick := PopupMenuItemsClick;// le asignamos un evento handler
  end;
  NuevoItem := TMenuItem.Create(PopupMenu1);
  PopupMenu1.Items.Add(NuevoItem);
  NuevoItem.Caption := '-';
  NuevoItem.OnClick :=nil;
  NuevoItem := TMenuItem.Create(PopupMenu1);
  PopupMenu1.Items.Add(NuevoItem);
  NuevoItem.Caption := 'Cerrar CloseIt';
  NuevoItem.OnClick := PopupMenuItemsClickcierra;
  NuevoItem := TMenuItem.Create(PopupMenu1);
  PopupMenu1.Items.Add(NuevoItem);
  NuevoItem.Caption := 'Acerca de...';
  NuevoItem.OnClick := PopupMenuItemsClickabout;
end;

procedure TForm1.PopupMenuItemsClick(Sender: TObject);
begin
  with Sender as TMenuItem do
  begin
    try
      KillTask(ListBox1.Items.Strings[tag]);
    except;
    end;
  end;
end;

procedure TForm1.PopupMenuItemsClickcierra(Sender: TObject);
begin
  close;
end;

procedure TForm1.PopupMenuItemsClickabout(Sender: TObject);
begin
  formAbout.ShowModal;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  abfAutoRun1.AutoRun := (Sender as TCheckBox).Checked;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  formAbout.ShowModal;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  If CheckBox2.Checked then Form1.FormStyle:=fsStayOnTop
  else Form1.FormStyle:=fsNormal;
end;

end.
