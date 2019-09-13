unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart,
  Spin, ActnMan, ActnColorMaps;

type
  TForm3 = class(TForm)
    Chart1: TChart;
    Series1: TFastLineSeries;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    GroupBox1: TGroupBox;
    labelline: TLabel;
    labelSS: TLabel;
    labelro: TLabel;
    Labelmu: TLabel;
    labelTR: TLabel;
    agr: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    ss1: TEdit;
    line1: TSpinEdit;
    ro1: TEdit;
    mu1: TEdit;
    tr1: TEdit;
    a1: TEdit;
    a2: TEdit;
    a3: TEdit;
    Shape1: TShape;
    Shape2: TShape;
    Series2: TFastLineSeries;
    Series3: TFastLineSeries;
    Series4: TFastLineSeries;
    Timer1: TTimer;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure ss1KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure mu1KeyPress(Sender: TObject; var Key: Char);
    procedure Timer1Timer(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  vsrp1,vsrp2,vsrp3,vsrp,vpall1,vpall2,vpall3,vpall:double;
  tmax:integer = 300;
implementation
  uses Unit1;
{$R *.dfm}

procedure TForm3.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if not ((pos(key,'0123456789,.')>0) or (key = #8)) then key := #0 else
 begin
  if key = '.' then key := ',';
 end;
end;

procedure TForm3.FormCreate(Sender: TObject);
var d:integer;
begin
Form3.Height:= screen.WorkAreaHeight;
Form3.Width:= screen.WorkAreaWidth;
Form3.Top := 0;   Form3.Left := 0;
d := (Form3.ClientWidth - Edit3.Left - Edit3.Width) div 2;
Button1.Left := Button1.Left + d;
ComboBox1.Left := ComboBox1.Left  +d;
Edit1.Left := Edit1.Left + d;
Edit2.Left := Edit2.Left + d;
Edit3.Left := Edit3.Left + d;
Label1.Left := label1.Left + d;
Label2.Left := label2.Left + d;
Label3.Left := label3.Left + d;
Label4.Left := label4.Left + d;
GroupBox1.Left := (Form3.ClientWidth-GroupBox1.Width) div 2;
Chart1.Height := Form3.ClientHeight - Groupbox1.Height - Groupbox1.Top - 10;
Form3.ComboBox1Change(sender);
end;

procedure TForm3.ss1KeyPress(Sender: TObject; var Key: Char);
begin
if not ((pos(key,'0123456789')>0) or (key = #8)) then key := #0 ;
end;

procedure alltrue;
begin
with Form3 do
 begin
   labelline.Enabled := true;
   line1.Enabled := true;
   labelss.Enabled := true;
   ss1.Enabled := true;
   labelro.Enabled := true;
   ro1.Enabled := true;
   labelmu.Enabled := true;
   mu1.Enabled := true;
   labeltr.Enabled := true;
   tr1.Enabled := true;
 end;
end;

procedure TForm3.ComboBox1Change(Sender: TObject);
begin
case ComboBox1.ItemIndex of
 0:
  begin           alltrue;
   labelline.Enabled := false;
   line1.Enabled := false;
   Edit1.Text := '1';
   Edit2.Text := '6';
   Edit3.Text := '1';
  end;
 1:
  begin           alltrue;
   labelss.Enabled := false;
   ss1.Enabled := false;
   Edit1.Text := '1000';
   Edit2.Text := '5000';
   Edit3.Text := '100';
  end;
 2:
  begin           alltrue;
   labelro.Enabled := false;
   ro1.Enabled := false;
   Edit1.Text := '30';
   Edit2.Text := '100';
   Edit3.Text := '5';
  end;
 3:
  begin           alltrue;
   labelmu.Enabled := false;
   mu1.Enabled := false;
   Edit1.Text := '0,4';
   Edit2.Text := '0,9';
   Edit3.Text := '0,05';
  end;
 4:
  begin           alltrue;
   labeltr.Enabled := false;
   tr1.Enabled := false;
   Edit1.Text := '0,1';
   Edit2.Text := '1';
   Edit3.Text := '0,05';
  end;
 end;
end;


function obgon(c1,c2:integer):boolean; //Процедура проверки был ли обгон
begin
result  := false;
 if (abs(m[c2].x - m[c2].prevx) <= 40*dt) //если расстояние характерное
  then
    begin
    if (m[c2].x >= m[c1].x) and (m[c2].prevx <= m[c1].x) then result:=true
   end
  else    //если был переход через критическую точку, то условие немного другое
   begin
    if (((m[c2].x <=m[c1].x)and(m[c2].prevx <=m[c1].x))OR ((m[c2].x >=m[c1].x)and(m[c2].prevx >=m[c1].x))) then  result:=true;
   end;
   if m[c2].x = m[c2].prevx then result := false;  //если не было перемещения то не было и обгона
   if (c2=0) or (c1=0) then result := false;
end;

function dist(x1,x2:real):real;   //пусть машина 1 дальше машины 2, тогда это расстояние между ними
begin
result := x1-x2;
if result < 0 then  result:= result + ss;
end;

//инициализация ссылок

procedure InitLinks;
var i,j:integer;
begin
for i := 1 to  n*line do fillchar(m[i].log,Sizeof(m[i].log),0);
for i := 1 to  n*line do
  begin
    for j := 1 to  n*line do
     begin
      if j <> i then
        begin
            if m[i].log[1,m[j].m] = 0 then  m[i].log[1,m[j].m] := j;
            if m[i].log[2,m[j].m] = 0 then  m[i].log[2,m[j].m] := j;
              if dist(m[i].x,m[m[i].log[2,m[j].m]].x) >= dist(m[i].x,m[j].x) then   m[i].log[2,m[j].m]  := j;
              if dist(m[m[i].log[1,m[j].m]].x,m[i].x) > dist(m[j].x,m[i].x) then   m[i].log[1,m[j].m]  := j;
          if m[j].tang > 0 then
           begin
             if m[i].log[1,m[j].shadow] = 0 then  m[i].log[1,m[j].shadow] := j;
             if m[i].log[2,m[j].shadow] = 0 then  m[i].log[2,m[j].shadow] := j;
              if dist(m[i].x,m[m[i].log[2,m[j].shadow]].x) >= dist(m[i].x,m[j].x) then   m[i].log[2,m[j].shadow]  := j;
              if dist(m[m[i].log[1,m[j].shadow]].x,m[i].x) > dist(m[j].x,m[i].x) then   m[i].log[1,m[j].shadow]  := j;
           end;
        end;
     end;
  end;
end;


//Инициализация всего
procedure Initialize;
var i,j,k,o,u,p1,p2,p3,pall1,pall2,pall3:integer;
    l,dl:real;
begin
randomize;
n1 := 0; n2:=0;n3:=0;
 n := Round(ro*ss/1000);//рассчет кол-ва машин на одной полосе
 if n < 4  then n := 4;
 // ------------Инициализация графики
 dmax := Form1.Chart1.Top - 3*Form1.BitBtn1.Top-Form1.BitBtn1.Height;  //рассчет масштабирования
 lbarmax := 100;
 repeat
  begin
  nbar := Round(ss/lbarmax); if nbar=0 then nbar := 1;
 lbar := ss/nbar ;
 space := line*d *2/ 3;
 dbar := line*d;
 px := c.Width / lbar;   //коэффициент рисования
 lbarmax:=lbarmax+1;
  end
 until (dbar*nbar+(nbar-1)*space)*px+1 < dmax;
 c.height:=Round((dbar*nbar+(nbar-1)*space)*px+1)+top;
 y0 := Form1.BitBtn1.Height+Form1.BitBtn1.Top+(Form1.Chart1.Top- Form1.BitBtn1.Height-Form1.BitBtn1.Top-c.Height) div 2;
 l :=  (ss)/n; //5 + random*2; //расстояние между машиными

p1 := 0; p2 := 0; p3 := 0;
pall1 := 0; pall2 := 0; pall3 := 0;
 if n <= 1 then n :=2;
 pall1 := Round(n*line*q1 / (q1+q2+q3));
 pall3 := Round(n*line*q3 / (q1+q2+q3));
 pall2 := n*line-pall1-pall3;
if pall2 < 0 then pall2 := 0;
//---------------------цикл по машинам на полосе
 for j := 1 to line do    //цикл по полосам
  begin
 dl := random(ss);       //смещение между машинами разных полос
for i := 1 to n do
 begin

  k := (j-1)*n+i;     //номер машины в общем массиве
  m[k].l := 3+random*2;  //длина машины
   m[k].x := (i-1)*l+dl; //координата
  if l - 5 > 0 then m[k].x := m[k].x - random(round(l-5));
   if m[k].x > ss then m[k].x := m[k].x - ss;
{if i <> 1 then    := m[(j-1)*n+i-1].x + 0.2*l+random*l*0.8+ (m[(j-1)*n+i-1].l + m[k].l) / 2
          else  m[k].x := 0.2*l+random*l*0.8;  }
  m[k].v := 0;     //скорость
  m[k].s := 0;     //путь
  m[k].tr := reakt*random;  //время реакции
  m[k].t0 := 0;     //Время в пробке
  m[k].t1 := 0;
  m[k].agr := 0;
    while  not ((m[k].agr=1) or (m[k].agr=2) or (m[k].agr=3)) do
    begin
    u := random(3)+1;
    case u of
    1:if p1 <=pall1 then
      begin
       m[k].agr := u;
       inc(p1);inc(n1);
      end;
    2:if p2 <=pall2 then
      begin
       m[k].agr := u;
       inc(p2); inc(n2);
      end;
    3:if p3 <=pall3 then
      begin
       m[k].agr := u;
       inc(p3); inc(n3);
      end;
    end;
   end;

  m[k].m := j;       //номер полосы
  m[k].shadow := 0;
  m[k].lx := -0.00001;
  m[k].tang :=0;          //тангенс угла поворота
  m[k].v0 := (60 + 10*random(8))*5/18; //желаемая скорость
 end;
end;
 t := dt;
 InitLinks;
 Form1.Chart3.Series[0].Clear;
 for i := 1 to line do
  begin
   Form1.Chart3.Series[0].AddXY(i,0);
   Form1.Chart4.Series[0].AddxY(i,0);
   Form1.Chart4.Series[0].AddxY(i,0);
   Form1.Chart4.Series[0].AddxY(i,0);
  end;
end;


function smin(v:real;a:integer):real;
begin
 result := mins[a,1]+mins[a,2]*abs(v)*18/5;
end;

procedure Change(i:integer);   {процедура перемены ссылок при обгоне}
var j,a0,a1:integer;
 begin
   for j := 1 to line do    {цикл по передним машинам}
    begin
     if (m[i].log[1,j]<>0)  and (m[i].log[2,j]<>0) then
     begin
     if (obgon(m[i].log[1,j],i))  then
      begin
      a0 := i;   {я}
      a1 := m[i].log[1,j];  {впередиидущая машина}
      m[a0].log[2,j] := m[a0].log[1,j];        {задняя стала передней}
      m[a0].log[1,j] := m[a1].log[1,j]; {передней стала та которая впереди у той которую обогнали}
      m[a1].log[1,m[a0].m]:= m[a1].log[2,m[a0].m];
      m[a1].log[2,m[a0].m] := m[a0].log[2,m[a0].m];
      end;
    if obgon(i,m[i].log[2,j]) then
      begin
      a0 := i;   {я}
      a1 := m[i].log[2,j];  {позадиидущая машина}
      m[a0].log[1,j] := m[a0].log[2,j];
      m[a0].log[2,j] := m[a1].log[2,j];
      m[a1].log[2,m[a0].m]:= m[a1].log[1,m[a0].m];
      m[a1].log[1,m[a0].m] := m[a0].log[1,m[a0].m];
      end;
     end; 
    end;
 end;

function  GoOtherLine(i,k:integer):boolean;   //Возможно ли перестроение машины i на полосу k
var s1,s2:real;
begin
 result := false;
 s1 := dist(m[m[i].log[1,k]].x,m[i].x) ;
 s2 := dist(m[i].x,m[m[i].log[2,k]].x) ;
 while s1 + s2 > ss do
  begin
    if s1  > s2 then
     s1 := s1 - ss
                else
     s2 := s2 - ss;
  end;
 if (s1 >(m[i].l + m[m[i].log[1,k]].l)/2+smin(m[i].v,m[i].agr)) and (s2 >(m[i].l + m[m[i].log[2,k]].l)/2+1.5*smin(m[m[i].log[2,k]].v,2))
 then result := true;
 if (m[i].log[1,k] = 0)  and (m[i].log[2,k] = 0) then result := true;
 if (m[i].x + m[i].l/2 < m[m[i].log[1,k]].x +m[m[i].log[1,k]].l/2) and (m[i].x + m[i].l/2 > m[m[i].log[1,k]].x -m[m[i].log[1,k]].l/2) then result := false;
end;

function Xdistance(i:integer):real;  //расстояние необходимое дял обгона передней машины от i
var t,s,v:real;
begin
if m[i].log[1,m[i].m] = i then result := ss else
begin
 v := m[i].v - m[m[i].log[1,m[i].m]].v;
 s := dist(m[m[i].log[1,m[i].m]].x,m[i].x) + smin(m[m[i].log[1,m[i].m]].v,m[i].agr) -m[i].l;
 t := (-v+sqrt(sqr(v)+2*minS[m[i].agr,3]*s))/minS[m[i].agr,3];
 result := m[i].v*t+ minS[m[i].agr,3]*t*t/2;
end;
end;


function tangens(i:integer):real; //тангенс угла поворота
var r:real;
begin
r := sqr(m[i].v)/mu/g;
if r <0.35*d then r := 0.35*d;  //минимальный радиус повортота равен 0,35*(ширина полосы)
result := d/(2*sqrt(d*(r-d/4)));
end;


procedure Simulation;         //симуляция
var i,i1,k:integer;
     dx,s,sm:Real;
begin

  go := false;
  dt:=dtn;
  for i := 1 to n*line do
   begin
   dx := m[i].v*dt;       //перемещение
   m[i].prevx := m[i].x;    //предыдущая координата
      m[i].x := m[i].x + dx;    //изменение координаты
      m[i].s := m[i].s + dx;     //изменение пути
  //если перестроение
   if (m[i].tang > 0) and (m[i].t0 <=0) then
    begin
    m[i].tang := tangens(i);
    m[i].lx := m[i].lx + m[i].tang*dx;
    if dx = 0 then m[i].lx := m[i].lx+m[i].tang*0.008;
      if m[i].lx > d then
       begin
         for k := 1 to n*line do
          begin
          if m[i].log[1,m[i].m] <> m[i].log[2,m[i].m] then
           begin
           if m[k].log[1,m[i].m] = i then m[k].log[1,m[i].m] := m[i].log[1,m[i].m];
           if m[k].log[2,m[i].m] = i then m[k].log[2,m[i].m] := m[i].log[2,m[i].m];
           end
          else
           begin
            m[i].log[1,m[i].m] := 0;
            m[i].log[2,m[i].m] := 0;
           end;
          end;
         m[i].m:=m[i].shadow;
         m[i].shadow := -1;
         m[i].tang := 0;
         m[i].lx := -0.0001;
       end;
    end;
    //конец перестроения
      if m[i].x >= ss then m[i].x := m[i].x -ss; {проверка на критический переход}
 {Номер впередиидущей машины}
   if m[i].lx < d/2 then i1 := m[i].log[1,m[i].m] else i1 := m[i].log[1,m[i].shadow];
   if (m[m[i].log[2,m[i].m]].v0-minS[2,5] > m[i].v0) and  (dist(m[m[i].log[1,m[i].m]].x,m[i].x)>2*smin(m[i].v,2)) then m[i].t1 := m[i].t1 + dt else m[i].t1 := 0;
   if m[i1].x < m[i].x then
   s := m[i1].x+ss-m[i].x-(m[i].l+m[i1].l)/2 else s := m[i1].x-m[i].x-(m[i].l+m[i1].l)/2; {рассчет расстояния между машинами}
   sm := smin(m[i].v,m[i].agr); {рассчет эс минимальное}
{---Начало блока ЛОГИКА ВОДИТЕЛЯ---------}
 if m[i].t0 = 0 then
    begin
       if (s < 0) then
        begin
            if m[i1].t0 = 0 then
               begin
                m[i1].t0 := t1;
                m[i].t0 := t1+10;
                atek:= m[i].v*0.5; m[i].v := m[i1].v*0.5; m[i1].v := atek; 
               end //atek используется в качестве буфера
              else
               begin
                m[i].t0 := m[i1].t0+10;
                m[i].v := 0;
               end;
          atek := -0.8*g;
        end ELSE
        begin
         if m[i].tr <= 0 then
          begin
            m[i].tr := reakt;
//--------------Алгоритм перестроения-------------      and (m[i].v + minS[m[i].agr,5] <= m[i].v0)
            if (m[i].tang <= 0)  then
            begin
              for k := m[i].m-1 to m[i].m +1 do
               begin
                if (k > 0) and (k <=line) and (k <> m[i].m) and (m[i].tang <= 0) then
                 begin
                  if (m[i].m<k) then
                   begin
                    if GoOtherLine(i,k) then
                     begin
                      if ((m[m[i].log[1,k]].v- minS[m[i].agr,5] > m[i].v) or (dist(m[m[i].log[1,k]].x,m[i].x) - m[i].l - m[m[i].log[1,k]].l   >= Xdistance(i)))
                         OR (m[i].t1 > 20) then
                       begin
                        m[i].tang := tangens(i);
                        m[i].lx := 0;
                        m[i].shadow := k;
                        Initlinks;
                       end;
                   end;
                   end

                    else
                   begin
                  if GoOtherLine(i,k) then
                   begin
                     if (abs(m[m[i].log[1,k]].v-m[i].v0)+ minS[m[i].agr,5] < abs(m[m[i].log[1,m[i].m]].v-m[i].v0))
                      OR (dist(m[m[i].log[1,k]].x,m[i].x) - m[i].l - m[m[i].log[1,k]].l   >= Xdistance(i)) then
                      begin
                       m[i].tang := tangens(i);
                       m[i].lx := 0;
                       m[i].shadow := k;
                       Initlinks;
                      end;
                   end;
                  end;

                 end;
               end;
              end;    
//--------------конец перестроения--------------------}
           if s-sm<=0  then atek := -mu*g
           else
            begin
                 if  m[i].v-m[i1].v>0  then
                   begin
                    if  sqr(m[i].v-m[i1].v)/2/(s-sm) > mins[m[i].agr,4] then
                          begin
                       atek := -sqr(m[i].v-m[i1].v)/2/(s-sm);
                       if atek < -mu*g then atek := - mu*g;
                           end ELSE atek :=mins[m[i].agr,3]*(1-sqr(m[i].v/m[i].v0));
                    end  else atek :=  mins[m[i].agr,3]*(1-sqr(m[i].v/m[i].v0));
                if (atek >0) and (s < 4*sm) then atek := atek*s/4/sm;
             end;
          end
           else
            begin
            m[i].tr := m[i].tr-dt;
            atek := m[i].a;
            end;
         end
     end    else
     begin
      atek := -mu*g;
      m[i].t0 := m[i].t0 - dt;
      if m[i].t0 < 0 then m[i].t0 := 0;
     end;
//-------КОНЕЦ АЛГОРИТМА ЛОГИКИ ВОИТЕЛЯ!!! atek=ускорение---------------------------------------------
     m[i].a := atek;
     m[i].v := m[i].v + atek*dt;  //Изменение скорости машины
    if m[i].v < 0 then m[i].v := 0;   //Если затормозили до нуля, то не даем машине поехать назад

  end;//endfor

  for i := 1 to n*line do
   begin                   //изменить все ссылки
   Change(i);
   end;
  t := t + dt;   //время
  go := true;
  end;


procedure TForm3.Button1Click(Sender: TObject);
var min,max,step,tek:real;
    i:integer;
    mytime:string;
begin
//------------------------------------------------------------------------------
Button1.Enabled := false;
ComboBox1.Enabled := false;
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
//------------------------------------------------------------------------------
 Chart1.Series[0].Clear;
 Chart1.Series[1].Clear;
 Chart1.Series[2].Clear;
 Chart1.Series[3].Clear;
 min := strtofloat(Edit1.Text);
 max := strtofloat(Edit2.Text);
 step := strtofloat(Edit3.Text);
 case ComboBox1.ItemIndex of
 0:
 begin
  if min < 1 then min := 1;
  if max >6 then max := 6;
  if step <> 1 then step := 1;
 end;
 1:
 begin
  if min < 500 then min := 500;
  if max >10000 then max := 10000;
 end;
 2:
 begin
  if min <10  then min := 10;
  if max >100 then max := 100;
  if step > 50 then step := 50;
 end;
 3:
  begin
  if min < 0.4 then min := 0.4;
  if max >1 then max := 1;
  if step > 0.2 then step := 0.2;
  end;
 4:
 begin
  if min < dt then min := dt;
  if max >1.5 then max := 1.5;
  if step > 0.2 then step := 0.2;
 end;
 end;
 Progressbar1.Max := 100;
 Progressbar1.min := 0;
 tek := min;
 Chart1.Title.Text.Clear;
 Chart1.Title.Text.Add('Зависимость удовлетворенности средней скоростью от '+ ComboBox1.Text);
 case ComboBox1.ItemIndex of
 0: Chart1.Title.Text.Add('line='+inttostr(line) + ';  S='+inttostr(ss) + ';  ro='+ inttostr(ro)+'; mu='+formatfloat('0.###',mu)+';  Tr='+ formatfloat('0.###',reakt)+';  Cоотношение стилей '+inttostr(q1)+':'+ inttostr(q2)+':'+ inttostr(q3));
 1: Chart1.Title.Text.Add('line='+inttostr(line) + ';  S='+inttostr(ss) + ';  ro='+ inttostr(ro)+'; mu='+formatfloat('0.###',mu)+';  Tr='+ formatfloat('0.###',reakt)+';  Cоотношение стилей '+inttostr(q1)+':'+ inttostr(q2)+':'+ inttostr(q3));
 2: Chart1.Title.Text.Add('line='+inttostr(line) + ';  S='+inttostr(ss) + ';  ro='+ inttostr(ro)+'; mu='+formatfloat('0.###',mu)+';  Tr='+ formatfloat('0.###',reakt)+';  Cоотношение стилей '+inttostr(q1)+':'+ inttostr(q2)+':'+ inttostr(q3));
 3: Chart1.Title.Text.Add('line='+inttostr(line) + ';  S='+inttostr(ss) + ';  ro='+ inttostr(ro)+'; mu='+formatfloat('0.###',mu)+';  Tr='+ formatfloat('0.###',reakt)+';  Cоотношение стилей '+inttostr(q1)+':'+ inttostr(q2)+':'+ inttostr(q3));
 4: Chart1.Title.Text.Add('line='+inttostr(line) + ';  S='+inttostr(ss) + ';  ro='+ inttostr(ro)+'; mu='+formatfloat('0.###',mu)+';  Tr='+ formatfloat('0.###',reakt)+';  Cоотношение стилей '+inttostr(q1)+':'+ inttostr(q2)+':'+ inttostr(q3));
 end;
 
 while tek <= max do
  begin
  case ComboBox1.ItemIndex of
 0:
   line := Round(tek);
 1:
   ss:= round(tek);
 2:
   ro := round(tek);
 3:
  mu := tek;
 4:
  reakt := tek;
 end;
  Initialize;
   while t < tmax do
    begin
    simulation;
    ProgressBar1.Position :=Round((((tek-min-step)*100)/((max-min)*100)+t/tmax*(step*100/((max-min)*100)))*100);
   end;
  Chart1.Repaint;

//-------------статистические рассчеты-----------
  n1:=0;n2:=0;n3:=0;
 vpall1 := 0;
 vpall2 := 0;
 vpall3 := 0;
 vpall := 0;
   for i := 1 to n*line do
    begin
      vpall := vpall + m[i].s/t/m[i].v0;
     case m[i].agr of
      1:
       begin
        inc(n1);                             //количество машин данного типа
        vpall1 := vpall1 + m[i].s/t/m[i].v0;
       end;
      2:
       begin
        inc(n2);
        vpall2 := vpall2 + m[i].s/t/m[i].v0;
       end;
      3:
       begin
        inc(n3);
        vpall3 := vpall3 + m[i].s/t/m[i].v0;
       end;
      end;
    end;
     vsrp := vpall/(n*line);
   if n1 <> 0 then  vsrp1 := vpall1/n1 else vsrp1 := 0;
   if n2 <> 0 then  vsrp2 := vpall2/n2 else vsrp2 := 0;
   if n3 <> 0 then  vsrp3 := vpall3/n3 else vsrp3 := 0;
    Chart1.Series[3].AddXY(tek,vsrp3*100);
    Chart1.Series[2].AddXY(tek,vsrp2*100);
    Chart1.Series[1].AddXY(tek,vsrp1*100);
    Chart1.Series[0].AddXY(tek,vsrp*100);
  tek := tek + step;
  end;
    mytime := TimeToStr(time);
  while pos(':',mytime) > 0 do
   begin
     mytime[pos(':',mytime)] := '-';
   end;
   mytime := mytime + '.bmp';
  Chart1.SaveToBitmapFile(myTime);
Button1.Enabled := true;
ComboBox1.Enabled := true;
Progressbar1.Position := 0;
 end;

procedure TForm3.mu1KeyPress(Sender: TObject; var Key: Char);
begin
if not ((pos(key,'0123456789,.')>0) or (key = #8)) then key := #0 else
 begin
  if key = '.' then key := ',';
 end;
end;



procedure TForm3.Timer1Timer(Sender: TObject);
begin
ProgressBar1.Repaint;
end;

end.
