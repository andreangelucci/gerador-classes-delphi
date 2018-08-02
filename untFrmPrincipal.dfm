object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gerador de classes Delphi'
  ClientHeight = 631
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 24
    Top = 80
    Width = 38
    Height = 16
    Caption = 'Nome:'
  end
  object Label2: TLabel
    Left = 160
    Top = 80
    Width = 51
    Height = 16
    Caption = 'Dom'#237'nio:'
  end
  object Label3: TLabel
    Left = 295
    Top = 80
    Width = 60
    Height = 16
    Caption = 'Json alias:'
  end
  object Label4: TLabel
    Left = 24
    Top = 136
    Width = 71
    Height = 16
    Caption = 'Coment'#225'rio:'
  end
  object Label5: TLabel
    Left = 288
    Top = 32
    Width = 104
    Height = 16
    Caption = 'Nome da classe:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtNome: TEdit
    Left = 24
    Top = 102
    Width = 121
    Height = 24
    TabOrder = 0
  end
  object edtJson: TEdit
    Left = 295
    Top = 102
    Width = 121
    Height = 24
    TabOrder = 2
  end
  object edtComentario: TEdit
    Left = 24
    Top = 158
    Width = 392
    Height = 24
    TabOrder = 4
  end
  object ckbSomenteLeitura: TCheckBox
    Left = 440
    Top = 106
    Width = 113
    Height = 17
    TabStop = False
    Caption = 'Somente leitura'
    TabOrder = 3
  end
  object btnAdicionar: TButton
    Left = 440
    Top = 158
    Width = 113
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 5
    OnClick = btnAdicionarClick
  end
  object lstPropriedades: TListBox
    Left = 24
    Top = 200
    Width = 121
    Height = 369
    TabOrder = 6
  end
  object memoResult: TMemo
    Left = 160
    Top = 200
    Width = 393
    Height = 369
    BevelInner = bvNone
    BevelOuter = bvNone
    BorderStyle = bsNone
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clYellow
    Font.Height = -12
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'memoResult')
    ParentFont = False
    TabOrder = 7
  end
  object btnGerar: TButton
    Left = 304
    Top = 575
    Width = 121
    Height = 25
    Caption = 'Gerar classe'
    TabOrder = 8
    OnClick = btnGerarClick
  end
  object btnLimpar: TButton
    Left = 24
    Top = 575
    Width = 121
    Height = 25
    Caption = 'Limpar'
    TabOrder = 9
    OnClick = btnLimparClick
  end
  object btnClipbrd: TButton
    Left = 432
    Top = 575
    Width = 121
    Height = 25
    Caption = 'Clipboard'
    TabOrder = 10
    OnClick = btnClipbrdClick
  end
  object edtNomeClasse: TEdit
    Left = 406
    Top = 29
    Width = 147
    Height = 24
    TabStop = False
    TabOrder = 11
  end
  object cbbDominio: TComboBox
    Left = 160
    Top = 102
    Width = 121
    Height = 24
    TabOrder = 1
    Items.Strings = (
      'String'
      'Integer'
      'TDate'
      'TDateTime'
      'Double'
      'Boolean'
      'Real'
      'TStringList')
  end
end
