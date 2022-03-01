UNIT UregleQwirkle;

(* Dans cette unité, on retrouve toutes les fonctions définissants les règles du jeu.*)



INTERFACE

USES UnitType;

	function verifposition(grille: typeGrille; posi,posj: integer): typeVerif;
	function comptepion(grille: typeGrille; posi,posj: integer; orientation:string): integer;
	function verifdoublon(grille: typeGrille; posi,posj,compteurpion: integer; orientation:string): boolean;
	function verifattribut1(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;      //cas où le pion qu'on veut placer n'a qu'un seul pion voisin
	function verifattribut2facile(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;       //cas où le pion qu'on veut placer est entouré de deux pions placés soit en N/O soit en N/E soit en S/O soit en S/E
	function verifattribut2complexe(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;      //cas où le pion qu'on veut placer est entouré de deux pions placés soit en N/S soit en O/E
	function verfiattribut3(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;         //cas où le pion qu'on veut placer est entouré de trois pions.
	function verifattribut4(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;         //cas où le pion qu'on veut placer est entouré de quatre pions.
	function verifattributfinal(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;         //fonction regroupant toutes les fonctions ci-dessus
	function verifcoupsuivant(i1,i2,i3,i4,j1,j2,j3,j4: integer): typeVerif2;
	function testcoupsuivant(posi,posj: integer): boolean;

IMPLEMENTATION

USES Upioche,Ugrille,UmanipListe,Upion,Umain,Crt;




 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : verifposition(grille: typeGrille; posi,posj: integer): typeVerif;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Vérifier que le pion que l'utilisateur souhaite placer a au moins un voisin déjà placé.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function verifposition(grille: typeGrille; posi,posj: integer): typeVerif;
var
pionNul: typePion;
res: typeVerif;
i: integer;
begin
	pionNul:=creerPion('.',7);
	for i:=1 to 4 do                                                      
		begin
			res[i]:=TRUE                                         //initialisation du tableau booléen
		end;
	If grille[posi,posj-1].forme = pionNul.forme then res[1]:=FALSE;         //face nord
	If grille[posi+1,posj].forme = pionNul.forme then res[2]:=FALSE;         //face est             //ici on vérfie que le joueur place le pion souhaité sur une case voisine d'un pion déjà placé
	If grille[posi,posj+1].forme = pionNul.forme then res[3]:=FALSE;         //face sud
	If grille[posi-1,posj].forme = pionNul.forme then res[4]:=FALSE;         //face ouest

verifposition:=res;
end;

 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : comptepion(grille: typeGrille; posi,posj: integer; orientation:string): integer;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Compter le nombre de pion d'une ligne déjà existante sur la grille.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function comptepion(grille: typeGrille; posi,posj: integer; orientation:string): integer;
var
pionNul:typePion;
res,i,j: integer;
begin
	pionNul:=creerPion('.',7);
	res:=0;
	case orientation of                                                  //    Il y a un cas pour chaque orientation de lignes.
		'N':begin
				j:=posj-1;   // on se place une case au-dessus pour ne pas compter le pion que l'utlisateur souhaite placer.
				while grille[posi,j].forme <> pionNul.forme do
					begin
						res:=res+1;
						j:=j-1;
					end;
			end;
		'S':begin
				j:=posj+1;   // idem mais avec une case en-dessous.
				while grille[posi,j].forme <> pionNul.forme do
					begin
						res:=res+1;
						j:=j+1;
					end;
			end;
		'O':begin
				i:=posi-1;    // idem mais avec une case à gauche.
				while grille[i,posj].forme <> pionNul.forme do
					begin
						res:=res+1;
						i:=i-1;
					end;
			end;
		'E':begin
				i:=posi+1;     //idem mais avec une case à l'est.
				while grille[i,posj].forme <> pionNul.forme do
					begin
						res:=res+1;
						i:=i+1;
					end;
			end;
	end;		
	comptepion:=res;
end;

 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : verifdoublon(grille: typeGrille; posi,posj,compteurpion: integer; orientation:string): boolean;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Vérifier si le pion que l'utilisateur souhaite placer est déjà sur une ligne.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function verifdoublon(grille: typeGrille; posi,posj,compteurpion: integer; orientation:string): boolean;
var
res: boolean;
i,j: integer;
begin
	res:=FALSE;
	case orientation of   //on vérifie en fonction de l'orientation de la ligne.
		'N':begin
				for j:=posj-1 to posj-compteurpion do
					begin
						If (grille[posi,posj].forme = grille[posi,j].forme) and (grille[posi,posj].couleur = grille[posi,j].couleur) then res:=TRUE;
					end
			end;		
 		'S':begin
				for j:=posj+1 to posj+compteurpion do
					begin
						If (grille[posi,posj].forme = grille[posi,j].forme) and (grille[posi,posj].couleur = grille[posi,j].couleur) then res:=TRUE;
					end
			end;	
		'O':begin
				for i:=posi-1 to posi-compteurpion do
					begin
						If (grille[posi,posj].forme = grille[i,posj].forme) and (grille[posi,posj].couleur = grille[i,posj].couleur) then res:=TRUE;
					end
			end;	
		'E':begin
				for i:=posi+1 to posi+compteurpion do
					begin
						If (grille[posi,posj].forme = grille[i,posj].forme) and (grille[posi,posj].couleur = grille[i,posj].couleur) then res:=TRUE;
					end
			end;	
	end;		
	verifdoublon:=res;
end;


 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : verifattribut1(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean; 
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : -Vérifier la légalité d'un coup dans le cas où le pion que l'utilisateur souhaite placer n'a qu'un seul pion voisin.
 						-Compter le nombre de points par coup.
						-Calculer les positions possibles pour un potentiel prochain coup dans le même tour.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function verifattribut1(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;      
var
pionNul: typePion;
res,doublon: boolean;
compte: integer;
begin
	pionNul:=creerPion('.',7);
	res:=FALSE;
			If verif[1]=TRUE then //cas où le pion voisin est au nord du pion qu'on veut placer
				begin
					If grille[posi,posj-2].forme = pionNul.forme then   //cas où il n'y a qu'un seul pion au-dessus du pion qu'on veut placer
						begin
							If (grille[posi,posj].forme = grille[posi,posj-1].forme) and (grille[posi,posj].couleur <> grille[posi,posj-1].couleur) then res:=TRUE;
							If (grille[posi,posj].couleur = grille[posi,posj-1].couleur) and (grille[posi,posj].forme <> grille[posi,posj-1].forme) then res:=TRUE;
							If res=TRUE then 
								begin
									verificationcoupsuivant:=verifcoupsuivant(posi,posi,0,0,posj-2,posj+1,0,0);    //si le joueur veut placer un autre pion dans le même tour, il ne peut que le placer de part et d'autre des deux pions
									nPoints_nTour:=2;                                                              // 2 pions donc 2 points.
								end;
						end
					else
						begin                                                     //cas où il y a plusieurs pions au-dessus du pion qu'on veut placer
							compte:=comptepion(grille,posi,posj,'N');
							doublon:=verifdoublon(grille,posi,posj,compte,'N');
							If ((compte < 6) and (doublon=FALSE)) then
								begin
									If (grille[posi,posj-2].forme = grille[posi,posj-1].forme) and (grille[posi,posj-1].forme = grille[posi,posj].forme) then res:=TRUE;
									If (grille[posi,posj-2].couleur = grille[posi,posj-1].couleur) and (grille[posi,posj-1].couleur = grille[posi,posj].couleur) then res:=TRUE;
									If res=TRUE then
										begin
										verificationcoupsuivant:=verifcoupsuivant(posi,posi,0,0,posj-(compte+1),posj+1,0,0);
										nPoints_nTour:=compte+1;
										If (compte+1) = 6 then nPoints_nTour:=nPoints_nTour+6;                              //cas d'un qwirkle.
										end; 
								end;
						end;
				end;
			If verif[3]=TRUE then //cas où le pion voisin est au sud du pion qu'on veut placer
				begin
					If grille[posi,posj+2].forme = pionNul.forme then  //cas où il n'y a qu'un seul pion en-dessous du pion qu'on veut placer
						begin
							If (grille[posi,posj].forme = grille[posi,posj+1].forme) and (grille[posi,posj].couleur <> grille[posi,posj+1].couleur) then res:=TRUE;
							If (grille[posi,posj].couleur = grille[posi,posj+1].couleur) and (grille[posi,posj].forme <> grille[posi,posj+1].forme) then res:=TRUE;
							If res=TRUE then
								begin
									verificationcoupsuivant:=verifcoupsuivant(posi,posi,0,0,posj+2,posj-1,0,0);
									nPoints_nTour:=2;
								end;
						end
					else
						begin                                   //cas où il y a plusieurs pions en-dessous du pion qu'on veut placer
							compte:=comptepion(grille,posi,posj,'S');
							doublon:=verifdoublon(grille,posi,posj,compte,'S');
							If ((compte < 6) and (doublon=FALSE)) then
								begin
									If (grille[posi,posj+2].forme = grille[posi,posj+1].forme) and (grille[posi,posj+1].forme = grille[posi,posj].forme) then res:=TRUE;
									If (grille[posi,posj+2].couleur = grille[posi,posj+1].couleur) and (grille[posi,posj+1].couleur = grille[posi,posj].couleur) then res:=TRUE;
									If res=TRUE then 
										begin
										verificationcoupsuivant:=verifcoupsuivant(posi,posi,0,0,posj+(compte+1),posj-1,0,0);
										nPoints_nTour:=compte+1;
										If (compte+1) = 6 then nPoints_nTour:=nPoints_nTour+6;
										end;
								end;
						end;
				end;
			If verif[2]=TRUE then //cas où le pion voisin est à l'est du pion qu'on veut placer
				begin
					If grille[posi+2,posj].forme = pionNul.forme then  //cas où il n'y a qu'un seul pion à droite du pion qu'on veut placer
						begin
							If (grille[posi,posj].forme = grille[posi+1,posj].forme) and (grille[posi,posj].couleur <> grille[posi+1,posj].couleur) then res:=TRUE;
							If (grille[posi,posj].couleur = grille[posi+1,posj].couleur) and (grille[posi,posj].forme <> grille[posi+1,posj].forme) then res:=TRUE;
							If res=TRUE then 
								begin
								verificationcoupsuivant:=verifcoupsuivant(posi+2,posi-1,0,0,posj,posj,0,0);
								nPoints_nTour:=2;
								end;
						end
					else
						begin                                 //cas où il y a plusieurs pions à droite du pion qu'on veut placer
							compte:=comptepion(grille,posi,posj,'E');
							doublon:=verifdoublon(grille,posi,posj,compte,'E');
							If ((compte < 6) and (doublon=FALSE)) then
								begin
									If (grille[posi+2,posj].forme = grille[posi+1,posj].forme) and (grille[posi+1,posj].forme = grille[posi,posj].forme) then res:=TRUE;
									If (grille[posi+2,posj].couleur = grille[posi+1,posj].couleur) and (grille[posi+1,posj].couleur = grille[posi,posj].couleur) then res:=TRUE;
									If res=TRUE then 
										begin
										verificationcoupsuivant:=verifcoupsuivant(posi-1,posi+(compte+1),0,0,posj,posj,0,0);
										nPoints_nTour:=compte+1;
										If (compte+1) = 6 then nPoints_nTour:=nPoints_nTour+6;
										end;
								end;
						end;
				end;
			If verif[4]=TRUE then //cas où le pion voisin est à l'ouest du pion qu'on veut placer
				begin
					If grille[posi-2,posj].forme = pionNul.forme then  //cas où il n'y a qu'un seul pion à gauche du pion qu'on veut placer
						begin
							If (grille[posi,posj].forme = grille[posi-1,posj].forme) and (grille[posi,posj].couleur <> grille[posi-1,posj].couleur) then res:=TRUE;
							If (grille[posi,posj].couleur = grille[posi-1,posj].couleur) and (grille[posi,posj].forme <> grille[posi-1,posj].forme) then res:=TRUE;
							If res=TRUE then 
								begin
								verificationcoupsuivant:=verifcoupsuivant(posi-2,posi+1,0,0,posj,posj,0,0);
								nPoints_nTour:=2;
								end;
						end
					else
						begin                                  //cas où il y a plusieurs pions à gauche du pion qu'on veut placer
							compte:=comptepion(grille,posi,posj,'O');
							doublon:=verifdoublon(grille,posi,posj,compte,'O');
							If ((compte < 6) and (doublon=FALSE)) then
								begin
									If (grille[posi-2,posj].forme = grille[posi-1,posj].forme) and (grille[posi-1,posj].forme = grille[posi,posj].forme) then res:=TRUE;
									If (grille[posi-2,posj].couleur = grille[posi-1,posj].couleur) and (grille[posi-1,posj].couleur = grille[posi,posj].couleur) then res:=TRUE;
									If res=TRUE then 
										begin
										verificationcoupsuivant:=verifcoupsuivant(posi+1,posi-(compte+1),0,0,posj,posj,0,0);
										nPoints_nTour:=compte+1;
										If (compte+1) = 6 then nPoints_nTour:=nPoints_nTour+6;
										end;
								end;
						end;
				end;				
							
verifattribut1:=res;
end;

 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : verifattribut2facile(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean; 
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : -Vérifier la légalité d'un coup dans le cas où le pion que l'utilisateur souhaite placer a deux pions voisins placés en N/O ou N/E ou S/O ou S/E.
 						-Compter le nombre de points par coup.
						-Calculer les positions possibles pour un potentiel prochain coup dans le même tour.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function verifattribut2facile(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;
var
res,verification1,verification2,verification3,verification4: boolean;
verif1,verif2,verif3,verif4 : typeVerif;
compte1,compte2,compte3,compte4: integer;
begin
	res:=FALSE;
	If ((verif[1]=TRUE) and (verif[4]=TRUE)) then             //cas N/O
		begin
			verif1[1]:=TRUE;                             
			verif1[2]:=FALSE;
			verif1[3]:=FALSE;
			verif1[4]:=FALSE;                        // on initialise un typeVerif correspondant au cas N/O
			verif4[1]:=FALSE;
			verif4[2]:=FALSE;
			verif4[3]:=FALSE;
			verif4[4]:=TRUE;
			verification1:= verifattribut1(grille,posi,posj,verif1);     // on appelle la fonction précédente une fois pour chaque voisin (ici nord et ouest)
			verification4:= verifattribut1(grille,posi,posj,verif4);
			If ((verification1 = TRUE) and (verification4 = TRUE)) then res:= TRUE;
			If res=TRUE then
				begin
					compte1:=comptepion(grille,posi,posj,'N');
					compte4:=comptepion(grille,posi,posj,'O');
					verificationcoupsuivant:=verifcoupsuivant(posi,posi+1,posi,posi-(compte4+1),posj-(compte1+1),posj,posj+1,posj);    // on étudie les 4 positions possibles pour un potentiel coup suivant dans le même tour
					nPoints_nTour:=compte1+compte4+2;                                      // on rajoute 2 car la fonction compte ne prend pas en compte le pion que l'on souhaite placer.
					If compte1=5 then nPoints_nTour:=nPoints_nTour+6;
					If compte4=5 then nPoints_nTour:=nPoints_nTour+6;
				end;
		end;
	If ((verif[1]=TRUE) and (verif[2]=TRUE)) then            //cas N/E
		begin
			verif1[1]:=TRUE;
			verif1[2]:=FALSE;
			verif1[3]:=FALSE;                         // on initialise un typeVerif correspondant au cas N/E
			verif1[4]:=FALSE;
			verif2[1]:=FALSE;
			verif2[2]:=TRUE;
			verif2[3]:=FALSE;
			verif2[4]:=FALSE;
			verification1:= verifattribut1(grille,posi,posj,verif1);
			verification2:= verifattribut1(grille,posi,posj,verif2);
			If ((verification1 = TRUE) and (verification2 = TRUE)) then res:= TRUE;
			If res=TRUE then
				begin
					compte1:=comptepion(grille,posi,posj,'N');
					compte2:=comptepion(grille,posi,posj,'E');
					verificationcoupsuivant:=verifcoupsuivant(posi,posi+(compte2+1),posi,posi-1,posj-(compte1+1),posj,posj+1,posj);
					nPoints_nTour:=compte1+compte2+2;
					If compte1=5 then nPoints_nTour:=nPoints_nTour+6;
					If compte2=5 then nPoints_nTour:=nPoints_nTour+6;
				end;
		end;
	If ((verif[3]=TRUE) and (verif[4]=TRUE)) then              //cas S/O
		begin
			verif3[1]:=FALSE;
			verif3[2]:=FALSE;
			verif3[3]:=TRUE;
			verif3[4]:=FALSE;                         // on initialise un typeVerif correspondant au cas S/O
			verif4[1]:=FALSE;
			verif4[2]:=FALSE;
			verif4[3]:=FALSE;
			verif4[4]:=TRUE;
			verification3:= verifattribut1(grille,posi,posj,verif3);
			verification4:= verifattribut1(grille,posi,posj,verif4);
			If ((verification3 = TRUE) and (verification4 = TRUE)) then res:= TRUE;
			If res=TRUE then
				begin
					compte3:=comptepion(grille,posi,posj,'S');
					compte4:=comptepion(grille,posi,posj,'O');
					verificationcoupsuivant:=verifcoupsuivant(posi,posi+1,posi,posi-(compte4+1),posj-1,posj,posj+(compte3+1),posj);
					nPoints_nTour:=compte3+compte4+2;
					If compte3=5 then nPoints_nTour:=nPoints_nTour+6;
					If compte4=5 then nPoints_nTour:=nPoints_nTour+6;
				end;
		end;
	If ((verif[2]=TRUE) and (verif[3]=TRUE)) then                   //cas S/E
		begin
			verif2[1]:=FALSE;
			verif2[2]:=TRUE;
			verif2[3]:=FALSE;
			verif2[4]:=FALSE;
			verif3[1]:=FALSE;                         // on initialise un typeVerif correspondant au cas S/E
			verif3[2]:=FALSE;
			verif3[3]:=TRUE;
			verif3[4]:=FALSE;
			verification2:= verifattribut1(grille,posi,posj,verif2);
			verification3:= verifattribut1(grille,posi,posj,verif3);
			If ((verification2 = TRUE) and (verification3 = TRUE)) then res:= TRUE;
			If res=TRUE then
				begin
					compte2:=comptepion(grille,posi,posj,'E');
					compte3:=comptepion(grille,posi,posj,'S');
					verificationcoupsuivant:=verifcoupsuivant(posi,posi+(compte2+1),posi,posi-1,posj-1,posj,posj+(compte3+1),posj);
					nPoints_nTour:=compte2+compte3+2;
					If compte2=5 then nPoints_nTour:=nPoints_nTour+6;
					If compte3=5 then nPoints_nTour:=nPoints_nTour+6;
				end;
		end;
verifattribut2facile:=res;
end;

 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : 2(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : -Vérifier la légalité d'un coup dans le cas où le pion que l'utilisateur souhaite placer a deux pions voisins placés en N/S ou O/E.
 						-Compter le nombre de points par coup.
						-Calculer les positions possibles pour un potentiel prochain coup dans le même tour.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)

function verifattribut2complexe(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;    
var
res,doublon: boolean;
compte,compte1,compte2: integer;
begin
	res:=FALSE;
	If ((verif[1]=TRUE) and (verif[3]=TRUE)) then                                      // cas N/S
	begin
		If ((grille[posi,posj-1].forme = grille[posi,posj].forme) and (grille[posi,posj].forme = grille[posi,posj+1].forme)) or ((grille[posi,posj-1].couleur = grille[posi,posj].couleur) and (grille[posi,posj].couleur = grille[posi,posj+1].couleur)) then
		begin
			compte1:=comptepion(grille,posi,posj,'N');
			compte2:=comptepion(grille,posi,posj,'S');
			compte:=compte1+compte2;
			doublon:=verifdoublon(grille,posi,posj+compte2,compte,'N');         //on prend comme référence pour la recherche des doublons le pion le plus au sud.
			If ((compte < 6) and (doublon=FALSE)) then res:=TRUE;
			If res=TRUE then 
				begin	
				verificationcoupsuivant:=verifcoupsuivant(posi,posi,0,0,posj-(compte1+1),posj+(compte2+1),0,0);
				nPoints_nTour:=compte+1;                               // ici on rajoute +1 car on ne forme qu'une seule ligne.
				If (compte+1)=6 then nPoints_nTour:=nPoints_nTour+6;
				end;
		end;	
	end;
	If ((verif[2]=TRUE) and (verif[4]=TRUE)) then                                      // cas O/E
	begin
		If ((grille[posi-1,posj].forme = grille[posi,posj].forme) and (grille[posi,posj].forme = grille[posi+1,posj].forme)) or ((grille[posi-1,posj].couleur = grille[posi,posj].couleur) and (grille[posi,posj].couleur = grille[posi+1,posj].couleur)) then
		begin
			compte1:=comptepion(grille,posi,posj,'O');
			compte2:=comptepion(grille,posi,posj,'E');
			compte:=compte1+compte2;
			doublon:=verifdoublon(grille,posi-compte1,posj,compte,'E');         //on prend comme référence pour la recherche des doublons le pion le plus à l'ouest.
			If ((compte < 6) and (doublon=FALSE)) then res:=TRUE;
			If res=TRUE then 
				begin
				verificationcoupsuivant:=verifcoupsuivant(posi-(compte1+1),posi+(compte2+1),0,0,posj,posj,0,0);
				nPoints_nTour:=compte+1;
				If (compte+1)=6 then nPoints_nTour:=nPoints_nTour+6;
				end;
		end;	
	end;
verifattribut2complexe:=res;
end;

 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : verfiattribut3(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : -Vérifier la légalité d'un coup dans le cas où le pion que l'utilisateur souhaite placer a 3 pions voisins.
 						-Compter le nombre de points par coup.
						-Calculer les positions possibles pour un potentiel prochain coup dans le même tour.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)

function verfiattribut3(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;         
var
res,verification1,verification2,verification3,verification4,verification1_3,verification2_4: boolean;
verif1,verif2,verif3,verif4,verif1_3,verif2_4 : typeVerif;
compte1,compte2,compte3,compte4: integer;
begin
	res:=FALSE;
	If ((verif[1]=TRUE) and (verif[3]=TRUE) and (verif[4]=TRUE)) then                                 //cas où le pion est entouré de pions sur N/S/O
		begin
			verif1_3[1]:=TRUE;
			verif1_3[2]:=FALSE;
			verif1_3[3]:=TRUE;
			verif1_3[4]:=FALSE;
			verif4[1]:=FALSE;
			verif4[2]:=FALSE;
			verif4[3]:=FALSE;
			verif4[4]:=TRUE;
			verification1_3:= verifattribut2complexe(grille,posi,posj,verif1_3);
			verification4:= verifattribut1(grille,posi,posj,verif4);
			If ((verification1_3 = TRUE) and (verification4 = TRUE)) then res:=TRUE;
			If res=TRUE then
				begin
					compte1:=comptepion(grille,posi,posj,'N');
					compte3:=comptepion(grille,posi,posj,'S');
					compte4:=comptepion(grille,posi,posj,'O');
					verificationcoupsuivant:=verifcoupsuivant(posi,posi+1,posi,posi-(compte4+1),posj-(compte1+1),posj,posj+(compte3+1),posj);
					nPoints_nTour:=compte1+compte3+compte4+2;
					If (compte1+compte3+1)=6 then nPoints_nTour:=nPoints_nTour+6;
					If (compte4+1)=6 then nPoints_nTour:=nPoints_nTour+6;
				end;
		end;
	If ((verif[1]=TRUE) and (verif[3]=TRUE) and (verif[2]=TRUE)) then                               //cas où le pion est entouré de pions sur N/S/E
		begin
			verif1_3[1]:=TRUE;
			verif1_3[2]:=FALSE;
			verif1_3[3]:=TRUE;
			verif1_3[4]:=FALSE;
			verif2[1]:=FALSE;
			verif2[2]:=TRUE;
			verif2[3]:=FALSE;
			verif2[4]:=FALSE;
			verification1_3:= verifattribut2complexe(grille,posi,posj,verif1_3);
			verification2:= verifattribut1(grille,posi,posj,verif2);
			If ((verification1_3 = TRUE) and (verification2 = TRUE)) then res:=TRUE;
			If res=TRUE then
				begin
					compte1:=comptepion(grille,posi,posj,'N');
					compte2:=comptepion(grille,posi,posj,'E');
					compte3:=comptepion(grille,posi,posj,'S');
					verificationcoupsuivant:=verifcoupsuivant(posi,posi+(compte2+1),posi,posi-1,posj-(compte1+1),posj,posj+(compte3+1),posj);
					nPoints_nTour:=compte1+compte2+compte3+2;
					If (compte1+compte3+1)=6 then nPoints_nTour:=nPoints_nTour+6;
					If (compte2+1)=6 then nPoints_nTour:=nPoints_nTour+6;
				end;
		end;
	If ((verif[2]=TRUE) and (verif[4]=TRUE) and (verif[3]=TRUE)) then                              //cas où le pion est entouré de pions sur O/E/S
		begin
			verif2_4[1]:=FALSE;
			verif2_4[2]:=TRUE;
			verif2_4[3]:=FALSE;
			verif2_4[4]:=TRUE;
			verif3[1]:=FALSE;
			verif3[2]:=FALSE;
			verif3[3]:=TRUE;
			verif3[4]:=FALSE;
			verification2_4:= verifattribut2complexe(grille,posi,posj,verif2_4);
			verification3:= verifattribut1(grille,posi,posj,verif3);
			If ((verification2_4 = TRUE) and (verification3 = TRUE)) then res:=TRUE;
			If res=TRUE then
				begin
					compte2:=comptepion(grille,posi,posj,'E');
					compte4:=comptepion(grille,posi,posj,'O');
					compte3:=comptepion(grille,posi,posj,'S');
					verificationcoupsuivant:=verifcoupsuivant(posi,posi+(compte2+1),posi,posi-(compte4+1),posj-1,posj,posj+(compte3+1),posj);
					nPoints_nTour:=compte2+compte3+compte4+2;
					If (compte2+compte4+1)=6 then nPoints_nTour:=nPoints_nTour+6;
					If (compte3+1)=6 then nPoints_nTour:=nPoints_nTour+6;
				end;
		end;
	If ((verif[2]=TRUE) and (verif[4]=TRUE) and (verif[1]=TRUE)) then                               //cas où le pion est entouré de pions sur O/E/N
		begin
			verif2_4[1]:=FALSE;
			verif2_4[2]:=TRUE;
			verif2_4[3]:=FALSE;
			verif2_4[4]:=TRUE;
			verif1[1]:=TRUE;
			verif1[2]:=FALSE;
			verif1[3]:=FALSE;
			verif1[4]:=FALSE;
			verification2_4:= verifattribut2complexe(grille,posi,posj,verif2_4);
			verification1:= verifattribut1(grille,posi,posj,verif1);
			If ((verification2_4 = TRUE) and (verification1 = TRUE)) then res:=TRUE;
			If res=TRUE then
				begin
					compte2:=comptepion(grille,posi,posj,'E');
					compte4:=comptepion(grille,posi,posj,'O');
					compte1:=comptepion(grille,posi,posj,'N');
					verificationcoupsuivant:=verifcoupsuivant(posi,posi+(compte2+1),posi,posi-(compte4+1),posj-(compte1+1),posj,posj+1,posj);
					nPoints_nTour:=compte1+compte2+compte4+2;
					If (compte2+compte4+1)=6 then nPoints_nTour:=nPoints_nTour+6;
					If (compte1+1)=6 then nPoints_nTour:=nPoints_nTour+6;
				end;
		end;
verfiattribut3:=res;
end;

 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : verifattribut4(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : -Vérifier la légalité d'un coup dans le cas où le pion que l'utilisateur souhaite placer a 4 pions voisins.
						-Compter le nombre de points par coup.
						-Calculer les positions possibles pour un potentiel prochain coup dans le même tour.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function verifattribut4(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;         //cas où le pion qu'on veut placer est entouré de quatre pions.
var
res,verification1_3,verification2_4: boolean;
verif1_3,verif2_4 : typeVerif;
compte1,compte2,compte3,compte4: integer;
begin
	res:=FALSE;
	verif1_3[1]:=TRUE;
	verif1_3[2]:=FALSE;
	verif1_3[3]:=TRUE;
	verif1_3[4]:=FALSE;
	verif2_4[1]:=FALSE;
	verif2_4[2]:=TRUE;
	verif2_4[3]:=FALSE;
	verif2_4[4]:=TRUE;
	verification1_3:= verifattribut2complexe(grille,posi,posj,verif1_3);
	verification2_4:= verifattribut2complexe(grille,posi,posj,verif2_4);
	If ((verification1_3 = TRUE) and (verification2_4 = TRUE)) then res:=TRUE;
	If res=TRUE then
				begin
					compte1:=comptepion(grille,posi,posj,'N');
					compte2:=comptepion(grille,posi,posj,'E');
					compte3:=comptepion(grille,posi,posj,'S');
					compte4:=comptepion(grille,posi,posj,'O');
					verificationcoupsuivant:=verifcoupsuivant(posi,posi+(compte2+1),posi,posi-(compte4+1),posj-(compte1+1),posj,posj+(compte3+1),posj);
					nPoints_nTour:=compte1+compte2+compte3+compte4+2;
					If (compte1+compte3+1)=6 then nPoints_nTour:=nPoints_nTour+6;
					If (compte2+compte4+1)=6 then nPoints_nTour:=nPoints_nTour+6;
				end;
	verifattribut4:=res;
end;	
 
 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : verifattributfinal(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean; 
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Appeler la bonne fonction en fonction du nombre de voisins.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)		
function verifattributfinal(grille: typeGrille; posi,posj: integer; verif: typeVerif): boolean;         
var
res: boolean;
begin
	res:=FALSE;
	If ((verif[1]=TRUE) or (verif[2]=TRUE) or (verif[3]=TRUE) or (verif[4]=TRUE)) then
		res:=verifattribut1(grille,posi,posj,verif);
	If (((verif[1]=TRUE) and (verif[4]=TRUE)) or ((verif[1]=TRUE) and (verif[2]=TRUE)) or ((verif[3]=TRUE) and (verif[4]=TRUE)) or ((verif[2]=TRUE) and (verif[3]=TRUE))) then
		res:=verifattribut2facile(grille,posi,posj,verif);
	If (((verif[1]=TRUE) and (verif[3]=TRUE)) or ((verif[2]=TRUE) and (verif[4]=TRUE))) then
		res:=verifattribut2complexe(grille,posi,posj,verif);
	If (((verif[1]=TRUE) and (verif[3]=TRUE) and (verif[4]=TRUE)) or ((verif[1]=TRUE) and (verif[3]=TRUE) and (verif[2]=TRUE)) or ((verif[2]=TRUE) and (verif[4]=TRUE) and (verif[3]=TRUE)) or ((verif[2]=TRUE) and (verif[4]=TRUE) and (verif[1]=TRUE))) then
		res:=verfiattribut3(grille,posi,posj,verif);
	If ((verif[1]=TRUE) and (verif[2]=TRUE) and (verif[3]=TRUE) and (verif[4]=TRUE)) then
		res:=verifattribut4(grille,posi,posj,verif);
	If res=FALSE then 
		writeln('Erreur. Le pion que vous souhaitez placer n est pas valide');
		writeln();
	verifattributfinal:=res;
end;

 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : verifcoupsuivant(i1,i2,i3,i4,j1,j2,j3,j4: integer): typeVerif2;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Renvoyez toutes les positions possibles où l'on peut placer un pion après en avoir déjà placé un dans le même tour.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function verifcoupsuivant(i1,i2,i3,i4,j1,j2,j3,j4: integer): typeVerif2;
var
res: typeVerif2;
begin
	res[1,1]:=i1;
	res[1,2]:=i2;
	res[1,3]:=i3;
	res[1,4]:=i4;
	res[2,1]:=j1;
	res[2,2]:=j2;
	res[2,3]:=j3;
	res[2,4]:=j4;
verifcoupsuivant:=res;
end;

 (* -------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Fonction          : testcoupsuivant(posi,posj: integer): boolean;
 -- Auteur            : SOULAGE Tom, VAUXEL Paul 
 -- But               : Dans le cas où l'utilisateur souhaite jouer un autre coup dans le même tour, on teste si la position où il souhaite placer son pion correspond avec celles calculer avec la fonction du dessus.
 -- Pré conditions    : Aucune
 -- Post conditions   : Aucune
 ------------------------------------------------------------------------------------------------------------------------------------------------------ *)
function testcoupsuivant(posi,posj: integer): boolean;
var
bool_i,bool_j,res: boolean;
i:integer;
begin
	bool_i:=FALSE;
	bool_j:=FALSE;
	res:=FALSE;
	For i:=1 to 4 do
		begin
			If verificationcoupsuivant[1,i] = posi then bool_i:=TRUE;
		end;
	For i:=1 to 4 do
		begin
			If verificationcoupsuivant[2,i] = posj then bool_j:=TRUE;
		end;
	If (bool_i=TRUE) and (bool_j=TRUE) then res:=TRUE;
	testcoupsuivant:=res;
end;

end.
