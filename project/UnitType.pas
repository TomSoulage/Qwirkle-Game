Unit UnitType;

interface

const M= 15;
			


type 

typeCouleur = integer;
typeForme = string; 

typePion = record
	couleur: typeCouleur;
	forme: typeForme;
	end;

pointeur = ^maillon; 

	maillon= record
	data: typePion;
	suivant: pointeur;
	end;

typeGrille = Array[1..M,1..M] of typePion;
typeMain = Array[1..6] of typePion;        //type de la main d joueur 
typeVerif = Array[1..4] of boolean;        //type pour vérification des règles du jeu: 1-au dessus du pion (ie au Nord) 2-a droite du pion (ie à l'Est) 3-en dessous du pion (ie au Sud) 4-à gauche du pion (ie à l'Ouest)
typeVerif2 = Array[1..2,1..4] of integer;  //type pour vérification si le joueur décide de placer plus d'un pion dans le même tour.



var
verificationcoupsuivant: typeVerif2;
nPoints_nTour: integer;
main: typeMain;

implementation

begin

end.	
