unit untFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, untGerador, Clipbrd;

type
  TfrmPrincipal = class(TForm)
    Label1: TLabel;
    edtNome: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtJson: TEdit;
    Label4: TLabel;
    edtComentario: TEdit;
    ckbSomenteLeitura: TCheckBox;
    btnAdicionar: TButton;
    lstPropriedades: TListBox;
    memoResult: TMemo;
    btnGerar: TButton;
    btnLimpar: TButton;
    btnClipbrd: TButton;
    Label5: TLabel;
    edtNomeClasse: TEdit;
    cbbDominio: TComboBox;
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnClipbrdClick(Sender: TObject);
    procedure btnGerarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    gerador: TGerador;
    procedure limpaEdits();
    procedure limparGerador();
  public
    procedure novoGerador;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

{ TForm1 }

procedure TfrmPrincipal.btnAdicionarClick(Sender: TObject);
var
  atb: TAtributo;
begin
  //adiciona novo atributo
  atb := TAtributo.Create;
  atb.Nome := edtNome.Text;
  atb.Dominio := cbbDominio.Text;
  atb.JsonAlias := edtJson.Text;
  atb.SomenteLeitura := ckbSomenteLeitura.Checked;
  atb.Comentario := edtComentario.Text;
  gerador.addAtributo(atb);
  lstPropriedades.Items.Add(atb.Nome);

  limpaEdits();
  edtNome.SetFocus;
end;

procedure TfrmPrincipal.btnClipbrdClick(Sender: TObject);
begin
  Clipboard.AsText := memoResult.Lines.Text;
end;

procedure TfrmPrincipal.btnGerarClick(Sender: TObject);
begin
  //gera a classe
  gerador.Nome := edtNomeClasse.Text;
  memoResult.Lines.Text := gerador.montarClasse();
end;

procedure TfrmPrincipal.btnLimparClick(Sender: TObject);
begin
  limparGerador();
end;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
  novoGerador();
  edtNomeClasse.SetFocus();
end;

procedure TfrmPrincipal.limpaEdits;
begin
  edtNome.Clear;
  cbbDominio.ItemIndex := -1;
  edtJson.Clear;
  edtComentario.Clear;
  ckbSomenteLeitura.Checked := False;
end;

procedure TfrmPrincipal.limparGerador;
begin
  limpaEdits;
  lstPropriedades.Clear;
  memoResult.Clear;
  edtNomeClasse.Clear;
  novoGerador;
end;

procedure TfrmPrincipal.novoGerador;
begin
  if (gerador <> nil) then
    FreeAndNil(gerador);
  gerador := TGerador.Create;
end;

end.
