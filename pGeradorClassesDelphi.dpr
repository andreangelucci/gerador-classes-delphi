program pGeradorClassesDelphi;

uses
  Vcl.Forms,
  untFrmPrincipal in 'untFrmPrincipal.pas' {frmPrincipal},
  untGerador in 'untGerador.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
