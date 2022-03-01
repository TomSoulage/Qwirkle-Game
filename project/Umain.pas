UNIT uMain;

(*Dans cette unité, on retrouve toute les fonctions qui concernent la main.*)

interface

USES UnitType;

FUNCTION initMainJoueur(pioche: pointeur): typeMain;
procedure afficherMainJoueur(main: typeMain;s: string);
function RemplacerPionInsere(main: typeMain;pion: typePion): typeMain;
function choisirPion(main: typeMain): typePion;
function echangerPion(main: typeMain;pion: typePion;pioche: pointeur): typeMain;
function testmainpionnul(main: typeMain): boolean;

implementation


USES Upioche,Ugrille,Upion,Crt,UmanipListe,UregleQwirkle;


(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : initMainJoueur(pioche: pointeur): typeMain;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Initialise la main du joueur(début du jeu).
 -- Pré conditions    : Aucune.
 -- Post conditions   : Création d'une main.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
FUNCTION initMainJoueur(pioche: pointeur): typeMain;
var
i:integer;

begin		

	for i:=1 to 6 do
		begin
			main[i]:=pioche^.data; 													//la main prend les 6 premiers pions de la pioche.
			pioche:=pioche^.suivant;
		end;

initMainJoueur:=main;
end;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Procédure          : afficherMainJoueur(main: typeMain; s: string);
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : 
 -- Pré conditions    : Aucune.
 -- Post conditions   : Aucune.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
procedure afficherMainJoueur(main: typeMain; s: string);
var i: integer;
begin
	writeln('  ');
	write('main de ', s);
	
	for i:=1 to 6 do
		begin
			write('|');
			afficherPion(main[i]);
			write('|');
		end;

	writeln('  ');
end;		

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : RemplacerPionInsere(main: typeMain;pion: typePion): typeMain;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Remplace un pion de la main par un pion '.' qui correspond à une case vide (lors de l'insertion d'un pion dans la grille).
 -- Pré conditions    : Aucune.
 -- Post conditions   : La main possède un pion différent.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function RemplacerPionInsere(main: typeMain;pion: typePion): typeMain;
var i: integer;
pionNul: typePion;
begin
	pionNul:=creerPion('.',7);
	i:=0;
	begin	
		repeat		
			i:=i+1;
		until ((main[i].couleur=pion.couleur) and (main[i].forme=pion.forme));	
	end;	 		
	main[i].couleur:=pionNul.couleur;
	main[i].forme:=pionNul.forme;
	
RemplacerPionInsere:=main;
end;	

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : choisirPion(main: typeMain): typePion;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Permet au joueur de séléctionner un pion de la main.
 -- Pré conditions    : Aucune.
 -- Post conditions   : Aucune.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function choisirPion(main: typeMain): typePion;
var i: integer;
	p: typePion;
begin
	begin
		repeat
			writeln('  ');
			writeln('choisir un pion parmi la main, en entrant le numero de sa position, de 1 a 6 de gauche a droite');
			readln(i);
		until ((i>=1) and (i<=6));	
	end;
		p:=main[i];
		
choisirPion:=p;
end;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : echangerPion(main: typeMain;pion: typePion;pioche: pointeur): typeMain;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Remplace un pion de la main, celui qui est en paramètre, avec le premier pion de la pioche.
 -- Pré conditions    : Aucune.
 -- Post conditions   : Change un pion de la main.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function echangerPion(main: typeMain;pion: typePion;pioche: pointeur): typeMain;
var i: integer;
begin
	i:=0;

	begin																			//on cherche la position du pion(en paramètre) dans la main
		repeat		
			i:=i+1;
		until ((main[i].couleur=pion.couleur) and (main[i].forme=pion.forme));	
		end;	 
		
	main[i]:=pioche^.data;															//le pion prend la valeur du premier pion de la pioche

echangerPion:=main;
end;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : testmainpionnul(main: typeMain): boolean;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Permet de voir si une main a ou n'a plus de pions. Cette fonction est uniquement utilisée comme condition d'arret du jeu.
 -- Pré conditions    : Aucune.
 -- Post conditions   : Aucune.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)

function testmainpionnul(main: typeMain): boolean;
var i: integer;
	pionNul: typePion;
	res: boolean;
begin
	pionNul:=creerPion('.',7);
	res:=TRUE;
	for i:=1 to 6 do
		begin
			if (main[i].forme <> pionNul.forme) then res:=FALSE; 
		end;
testmainpionnul:=res;
end;

end.
