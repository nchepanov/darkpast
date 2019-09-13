unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,Math, Spin, Menus, Buttons, TeEngine, Series,
  TeeProcs, Chart;

type

  TForm1 = class(TForm)
    Timer2: TTimer;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    BitBtn3: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Chart1: TChart;
    Series1: TBarSeries;
    Chart2: TChart;
    BarSeries1: TBarSeries;
    Chart3: TChart;
    BarSeries2: TBarSeries;
    Chart4: TChart;
    BarSeries3: TBarSeries;
    N3: TMenuItem;
    N4: TMenuItem;
    N9: TMenuItem;
    Button3: TButton;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
  const maxline = 6;
        carmax = 100000;
  type Tcarlink = array[1..2,1..maxline] of integer;
  type
   car = record
   x,prevx,v,a,tr,t0,t1,l,s:real;
   m:integer;
   log:Tcarlink;
   agr:integer;
   shadow:integer;
   lx:real;
   tang:real;
   v0:real;
   end;
var
  Form1: TForm1;
  g:real = 9.8;
   line:integer=5;
   ro:integer=20;   {Плотность маш/(км*полосу)}
   n:integer;        {кол-во машин на одной полосе}
   mu:real = 0.8;      {трение}
   reakt:real =0.3;     {время реакции}
   ss:integer=600;    {100}                  {длина трассы}
   dt:real=0.03;
  t1:real=600;          {время при столкновении}
   d:real=3; {РАсстояние между полосами}
  m:array[1..carmax] of car;      {все машины}

   go,run:boolean;    {условие продолжения моделирвоания}
   q1:integer=1;        //отношение 1-агр
   q2:integer=6;        // 2- средний
   q3:integer=3;        // 3 - осторожный

   t,summaV,dv,atek:double;
   minS:array[1..3,1..5] of real;
   w:integer;
 c:TBitMap;
 art:boolean;         {далее рисование}
 xc,yc,y0,nbar:integer;
 dmax:integer;
 lbar,dbar,lbarmax,space:real;
 top:integer=0;
 px,dtn:real;
//-------статистические пепеременные
 vsr1,vsr2,vsr3,vsr,vall1,vall2,vall3,vall:double;
 vsrp1,vsrp2,vsrp3,vsrp,vpall1,vpall2,vpall3,vpall:double;
 vsrline,vallline:array[1..maxline] of double;
 nline:array[1..maxline] of integer;
 nagrline:array[1..3,1..maxline] of integer;
 n1,n2,n3:integer;
implementation

{$R *.dfm}
uses Unit2,Unit3;

//c2 обогнала с1
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

