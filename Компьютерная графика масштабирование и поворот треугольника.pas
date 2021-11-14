uses graphABC;
CONST
PI=arctan(1)*4;
type
pPoint=^tPoint;
tTriangle=array[0..2] of pPoint;
tPoint=record
  x:integer;
  y:integer;
end;

//процедура,создающая псевдослучайный многоугольник
function createRandomTriangle(O:pPoint):tTriangle;
var n:integer;//Rоличество вершин многоугольника
var angle:real;//Углы
var XY:tTriangle;// храним пары точек
var r:integer;//радиус
var i:integer;
begin
  r:=random(30, 120);
  n:=3;
  angle:=0;
  i:=0;
  while (angle<2*PI) and (i<n) do//полный круг
  begin
    new(xy[i]);
    xy[i]^.x:=o^.x+round(r*cos(angle));
    xy[i]^.y:=o^.y+round(r*sin(angle));
    inc(i);
    angle:=angle+ ((2*PI)/n)*random(0.1, 1);
  end;
  i:=0;
  while i<n do
  begin
    line(xy[i]^.x, xy[i]^.y, xy[(i+1) mod n]^.x, xy[(i+1) mod n]^.y);
    inc(i);
  end;
  sleep(2000);
  result:=XY;
end;

//процедура отрисовывает треугольник с заданными координатами
procedure drawTriangle(triangle:tTriangle);
begin
  line(triangle[0]^.x, triangle[0]^.y, triangle[1]^.x, triangle[1]^.y);
  line(triangle[1]^.x, triangle[1]^.y, triangle[2]^.x, triangle[2]^.y);
  line(triangle[2]^.x, triangle[2]^.y, triangle[0]^.x, triangle[0]^.y);
end;

//функция зуммирует треугольник и возвращает измененный треугольник
function zoomTriangle(triangle:tTriangle):tTriangle;
var
  i:integer;
  k:real;
  triangleRes:tTriangle;
begin
  new(triangleRes[0]);
  new(triangleRes[1]);
  new(triangleRes[2]);
  k:=1;
  for i:= 1 to 40 do
  begin
    triangleRes[0]^.x:=round(triangle[0]^.x*k);
    triangleRes[0]^.y:=round(triangle[0]^.y*k);
    triangleRes[1]^.x:=round(triangle[1]^.x*k);
    triangleRes[1]^.y:=round(triangle[1]^.y*k);
    triangleRes[2]^.x:=round(triangle[2]^.x*k);
    triangleRes[2]^.y:=round(triangle[2]^.y*k);
    sleep(1);
    clearwindow;
    drawTriangle(triangleRes);
    k:=k+PI/270;
  end;
  result:=triangleRes;
end;
//функций поворачивает треугольник и возвращает измененный треугольник
function rotationTriangle(triangle:tTriangle):tTriangle;
var angle:real;
    triangleRes:tTriangle;
begin
  new(triangleRes[0]);
  new(triangleRes[1]);
  new(triangleRes[2]);
  angle:=0;
  while (angle<4*PI) do
  begin
    triangleRes[0]^.x:=round(triangle[0]^.x*cos(angle)-triangle[0]^.y*sin(angle));
    triangleRes[0]^.y:=round(triangle[0]^.x*sin(angle)+triangle[0]^.y*cos(angle));
    triangleRes[1]^.x:=round(triangle[1]^.x*cos(angle)-triangle[1]^.y*sin(angle));
    triangleRes[1]^.y:=round(triangle[1]^.x*sin(angle)+triangle[1]^.y*cos(angle));
    triangleRes[2]^.x:=round(triangle[2]^.x*cos(angle)-triangle[2]^.y*sin(angle));
    triangleRes[2]^.y:=round(triangle[2]^.x*sin(angle)+triangle[2]^.y*cos(angle));
    clearwindow;
    drawTriangle(triangleRes);
    angle:=angle+PI/360;
    sleep(3);
  end;
end;

var O:pPoint;//Центр окружности
begin
new(O);
SetCoordinateOrigin(300, 250);
O^.x:=random(0, 100);
O^.y:=random(0, 100);
rotationTriangle(zoomTriangle(createRandomTriangle(O)));
end.