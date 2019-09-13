unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ss1: TEdit;
    line1: TSpinEdit;
    labelline: TLabel;
    labelSS: TLabel;
    labelro: TLabel;
    ro1: TEdit;
    Labelmu: TLabel;
    mu1: TEdit;
    labelTR: TLabel;
    tr1: TEdit;
    agr: TLabel;
    a1: TEdit;
    a2: TEdit;
    Label9: TLabel;
    a3: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    procedure ss1KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ro1KeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  formresult:boolean;
implementation
uses Unit1;
{$R *.dfm}



procedure TForm2.ss1KeyPress(Sender: TObject; var Key: Char);
begin
if not ((pos(key,'0123456789,.')>0) or (key = #8)) then key := #0 else
 begin
  if key = '.' then key := ',';
 end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
Unit1.line:= line1.Value ;
if strtoint(ss1.Text) >= 100 then Unit1.ss:=strtoint(ss1.Text) else
begin
Unit1.ss := 100;
Application.MessageBox('Длина трассы не менее 100 метров','Неверно');
end;
if strtoint(ro1.Text)<=130  then Unit1.ro:=strtoint(ro1.Text) else
begin
Unit1.ro := 130;
Application.MessageBox('Плотность потока не более 130 маш/км','Неверно');
end;
if strtoint(ro1.Text)<=10  then Unit1.ro:=10;

if strtofloat(mu1.Text)<=1  then Unit1.mu:=strtofloat(mu1.Text) else
begin
Unit1.mu := 1;
Application.MessageBox('Коэффициент трения покрытия не менее 1','Неверно');
end;
 if Unit1.mu <0.3 then Unit1.mu := 0.3;

Unit1.reakt:=strtofloat(tr1.Text);
if Unit1.reakt > 1 then
begin
Unit1.reakt := 1;
Application.MessageBox('Время реакции не более секунды','Неверно');
end;
if Unit1.reakt < 0.001 then Unit1.reakt := 0.001;
Unit1.q1:=strtoint(a1.Text);
Unit1.q2:=strtoint(a2.Text) ;
Unit1.q3:=strtoint(a3.Text);

formresult := true;
Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
Form2.Top := (Screen.WorkAreaHeight - Form2.Height) div 2;
Form2.Left := (Screen.WorkAreaWidth - Form2.Width) div 2;

line1.Value := Unit1.line;
ss1.Text := inttostr(Unit1.ss);
ro1.Text := inttostr(Unit1.ro);
mu1.Text := formatfloat('0.##',Unit1.mu);
tr1.Text := formatfloat('#0.##',Unit1.reakt);
a1.Text := inttostr(q1);
a2.Text := inttostr(q2);
a3.Text := inttostr(q3);
end;

procedure TForm2.ro1KeyPress(Sender: TObject; var Key: Char);
begin
if not ((pos(key,'0123456789')>0) or (key = #8)) then key := #0;
end;
procedure TForm2.Button2Click(Sender: TObject);
begin
formresult := false;
Close;
end;

end.
