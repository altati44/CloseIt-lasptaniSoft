object Form1: TForm1
  Left = 362
  Top = 135
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'CloseIt-lasptaniSoft'
  ClientHeight = 289
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Visible = True
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 298
    Height = 289
    Align = alClient
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 125
      Height = 287
      Align = alLeft
      TabOrder = 0
      ExplicitLeft = -4
      object Ejecutables: TButton
        Left = 23
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Actualizar'
        TabOrder = 0
        OnClick = EjecutablesClick
      end
      object CloseIt: TButton
        Left = 23
        Top = 56
        Width = 75
        Height = 25
        Caption = 'CloseIt'
        TabOrder = 1
        OnClick = CloseItClick
      end
      object Desmarcar: TButton
        Left = 23
        Top = 88
        Width = 75
        Height = 25
        Caption = 'Desmarcar'
        TabOrder = 2
        OnClick = DesmarcarClick
      end
      object Cerrar: TButton
        Left = 23
        Top = 120
        Width = 75
        Height = 25
        Caption = 'Cerrar'
        TabOrder = 3
        OnClick = CerrarClick
      end
      object CheckBox1: TCheckBox
        Left = 5
        Top = 262
        Width = 117
        Height = 17
        Caption = 'Iniciar con Windows'
        Checked = True
        State = cbChecked
        TabOrder = 4
        OnClick = CheckBox1Click
      end
      object Button1: TButton
        Left = 23
        Top = 191
        Width = 75
        Height = 25
        Caption = 'Acerca de...'
        TabOrder = 5
        OnClick = Button1Click
      end
      object CheckBox2: TCheckBox
        Left = 5
        Top = 237
        Width = 117
        Height = 17
        Caption = 'Mantener Encima'
        TabOrder = 6
        OnClick = CheckBox2Click
      end
    end
    object Panel3: TPanel
      Left = 126
      Top = 1
      Width = 171
      Height = 287
      Align = alClient
      TabOrder = 1
      object Panel4: TPanel
        Left = 1
        Top = 283
        Width = 169
        Height = 3
        Align = alBottom
        Alignment = taLeftJustify
        TabOrder = 0
      end
      object Panel5: TPanel
        Left = 1
        Top = 1
        Width = 169
        Height = 25
        Align = alTop
        Caption = 'Programas en ejecuci'#243'n -->'
        TabOrder = 1
      end
      object ListBox1: TListBox
        Left = 1
        Top = 26
        Width = 169
        Height = 257
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        ItemHeight = 13
        MultiSelect = True
        TabOrder = 2
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 1
    Top = 149
    object Salir1: TMenuItem
      Caption = 'Salir'
      OnClick = Salir1Click
    end
    object Acercade1: TMenuItem
      Caption = 'Acerca de...'
    end
  end
end
