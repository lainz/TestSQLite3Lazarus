unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLite3Conn, SQLDB, DB, Forms, Controls, Graphics, Dialogs,
  DBGrids, DBCtrls, StdCtrls;

type

  { TEmulador }

  TEmulador = class(TSQLQuery)
  private
    function GetNombre: string;
    procedure SetNombre(AValue: string);
  public
    property nombre: string read GetNombre write SetNombre;
  end;

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Edit1: TEdit;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TEmulador }

function TEmulador.GetNombre: string;
begin
  Result := FieldByName('nombre').AsString;
end;

procedure TEmulador.SetNombre(AValue: string);
begin
  FieldByName('nombre').AsString := AValue;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit1.Text := TEmulador(SQLQuery1).nombre;
  Edit1.Visible := True;
  Button2.Visible := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  SQLQuery1.Edit;
  TEmulador(SQLQuery1).nombre := Edit1.Text;
  SQLQuery1.Post;
  Edit1.Visible := False;
  Button2.Visible := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SQLite3Connection1.DatabaseName := Application.Location + 'lainz.sqlite';
  SQLite3Connection1.Connected := True;
  SQLite3Connection1.ExecuteDirect(
    'CREATE TABLE IF NOT EXISTS emuladores(id int, nombre varchar(50));');
  SQLTransaction1.Commit;
  SQLQuery1.Active := True;
end;

{procedure TForm1.SQLQuery1AfterPost(DataSet: TDataSet);
begin
  SQLQuery1.ApplyUpdates; <- sqoAutoApplyUpdates
  SQLTransaction1.Commit; <- Options sqoAutoCommit
  UpdateMode <- upWhereAll (prevents error that there is nothing to commit)
  SQLQuery1.Open; <- sqoKeepOpenOnCommit
end;}

end.
