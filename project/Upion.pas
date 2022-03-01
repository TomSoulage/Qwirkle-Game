UNIT Upion;
(*Unité regroupant toutes les fonctions liées au pion du jeu*)

interface

USES UnitType;

function creerPion(forme: typeForme; couleur: typeCouleur): typePion;				
procedure afficherPion(pion: typePion);			

implementation

USES Upioche,Ugrille,Umain,UmanipListe,UregleQwirkle,Crt;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : creerPion(forme: typeForme; couleur: typeCouleur): typePion;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Créer un pion avec une forme et une couleur
 -- Pré conditions    : Le pion prend une forme qui est une chaîne de caractères et un entier qui correspond à une couleur.
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function creerPion(forme: typeForme; couleur: typeCouleur): typePion;				
var
pion: typePion;
begin
	
	pion.forme:=forme;																	//la forme du pion est le caractere placé en paramètre de la fonction
	pion.couleur:=couleur;																//la couleur est un entier 

	creerPion:= pion;
end;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Procedure         : afficherPion(pion: typePion);	
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Affichage un pion (sa forme et sa couleur)
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
procedure afficherPion(pion: typePion);			
begin
	TextColor(pion.couleur);
	write(pion.forme);
	TextColor(7);												//permet de	remettre la couleur initiale(noir) du terminal après l'affichage du pion
	
end;	

end.
