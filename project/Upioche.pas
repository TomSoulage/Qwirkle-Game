UNIT Upioche;

(*Dans cette unité, on retrouve toute les fonctions qui concernent la pioche.*)

INTERFACE

USES UnitType;

function remplirPioche(i:integer): typePion;
function initPioche(n: integer): pointeur;			//on intialise la pioche en mettant dans chaque maillon de la liste de la pioche, un pion d'un symbole et d'une couleur 
PROCEDURE afficherPioche(tete:pointeur);
function melangePioche(pioche: pointeur): pointeur; 
function PiocheApresDistribution(pioche: pointeur): pointeur;

IMPLEMENTATION

USES Ugrille,Upion,Umain,UmanipListe,UregleQwirkle,Crt,sysutils;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : remplirPioche(i:integer): typePion;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Crée tous les pions du jeu 
 -- Pré conditions    : L'entier saisi et compris entre 1 et 108
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function remplirPioche(i:integer): typePion;
var pion: typePion;

   begin	
      case i of						//ici on liste tous les pions de la pioche pour pouvoir ensuite remplir la pioche sachant que chaque pion d'un symbole d'une couleur est trois fois dans la pioche
	1: 	pion:= creerPion('#',1);       //Blue
	2: 	pion:= creerPion('#',2);      //Green 
	3: 	pion:= creerPion('#',3);     //Cyan 
	4: 	pion:= creerPion('#',4);	//Red 
	5: 	pion:= creerPion('#',5);   //Magenta 
	6: 	pion:= creerPion('#',6);  // Brown 
	7:	pion:= creerPion('#',1);
	8: 	pion:= creerPion('#',2);
	9: 	pion:= creerPion('#',3);
	10: pion:= creerPion('#',4);
	11: pion:= creerPion('#',5);
	12: pion:= creerPion('#',6);
	13: pion:= creerPion('#',1);
	14: pion:= creerPion('#',2);
	15: pion:= creerPion('#',3);
	16: pion:= creerPion('#',4);
	17: pion:= creerPion('#',5);
	18: pion:= creerPion('#',6);    											  	
	19: pion:= creerPion('+',1);	
	20: pion:= creerPion('+',2);
	21: pion:= creerPion('+',3);
	22: pion:= creerPion('+',4);
	23: pion:= creerPion('+',5);
	24: pion:= creerPion('+',6);
	25: pion:= creerPion('+',1);
	26: pion:= creerPion('+',2);
	27: pion:= creerPion('+',3);
	28: pion:= creerPion('+',4);
	29: pion:= creerPion('+',5);
	30: pion:= creerPion('+',6);
	31: pion:= creerPion('+',1);
	32: pion:= creerPion('+',2);
	33: pion:= creerPion('+',3);
	34: pion:= creerPion('+',4);
	35: pion:= creerPion('+',5);
	36: pion:= creerPion('+',6);    							 	
	37: pion:= creerPion('¤',1);	
	38: pion:= creerPion('¤',2);
	39: pion:= creerPion('¤',3);
	40: pion:= creerPion('¤',4);
	41: pion:= creerPion('¤',5);
	42: pion:= creerPion('¤',6);
	43: pion:= creerPion('¤',1);
	44: pion:= creerPion('¤',2);
	45: pion:= creerPion('¤',3);
	46: pion:= creerPion('¤',4);
	47: pion:= creerPion('¤',5);
	48: pion:= creerPion('¤',6);
	49: pion:= creerPion('¤',1);
	50: pion:= creerPion('¤',2);
	51: pion:= creerPion('¤',3);
	52: pion:= creerPion('¤',4);
	53: pion:= creerPion('¤',5);
	54: pion:= creerPion('¤',6);    
	55: pion:= creerPion('=',1);    
	56: pion:= creerPion('=',2);
	57: pion:= creerPion('=',3);
	58: pion:= creerPion('=',4);
	59: pion:= creerPion('=',5);
	60: pion:= creerPion('=',6);
	61: pion:= creerPion('=',1);
	62: pion:= creerPion('=',2);    
	63: pion:= creerPion('=',3);
	64: pion:= creerPion('=',4);
	65: pion:= creerPion('=',5);
	66: pion:= creerPion('=',6);
	67: pion:= creerPion('=',1);   
	68: pion:= creerPion('=',2);
	69: pion:= creerPion('=',3);
	70: pion:= creerPion('=',4);
	71: pion:= creerPion('=',5);
	72: pion:= creerPion('=',6);    
	73: pion:= creerPion('o',1);    
	74: pion:= creerPion('o',2);
	75: pion:= creerPion('o',3);
	76: pion:= creerPion('o',4);
	77: pion:= creerPion('o',5);
	78: pion:= creerPion('o',6);
	79: pion:= creerPion('o',1);
	80: pion:= creerPion('o',2);
	81: pion:= creerPion('o',3);
	82: pion:= creerPion('o',4);
	83: pion:= creerPion('o',5);
	84: pion:= creerPion('o',6);
	85: pion:= creerPion('o',1);
	86: pion:= creerPion('o',2);
	87: pion:= creerPion('o',3);
	88: pion:= creerPion('o',4);
	89: pion:= creerPion('o',5);
	90: pion:= creerPion('o',6);    
	91: pion:= creerPion('~',1);
	92: pion:= creerPion('~',2);
	93: pion:= creerPion('~',3);
	94: pion:= creerPion('~',4);
	95: pion:= creerPion('~',5);
	96: pion:= creerPion('~',6);
	97: pion:= creerPion('~',1);
	98: pion:= creerPion('~',2);
	99: pion:= creerPion('~',3);
	100: pion:= creerPion('~',4);   
	101: pion:= creerPion('~',5);
	102: pion:= creerPion('~',6);
	103: pion:= creerPion('~',1);
	104: pion:= creerPion('~',2);
	105: pion:= creerPion('~',3);
	106: pion:= creerPion('~',4);
	107: pion:= creerPion('~',5);
	108: pion:= creerPion('~',6);
      end;
      
