UNIT Ugrille;
(*Unité regroupant toutes les fonctions liées à la grille du jeu*)

INTERFACE

USES UnitType;

	function initGrille(): typeGrille ;
	procedure afficherGrille(grille1: typeGrille);
	function insererPremierPion(grille: typeGrille; pion: typePion): typeGrille;
	function insererPionCoordoneesi(grille:typeGrille): integer; 
	function insererPionCoordoneesj(grille:typeGrille): integer; 
	function insererPion(grille:typeGrille; pion:typePion;i,j:integer): typeGrille;

	

IMPLEMENTATION

USES Upioche,Upion,Umain,UmanipListe,UregleQwirkle,Crt;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : initGrille(): typeGrille ;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Initialisation d'une grille vide
 -- Pré conditions    : Aucune
 -- Post conditions   : Création d'une grille
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
FUNCTION initGrille(): typeGrille ;
VAR
i,j: 		 integer;
grille1:	 typeGrille;
pionNul :	 typePion;
BEGIN
	pionNul:=creerPion('.',7);										//pionNul est un pion correspondant à une case vide de la grille
		FOR i:=1 TO M DO
			BEGIN
				FOR j:=1 TO M DO
					BEGIN
					grille1[i,j]:= pionNul; 									
					END;                                 
			END;

									
	 initGrille := grille1;
END;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Procedure         : afficherGrille(grille1: typeGrille);
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Affichage de la grille
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
procedure afficherGrille(grille1: typeGrille);
VAR 
i,j : integer;
BEGIN
writeln(' ');
write('  ');
	FOR j:=2 TO high(grille1)-1 do              //pour palier à une erreur(crash lors de l'insersion d'un pion sur le bord de la grille) on laisse une bordure de la grille invisible d'où le 2 et -1 
			BEGIN
				if j-1<=9 then					//ici on conditionne l'affichage en fonction du nombre de chiffres (1 ou 2) pour éviter un décalage graphique
					begin
							write(' ');
							write('|',j-1,'|');
					end
						else
							begin
								write('');
								write('|',j-1,'|');
							end;
			END;		
				writeln();
				write('  ');

	FOR j:=2 TO high(grille1)-1 DO
			BEGIN	
				write('____');
			END;
					writeln();	

	FOR i:=2 TO high(grille1)-1 DO
			BEGIN
				if i-1<=9 then	
					begin
						write(i-1,'| ');
					end
						else
							write(i-1,'|');

				FOR j:=2 TO high(grille1)-1 DO
					begin 
						write('[');
						afficherPion(grille1[i,j]);
						write(']');
						write(' ');
					end;
					writeln(' ');
			end;
writeln(' ');					
								
end;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : insererPremierPion(grille: typeGrille; pion: typePion): typeGrille;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Insère le premier pion choisi par le joueur qui débute la partie, afin d'exploiter aux mieux la taille du tableau. 
 -- Pré conditions    : Aucune
 -- Post conditions   : Renvoie une grille avec un pion au milieu du tableau
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function insererPremierPion(grille: typeGrille; pion: typePion): typeGrille;
begin

	grille[(M div 2)+1, (M div 2)+1]:=pion;                     

insererPremierPion:=grille;	
end;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : insererPionCoordoneesi(grille:typeGrille): integer; 
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Demande à l'utilisateur la coordonée verticale de la case où il souhaite insérer son pion.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function insererPionCoordoneesi(grille:typeGrille): integer; 
var i: integer;
begin
		
			begin
				repeat
				writeln('saisissez la coordonnee verticale de la case sur laquelle vous voulez placer votre pion');
				readln(i);
				UNTIL((i>=1) and (i<= high(grille)));
			end;
			i:=i+1;	

insererPionCoordoneesi:=i;			
end;	

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : insererPionCoordoneesj(grille:typeGrille): integer; 
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Demande à l'utilisateur la coordonée horizontale de la case où il souhaite insérer son pion.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function insererPionCoordoneesj(grille:typeGrille): integer; 
var j: integer;
begin
		
			begin
				repeat
				writeln('saisissez la coordonnee horizontale de la case sur laquelle vous voulez placer votre pion');
				readln(j);
				UNTIL((j>=1) and (j<= high(grille)));
			end;	
			j:=j+1;

insererPionCoordoneesj:=j;			
end;	

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : insererPion(grille:typeGrille; pion:typePion;i,j:integer): typeGrille;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Une fois un pion insérer dans la grille, si le pion ne vérifie pas les règles alors il est remplacer par une case vide, correspondant à un point.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function insererPion(grille:typeGrille; pion:typePion;i,j:integer): typeGrille;
var pionNul: typePion;
begin

	pionNul:=creerPion('.',7);
	grille[i,j]:=pion;

	insererPion:=grille;
end;	


end.