procedure Paintcar(i:integer);   //отрисовка i-ой машины
var ntek:integer;
begin
c.Canvas.Pen.Width :=2;
ntek := floor(m[i].x/lbar);
 with c do
   begin
   if m[i].tang> 0 then Canvas.brush.Color := clGreen else Canvas.brush.Color := clMoneyGreen;
    if m[i].t0 <> 0 then Canvas.brush.Color := clRed;
     canvas.Brush.Style := bsSolid;
     Canvas.Pen.Color := clBlack;
     canvas.Rectangle(Round((frac(m[i].x/lbar)*lbar-m[i].l/2)*px),    top+Round((m[i].m*d-1.5/2-d/2-m[i].lx*sign(m[i].m-m[i].shadow)+ntek*(dbar+space))*px),Round((frac(m[i].x/lbar)*lbar+ m[i].l/2)*px),top+Round((m[i].m*d+1.5/2-d/2-m[i].lx*sign(m[i].m-m[i].shadow)+ntek*(dbar+space))*px));
  { if m[i].tang > 0 then
     begin
      c.Canvas.Pen.Width :=1;
      canvas.Moveto(Round(m[i].x*px),top+ Round((m[i].m*d-d/2)*px));
      Canvas.LineTo(Round((m[i].x+d/m[i].tang)*px),top+ Round((m[i].shadow*d-d/2)*px));
     end;
//-----------ссылки-------------
  {     c.Canvas.Pen.Width :=1;
        for k := 1 to line do
           begin
           if (k <> m[i].m) and (i=(line div 2)*n + n div 2)  then
           begin
            if m[i].x < m[m[i].log[1,k]].x then
             begin
            canvas.Moveto(Round(m[i].x*px),top+ Round((m[i].m*d-d/2)*px));
            Canvas.LineTo(Round(m[m[i].log[1,k]].x*px),top+ Round((k*d-d/2)*px));
             end
            else
             begin
            canvas.Moveto(Round(m[i].x*px),top+ Round((m[i].m*d-d/2)*px));
            Canvas.LineTo(Round((m[m[i].log[1,k]].x+ss)*px),top+ Round((k*d-d/2)*px));
             end;
           canvas.Moveto(Round(m[i].x*px),top+ Round((m[i].m*d-d/2)*px));
            Canvas.LineTo(Round(m[m[i].log[2,k]].x*px),top+ Round((k*d-d/2)*px));
            end;
           end;           
//-----------ссылки-------------}
         end;
end;

procedure paintroad; //прорисовка дороги
var i,j,k:integer;
begin
   c.Canvas.Pen.Width :=1;
   c.canvas.Brush.Color := clLtGray;
 for k := 1 to nbar-1 do
    begin
    c.canvas.Rectangle(0,top+Round((dbar*k+space*(k-1))*px),c.Width+1,top+1+Round((dbar+space)*k*px));
    end;
    c.Canvas.Pen.Color := clBlack;
    c.canvas.Brush.Color := clWhite;
    for k := 1 to nbar do
    begin
      for j := 1 to line +1 do
       begin
         c.Canvas.MoveTo(0,top + Round(((dbar+space)*(k-1)+(j-1)*d)*px));
         c.Canvas.LineTo(c.Width,top + Round(((dbar+space)*(k-1)+(j-1)*d)*px));
       end;
     end;
    Form1.Canvas.Draw(0,y0,c);
    c.Canvas.FillRect(c.canvas.ClipRect);
    Form1.label1.Caption := 't = '+FormatFloat('######0.000',t)+' c' ;
    art := false;
//-----------------Chart1---------------
    vsr := vall/(n*line);
if n1 <> 0 then  vsr1 := vall1/n1 else vsr1 := 0;
if n2 <> 0 then  vsr2 := vall2/n2 else vsr2 := 0;             //*18/5;
if n3 <> 0 then  vsr3 := vall3/n3 else vsr3 := 0;
    Form1.Chart1.Series[0].YValue[0] := vsr3*100;
    Form1.Chart1.Series[0].YValue[1] := vsr2*100;
    Form1.Chart1.Series[0].YValue[2] := vsr1*100;
    Form1.Chart1.Series[0].YValue[3] := vsr*100;
    vall1 := 0;
    vall2 := 0;
    vall3 := 0;
    vall := 0;
//-----------------Chart2--------------
    vsrp := vpall/(n*line);
if n1 <> 0 then  vsrp1 := vpall1/n1 else vsrp1 := 0;
if n2 <> 0 then  vsrp2 := vpall2/n2 else vsrp2 := 0;
if n3 <> 0 then  vsrp3 := vpall3/n3 else vsrp3 := 0;
    Form1.Chart2.Series[0].YValue[0] := vsrp3*100;
    Form1.Chart2.Series[0].YValue[1] := vsrp2*100;
    Form1.Chart2.Series[0].YValue[2] := vsrp1*100;
    Form1.Chart2.Series[0].YValue[3] := vsrp*100;
    vpall1 := 0;
    vpall2 := 0;
    vpall3 := 0;
    vpall := 0;
//-----------------Chart3--------------
  for i := 1 to line do
   begin
    if nline[i] <> 0 then vsrline[i] := vallline[i]/nline[i] else vsrline[i] := 0;
    Form1.Chart3.Series[0].YValue[i-1] := vsrline[i]*18/5;
   end;
  fillchar(nline,sizeof(nline),0);
  fillchar(vallline,sizeof(vallline),0);
//-----------------Chart4--------------
   Form1.Chart4.Series[0].Clear;
    for i := 1 to line do
   begin
    Form1.Chart4.Series[0].AddXy(i,nagrline[1,i]+nagrline[2,i]+nagrline[3,i],'',clRed);
    Form1.Chart4.Series[0].Addxy(i,nagrline[2,i]+nagrline[3,i],'',clGray);
    Form1.Chart4.Series[0].Addxy(i,nagrline[3,i],'',clGreen);
   end;
   FillChar(nagrline[1],sizeof(nagrline[1]),0);
   FillChar(nagrline[2],sizeof(nagrline[2]),0);
   FillChar(nagrline[3],sizeof(nagrline[3]),0);
end;


procedure Simulation;         //симуляция
var i,i1,k:integer;
     dx,s,sm:Real;
begin
 {  while go do    for i0 := 1 to 10 do
  begin     }
  go := false;
  dt:=dtn;
  n1:=0;n2:=0;n3:=0;
  for i := 1 to n*line do  //цикл по машинам
    begin
//-------------статистические рассчеты-----------
  vall := vall + m[i].v/m[i].v0;  //изменение общей удовлетворенности ездой  в данный момент
  vpall := vpall + m[i].s/t/m[i].v0;  //изменение общей удовлетворенности ездой  вообще
  vallline[m[i].m] := vallline[m[i].m] + m[i].v; // изменение текущей скорости полосы
  INC(nline[m[i].m]); //рассчет количества машин на каждой полосе
  INC(nagrline[m[i].agr,m[i].m]); //количество машин на полосах по агрессивности
  case m[i].agr of
    1:
    begin
     vall1 := vall1 + m[i].v/m[i].v0;  // рассчет удовлетворенности скорсотью
     vpall1 := vpall1 + m[i].s/t/m[i].v0;  // рассчет удовлетворенности путевой скоростью
     inc(n1);                             //количество машин данного типа
    end;
  2:
    begin
     vall2 := vall2 + m[i].v/m[i].v0;
     vpall2 := vpall2 + m[i].s/t/m[i].v0;
     inc(n2);
    end;
  3:
    begin
     vall3 := vall3 + m[i].v/m[i].v0;
     vpall3 := vpall3 + m[i].s/t/m[i].v0;
     inc(n3)
    end;
  end;
//-------------статистические рассчеты----------- }
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
//---------------------Начало блока отрисовки-------------------
      if art then
       begin
        Paintcar(i);
       end;
                    {Конец блока отрисовки}
  end;//endfor

  for i := 1 to n*line do
   begin                   //изменить все ссылки
   Change(i);
   end;
  t := t + dt;   //время
  Application.ProcessMessages;  //чтобы комп не зависал
 {Вывод графики------------------------------------------------------}
 if art then
   begin
     paintroad;
   end;
{Конец вывода графики-----------------------------------------------}
       go := true;
 { end; конец цикла while}
end;


procedure TForm1.FormCreate(Sender: TObject);
var spacegraph:integer;
begin
Form1.Height:= screen.WorkAreaHeight;    //
Form1.Width:= screen.WorkAreaWidth;      //
Form1.Top := 0;   Form1.Left := 0;       //
y0:=2*BitBtn1.Top+BitBtn1.Height ; //
c := TBitMap.Create;                     // Инициализация графики
c.width:=Form1.ClientWidth;           //
c.height:=Form1.ClientHeight-y0;         //
xc := c.width div 2;                     //
yc := c.height div 2;                    //
             //Конец инициализации графики
//1-мин расст в пробке 2-угловой коэфф    3-Ускорение          4-торможение       5-разница в скоростях
minS[1,1] := 1;        minS[1,2] := 0.21;  minS[1,3] := 4.63;  minS[1,4] := 4.63; minS[1,5] := 3.5;  //1- лихач
minS[2,1] := 1.81;     minS[2,2] := 0.255; minS[2,3] := 3.18;  minS[2,4] := 3.31; minS[2,5] := 5;  //2-средний
minS[3,1] := 3;        minS[3,2] := 0.35;  minS[3,3] := 1.39;  minS[3,4] := 1.74; minS[3,5] := 8;  //3-тихоня
go := false;
randomize();
dtn := dt;
Chart1.Width := 270 * Form1.ClientWidth div 1250 ;
Chart2.Width := 270* Form1.ClientWidth div 1250 ;
Chart3.Width := 350* Form1.ClientWidth div 1250 ;
Chart4.Width := 250* Form1.ClientWidth div 1250 ;
 Chart1.Height := Chart1.Width;
 Chart2.Height := Chart1.Width;
 Chart3.Height := Chart1.Width;
 Chart4.Height := Chart1.Width;
Chart1.Top := Form1.ClientHeight - Chart1.Height - 5;
Chart2.Top := Form1.ClientHeight - Chart2.Height - 5;
Chart3.Top := Form1.ClientHeight - Chart3.Height - 5;
Chart4.Top := Form1.ClientHeight - Chart4.Height - 5;
 spacegraph := 140* Form1.ClientWidth div 1250 div 5;
Chart1.Left := spacegraph div 2;
Chart2.Left := 1*spacegraph+Chart1.Width+spacegraph div 2;
Chart3.Left := 2*spacegraph+Chart1.Width+Chart2.Width+spacegraph div 2;
Chart4.Left := 3*spacegraph+Chart1.Width+Chart2.Width+Chart3.Width+spacegraph div 2;    
fillchar(vsrline,Sizeof(vsrline),0);
chart1.Series[0].AddXY(0,0,'осторожн.',clGreen);
chart1.Series[0].AddXY(1,0,'средн.',clGray);
chart1.Series[0].AddXY(2,0,'агр.',clRed);
chart1.Series[0].AddXY(3,0,'все',clBlack);
chart2.Series[0].AddXY(0,0,'осторожн.',clGreen);
chart2.Series[0].AddXY(1,0,'средн.',clGray);
chart2.Series[0].AddXY(2,0,'агр.',clRed);
chart2.Series[0].AddXY(3,0,'все',clBlack);
Initialize;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
art:=true;
if  go then Simulation;

end;



procedure TForm1.BitBtn1Click(Sender: TObject);
begin
go := true;
Timer2.Enabled := true;
BitBtn1.Enabled := false;
BitBtn2.Enabled := true ;
BitBtn5.Enabled := true;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
Timer2.Enabled := false;
Form2.line1.Value := Unit1.line;
Form2.ss1.Text := inttostr(Unit1.ss);
Form2.ro1.Text := inttostr(Unit1.ro);
Form2.mu1.Text := formatfloat('0.##',Unit1.mu);
Form2.tr1.Text := formatfloat('#0.##',Unit1.reakt);
Form2.a1.Text := inttostr(q1);
Form2.a2.Text := inttostr(q2);
Form2.a3.Text := inttostr(q3);
 Form2.ShowModal;
if Unit2.formresult then
 begin
  Unit2.formresult := false;
  Initialize;
  Form1.Canvas.Brush.Color := clBtnFace;
  Form1.Canvas.Rectangle(-1,-1,10000,10000);
  paintroad;
   if not BitBtn1.Enabled then
    begin
     go := true;
     Timer2.Enabled := true;
     BitBtn1.Enabled := false;
     BitBtn2.Enabled := true ;
    end
   else
    begin
     go :=false;
     Timer2.Enabled := false;
     BitBtn1.Enabled := true ;
     BitBtn2.Enabled := false;
    end;
Timer2.Enabled := true;
 end else
 begin
  if BitBtn1.Enabled then
    begin

    end
   else
    begin
     Timer2.Enabled := true;
    end;
 end;
end;

procedure TForm1.FormPaint(Sender: TObject);
var i:integer;
begin
if not Timer2.Enabled then
begin
for i := 1 to n*line do paintcar(i);
paintroad;
end;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
BitBtn1.Click;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
 BitBtn2.Click;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
dtn := dt * 1.1;
if dtn > 0.2 then dtn:= 0.2
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
dtn := dt*0.9;
if dtn < 0.00001 then dtn := 0.00001;
end;



procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  go :=false;
  Timer2.Enabled := false;
  BitBtn1.Enabled := true ;
  BitBtn2.Enabled := false;
  BitBtn5.Enabled := false;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
Timer2.Enabled := false;
Close;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
Timer2.Enabled := false;
Form3.line1.Value := Unit1.line;
Form3.ss1.Text := inttostr(Unit1.ss);
Form3.ro1.Text := inttostr(Unit1.ro);
Form3.mu1.Text := formatfloat('0.##',Unit1.mu);
Form3.tr1.Text := formatfloat('#0.##',Unit1.reakt);
Form3.a1.Text := inttostr(q1);
Form3.a2.Text := inttostr(q2);
Form3.a3.Text := inttostr(q3);
 if not Form1.BitBtn1.Enabled  then Form1.BitBtn2.OnClick(nil);
Form3.ShowModal;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
if Timer2.Enabled then
begin
Timer2.Enabled := false;
Initialize;
Timer2.Enabled := true;
end else
begin
Initialize;
Form1.OnPaint(nil);
end;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
var tt:real;
begin
if run then run := false
else
begin
if Timer2.Enabled then
begin
Form1.BitBtn4.Enabled := false;
Form1.BitBtn3.Enabled := false;
Form1.BitBtn2.Enabled := false;
Form1.Button3.Enabled := false;
Timer2.Enabled := false;
Form1.BitBtn5.Caption := 'stop';
run := true;
while run do
begin
art := true;
//Application.ProcessMessages;
simulation;
end;
Timer2.Enabled := true;
Form1.BitBtn4.Enabled := true;
Form1.BitBtn3.Enabled := true;
Form1.BitBtn2.Enabled := true;
Form1.Button3.Enabled := true;
Form1.BitBtn5.Caption := '>>';
end;
end;
end;

end.

