unit untGerador;

interface

uses
  System.Classes, System.SysUtils;

type TAtributo = class
  private
    FDominio: String;
    FComentario: String;
    FSomenteLeitura: Boolean;
    FJsonAlias: String;
    FNome: String;
    procedure SetComentario(const Value: String);
    procedure SetDominio(const Value: String);
    procedure SetJsonAlias(const Value: String);
    procedure SetNome(const Value: String);
    procedure SetSomenteLeitura(const Value: Boolean);
  public
    property Nome: String read FNome write SetNome;
    property Dominio: String read FDominio write SetDominio;
    property Comentario: String read FComentario write SetComentario;
    property JsonAlias: String read FJsonAlias write SetJsonAlias;
    property SomenteLeitura: Boolean read FSomenteLeitura write SetSomenteLeitura;
end;

type TGerador = class
  private
    FAtributos: TArray<TAtributo>;
    FNome: String;
    procedure SetAtributos(const Value: TArray<TAtributo>);
    procedure SetNome(const Value: String);
    procedure adicionarLinhaStr(var strList: TStringList; ident: Integer; linha: String; const args: array of const);
  public
    constructor Create();
    property Nome: String read FNome write SetNome;
    property Atributos: TArray<TAtributo> read FAtributos write SetAtributos;
    procedure addAtributo(atb: TAtributo);
    function montarClasse(): String;
end;

implementation

{ TAtributo }

procedure TAtributo.SetComentario(const Value: String);
begin
  FComentario := Value;
end;

procedure TAtributo.SetDominio(const Value: String);
begin
  FDominio := Value;
end;

procedure TAtributo.SetJsonAlias(const Value: String);
begin
  FJsonAlias := Value;
end;

procedure TAtributo.SetNome(const Value: String);
begin
  FNome := Value;
end;

procedure TAtributo.SetSomenteLeitura(const Value: Boolean);
begin
  FSomenteLeitura := Value;
end;

{ TGerador }

procedure TGerador.adicionarLinhaStr(var strList: TStringList; ident: Integer; linha: String;
  const args: array of const);
var
  strIdentacao: String;
begin
  //adiciona uma linha a uma stringlist baseado nos parametros (como o format) e com uma identacao
  strIdentacao := StringOfChar(' ', ident);
  if (Length(args) > 0) then
    strList.Add(Format(strIdentacao + linha, args))
  else
    strList.Add(strIdentacao + linha);
end;

constructor TGerador.Create;
begin
  FAtributos := TArray<TAtributo>.Create();
end;

function TGerador.montarClasse: String;
var
  strClasse: TStringList;
  addRestUses: Boolean;
  p: TAtributo;
  strAuxSetters,
  strAuxImpSetters,
  strAuxProperty: TStringList;
  x: Integer;
  txtClasse: String;
begin
  //Gera a estrutura de classe baseado no array de atributos
  if (Nome = '') then
    raise Exception.Create('Nome da classe nao informado.');
  if (Length(Atributos) = 0) then
    raise Exception.Create('Nenhum atributo definido');
  strClasse := TStringList.Create();
  strAuxSetters := TStringList.Create;
  strAuxProperty := TStringList.Create;
  strAuxImpSetters := TStringList.Create;
  addRestUses := False;
  txtClasse := '';
  try
    //cria o cabecalho
    adicionarLinhaStr(strClasse, 0, 'type %s = class', [Nome]);
    //cria o private
    adicionarLinhaStr(strClasse, 2, 'private', []);
    for p in Atributos do
    begin
      if (p.JsonAlias <> '') then
      begin
        adicionarLinhaStr(strClasse, 4, '[JSONNameAttribute(''%s'')]', [p.JsonAlias]);
        if not(addRestUses) then
          addRestUses := True;
      end;
      adicionarLinhaStr(strClasse, 4, 'F%s: %s;', [p.Nome, p.Dominio]);
      //setters e property em strList auxiliares
      if (p.SomenteLeitura) then
      begin
        adicionarLinhaStr(strAuxProperty, 4, 'property %s: %s read F%0:s;', [p.Nome, p.Dominio]);
      end else
      begin
        if (p.Comentario <> '') then
          adicionarLinhaStr(strAuxProperty, 4, '//'+ p.Comentario, []);
        adicionarLinhaStr(strAuxProperty, 4, 'property %s: %s read F%0:s write Set%0:s;', [p.Nome, p.Dominio]);
        adicionarLinhaStr(strAuxSetters, 4, 'procedure Set%s(const Value: %s);', [p.Nome, p.Dominio]);
        //implementacao do metodo
        adicionarLinhaStr(strAuxImpSetters, 0, 'procedure %s.Set%s(const Value: %s);', [Self.Nome, p.Nome, p.Dominio]);
        adicionarLinhaStr(strAuxImpSetters, 0, 'begin', []);
        adicionarLinhaStr(strAuxImpSetters, 2, 'F%s := Value;', [p.Nome]);
        adicionarLinhaStr(strAuxImpSetters, 0, 'end;', []);
        strAuxImpSetters.Add('');
      end;
    end;
    //adicionar os setters q estao no strList auxiliar
    for x := 0 to (strAuxSetters.Count - 1) do
      strClasse.Add(strAuxSetters[x]);
    //clausula public
    adicionarLinhaStr(strClasse, 2, 'public', []);
    //adicionar as propriedades que estao no strList auxiliar
    for x := 0 to (strAuxProperty.Count - 1) do
      strClasse.Add(strAuxProperty[x]);
    //fim
    adicionarLinhaStr(strClasse, 0, 'end;', []);
    //verifica se deve adicionar a uses do JSon
    if (addRestUses) then
    begin
      strClasse.Insert(0, '');
      strClasse.Insert(0, 'uses REST.Json.Types;');
    end;
    //implementation
    if (strAuxImpSetters.Count > 0) then
    begin
      strClasse.Add('');
      adicionarLinhaStr(strClasse, 0, 'implementation', []);
      strClasse.Add('');
      adicionarLinhaStr(strClasse, 0, '{ %s }', [Self.Nome]);
      strClasse.Add('');
      for x := 0 to (strAuxImpSetters.Count - 1) do
        strClasse.Add(strAuxImpSetters[x]);
    end;
    txtClasse := strClasse.Text;
  finally
    strAuxSetters.Free;
    strAuxProperty.Free;
    strClasse.Free;
  end;
  Result := txtClasse;
end;

procedure TGerador.addAtributo(atb: TAtributo);
begin
  SetLength(FAtributos, Length(FAtributos) + 1);
  FAtributos[Length(FAtributos) - 1] := atb;
end;

procedure TGerador.SetAtributos(const Value: TArray<TAtributo>);
begin
  FAtributos := Value;
end;

procedure TGerador.SetNome(const Value: String);
begin
  FNome := Value;
end;

end.
