﻿program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Generics.Collections,
  Math;

type
  TDropItem = class
    Name: String;

    Weight: Single;

    CountMin: Integer;
    CountMax: Integer;
    Counter: Integer;

    constructor Create(AName: String; AWeight: Single; AMin, AMax: Integer);
  end;

function GetItemFromDropSubList2(AWeight: Single; ASubList: TList<TDropItem>; out AItem: TDropItem): Boolean;
var i: Integer;
    W: Single;
begin

  Result := False;

  W := AWeight;

//  Writeln('ww -> ', W:3:3);

  for i := 0 to ASubList.Count - 1 do
    begin

      if ASubList[i].Weight >= W then
        begin
          AItem := ASubList[i];
//          Writeln('OK... ', ASubList[i].Name);
          Result := True;
          Break;
        end

      else
        begin
          W := W - ASubList[i].Weight;
        end;

//      Writeln('WWW   ', ASubList[i].Name, ' -> ', W:3:3);
    end;

//  Writeln('#####');
end;

var
  DropSubList: TList<TDropItem>;
  DropList: TList<TList<TDropItem>>;

  DSI: TList<TDropItem>;
  DI: TDropItem;

  W: Single;

  N: Integer;

  i, j: Integer;

{ TDropItem }

constructor TDropItem.Create(AName: String; AWeight: Single; AMin, AMax: Integer);
begin
  Name := AName;
  Weight := AWeight;
  CountMin := AMin;
  CountMax := AMax;
end;

begin

  Randomize;

  DropList := TList<TList<TDropItem>>.Create;

  DropSubList := TList<TDropItem>.Create;
  DropSubList.Add(TDropItem.Create('Какая-то нужная хрень', 100, 5, 10));
  DropList.Add(DropSubList);

  DropSubList := TList<TDropItem>.Create;
  DropSubList.Add(TDropItem.Create('Денюшка', 75, 1000, 1500));
  DropList.Add(DropSubList);

  DropSubList := TList<TDropItem>.Create;
  DropSubList.Add(TDropItem.Create('Ветка', 50, 1, 7));
  DropSubList.Add(TDropItem.Create('Шкурка', 24, 2, 5));
  DropSubList.Add(TDropItem.Create('Кость', 19.5, 4, 15));
  DropList.Add(DropSubList);

  DropSubList := TList<TDropItem>.Create;
  DropSubList.Add(TDropItem.Create('Заточка', 5, 1, 3));
  DropSubList.Add(TDropItem.Create('Шмотка', 1, 1, 1));
  DropSubList.Add(TDropItem.Create('Оружие', 0.5, 1, 1));
  DropList.Add(DropSubList);

  for DSI in DropList do
    begin
      for DI in DSI do
        Writeln(DI.Name, ': (', DI.CountMin, '-', DI.CountMax, ')', ' -> ', DI.Weight:3:3);
    end;

  Writeln('------------');
  Writeln('');

  N := 100000;

  for j := 0 to N - 1 do
    begin
      W := Random * 100;
      //W := 78.845;
//      Writeln(W:3:10);

      for i := 0 to DropList.Count - 1 do
        begin
          if GetItemFromDropSubList2(W, DropList[i], DI) then
            begin
              DI.Counter := DI.Counter + 1;
//              Writeln('Выпало: ', DI.Name, ' (', RandomRange(DI.CountMin, DI.CountMax), ') шт.');
            end;
        end;

//      Writeln('------------');
//      Writeln('');

    end;

  for DSI in DropList do
    begin
      for DI in DSI do
        Writeln(DI.Name, ' : ', DI.Counter, ' -> ', DI.Counter / N * 100:3:3);
    end;

  FreeAndNil(DropList);

  Readln;

end.
