//------------------------------------------------------------------------------------------------------------
//********* Sobre ************
//Autor: Gisele de Melo
//Esse c�digo foi desenvolvido com o intuito de aprendizado para o blog codedelphi.com, portanto n�o me
//responsabilizo pelo uso do mesmo.
//
//********* About ************
//Author: Gisele de Melo
//This code was developed for learning purposes for the codedelphi.com blog, therefore I am not responsible for
//its use.
//------------------------------------------------------------------------------------------------------------

unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type

  EFileNotFoundException = class(Exception)
  end;


  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    procedure ReadFile(const FileName: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    ReadFile('nonexistent.txt');
  except
    on E: EFileNotFoundException do
      ShowMessage('Exce��o capturada no n�vel principal: ' + E.Message);
    on E: Exception do
      ShowMessage('Erro n�o esperado: ' + E.Message);
  end;
end;

procedure TForm1.ReadFile(const FileName: string);
var
  FileStream: TFileStream;
  Buffer: TBytes;
begin
  if not FileExists(FileName) then
    raise EFileNotFoundException.Create('Arquivo n�o encontrado: ' + FileName);

  FileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    try
      SetLength(Buffer, FileStream.Size);
      FileStream.ReadBuffer(Buffer, FileStream.Size);
      ShowMessage('Arquivo lido com sucesso');
    except
      on E: EFileNotFoundException do //Trata a exce��o personalizada
        ShowMessage('Erro de arquivo: ' + E.Message);
      on E: Exception do  //Trata exce��es em geral
        ShowMessage('Erro geral: ' + E.Message);
    end;
  finally
    FileStream.Free;
  end;
end;

end.