remplirPioche:=pion;
end;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : initPioche(n: integer): pointeur;	
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Initialise la pioche, en la remplissant de pion.
 -- Pré conditions    : L'entier en paramètre est positif.
 -- Post conditions   : Initialise une liste de pions.
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function initPioche(n: integer): pointeur;			// n correspond au nombre d'éléments de la liste ( avec le nil compris dans ce nombre), soit 181, puisqu'on a 180 pions dans le jeu
var													
  i:integer;
  pointeurPioche, tete: pointeur;
  pion: typePion;
begin

  tete:= Nil;

  for i:=1 to n do
  	begin
		 new(pointeurPioche);									//création d'un pointeur pioche
		 pointeurPioche^.suivant:=tete;
		 pion:=remplirPioche(i);									
		 pointeurPioche^.data:= pion;							
		 tete:=pointeurPioche;
  	end;	

  initPioche:=pointeurPioche;
end;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Procédure         : afficherPioche(tete:pointeur);
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Affiche la pioche (seulement utilisé pour tester le fonctionnement de la pioche).
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
PROCEDURE afficherPioche(tete:pointeur);
begin

  writeln(' ');

  while ((tete^.suivant)<> Nil) do
	  BEGIN
		write('|');
		afficherPion(tete^.data);
		write('|');            
		write(' ---> ');
		tete:= tete^.suivant;
	  END;

  if (tete^.suivant= NIL) then
 	BEGIN
		 write('X ');
		 writeln(' ');
  	end;
END;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : melangePioche(pioche: pointeur): pointeur;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Fonction permettant de mélanger la pioche initiale
 -- Pré conditions    : Prend en paramètre une pioche initiale
 -- Post conditions   : Crée une nouvelle pioche
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function melangePioche(pioche: pointeur): pointeur;
var 
  pointeurPioche, tete : pointeur;
  pion		   : 		 typePion;
  i			   : 		 integer;
  k		  	   :         integer; 
  r			   :         integer;
begin
  k:=lengthListe(pioche);																	                    //fin de la pioche
  tete:= Nil;
  for i:=1 to k do
  	begin
		 new(pointeurPioche);					
		 pointeurPioche^.suivant:=tete;															
		 r := random(k-i+1);                                                       	
		 pion:=chercherPionPioche(pioche,r);                                      // on va chercher dans la liste initiale un pion en position r(entier aléatoire) 	
		 pointeurPioche^.data.couleur:= pion.couleur;
		 pointeurPioche^.data.forme:= pion.forme;
		 tete:=pointeurPioche;
		 pioche:=supprimer(pioche,pion);                                         //suppression du pion de l'ancienne pioche 
  	end;
  melangePioche:=pointeurPioche;		
end;

(* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : PiocheApresDistribution(pioche: pointeur): pointeur;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Supprime les 6 premiers pions de la pioche au début du jeu dès lors qu'une main de joueur est distribuée
 -- Pré conditions    : Aucune
 -- Post conditions   : Renvoie la pioche avec 6 pions en moins
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function PiocheApresDistribution(pioche: pointeur): pointeur;
var
  i: integer;
BEGIN	

  	for i:=1 to 6 do
	  begin
	 	  pioche:=suppressionTete(pioche);                                                    
	  end;

PiocheApresDistribution:=pioche;
end;	


end.

