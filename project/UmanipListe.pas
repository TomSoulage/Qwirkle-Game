unit UmanipListe;

(*Unité regroupant des fonctions manipulants des listes*)

interface

USES UnitType;

Function chercherPionPioche(pioche: Pointeur; n: integer): typePion;
FUNCTION supprimer(pioche: pointeur; pion: typePion): pointeur;   
function suppressionTete(pioche: pointeur): pointeur; 
function ajouterPionPiocheDebut(tete: pointeur; pion: typePion): pointeur;
FUNCTION lengthListe(pioche : pointeur) : integer;


implementation

USES Upioche,Ugrille,Umain,Upion,UregleQwirkle,Crt;


(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : lengthListe(pioche : pointeur) : integer;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Calcule la taille d'une liste/de la pioche.
 -- Pré conditions    : Aucune.
 -- Post conditions   : Donne la taille de la liste/pioche.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
FUNCTION lengthListe(pioche : pointeur) : integer;
var	res : Integer;
BEGIN
   if (pioche <> nil) then
      begin
         res := 1 + lengthListe(pioche^.suivant);
      end
   else
      begin
         res:=0;
      end;

   lengthListe := res;
END;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : chercherPionPioche(pioche: Pointeur; n: integer): typePion;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Cherche l'élément en position 'n' dans une liste/ Cherche le pion en position 'n' dans la pioche.
 -- Pré conditions    : Aucune.
 -- Post conditions   : Aucune.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
Function chercherPionPioche(pioche: Pointeur; n: integer): typePion;
Var
   pionPos: typePion;
   i:       integer;
begin

   for i:=1 to n-1 do
      begin
         pioche:=pioche^.suivant;
      end;

   pionPos.couleur:=pioche^.data.couleur;
   pionPos.forme:=pioche^.data.forme;
   chercherPionPioche:=pionPos;
end;       

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : supprimer(pioche: pointeur; pion: typePion): pointeur;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Supprime le maillon qui contient l'élément/pion recherché dans la liste/pioche.
 -- Pré conditions    : Aucune.
 -- Post conditions   : Aucune.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
Function supprimer(pioche: pointeur; pion: typePion): pointeur;   
var res: pointeur;
begin
   if ((pioche^.data.couleur= pion.couleur) and (pioche^.data.forme= pion.forme)) then				
      begin
         res:=pioche^.suivant;
         dispose(pioche);
      end
   else
      begin
         res:=pioche;
            if(pioche^.suivant <> NIL ) then														
               begin
         	        pioche^.suivant:=supprimer(pioche^.suivant,pion);
               end;
       end;

   supprimer:=res;
end;	

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : suppressionTete(pioche: pointeur): pointeur; 
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Supprime le premier élément/pion de la liste/pioche.
 -- Pré conditions    : Aucune.
 -- Post conditions   : Liste/pioche avec un pion en moins.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function suppressionTete(pioche: pointeur): pointeur; 
var res: pointeur;
BEGIN
	if pioche<>Nil then
		BEGIN
   		res:=pioche^.suivant;	
   		dispose(pioche);
		end;

suppressionTete:= res;
end;		

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : ajouterPionPiocheDebut(tete: pointeur; pion: typePion): pointeur;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Ajoute un élément/pion en début de liste/pioche.
 -- Pré conditions    : Aucune.
 -- Post conditions   : Liste/pioche contient un élément/pion de plus.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function ajouterPionPiocheDebut(tete: pointeur; pion: typePion): pointeur;
var res: pointeur;


BEGIN
	new(res);
	res^.suivant:=tete;
	res^.data:=pion;
ajouterPionPiocheDebut:=res;
end;	







end.

