(*
 ------------------------------------------------------------------------------------------------------------------------------------
 -- Fichier           : QwirkleJeu.pas
 -- Auteur            : SOULAGE Tom, VAUXEL Paul  <soulagetom@eisti.eu> <vauxelpaul@eisti.eu>
 -- Date de creation  : 20/06/2018
 -- Compilation       : fpc
 -- Edition des liens : fpc
 -- Execution         : shell
 -------------------------------------------------------------------------------------------------------------------------------------
 *)

program qwirkle;

uses UnitType,Crt,Upioche,Ugrille,Upion,UmanipListe,UregleQwirkle,Umain;

var
	pioche: 			pointeur;
	mainA,mainB:		typeMain;
	main1,main2:		typeMain;
	pion:				typePion;
	i,j:				integer;
	agej1,agej2:		integer;
	com1,com2:          integer;
	l,k,g:  				integer;
	verif: 				typeVerif;
	bool_1:		boolean;
	grille:				typeGrille;
	rep: 				string;
	jA,jB:				string;
	j1,j2: 				string;
	pionPoint: 			typePion;
	compteur2pionPose,nbP:  integer;
	fintour: 			boolean;
	coupsuivant:		boolean;
	compteurpioche:		integer;
	testmain1,testmain2:	boolean;
	pointj1,pointj2:	integer;
begin
	randomize();
	////////////////////
	fintour:=false;
	pionPoint:=creerPion('.',7);
	compteurpioche:=108;
	pointj1:=0;
	pointj2:=0;
	////////////////////////////////initialisation du jeu
	
	grille:=initGrille();																
	pioche:=initPioche(108);											
	pioche:=melangePioche(pioche);
	mainA:=initMainJoueur(pioche);								
	pioche:=PiocheApresDistribution(pioche);
	mainB:=initMainJoueur(pioche);
	pioche:=PiocheApresDistribution(pioche);
	compteurpioche:=96;
	/////////////////////////////////////////////////////
TextColor(10);	
writeln(' ______     __     __     __     ______     __  __     __         ______    ');
TextColor(14);	
writeln('/\  __ \   /\ \  _ \ \   /\ \   /\  == \   /\ \/ /    /\ \       /\  ___\   ');
TextColor(13);	
writeln('\ \ \/\_\  \ \ \/ ".\ \  \ \ \  \ \  __<   \ \  _"-.  \ \ \____  \ \  __\   ');
TextColor(9);	
writeln(' \ \___\_\  \ \__/".~\_\  \ \_\  \ \_\ \_\  \ \_\ \_\  \ \_____\  \ \_____\ ');
TextColor(12);	
writeln('  \/___/_/   \/_/   \/_/   \/_/   \/_/ /_/   \/_/\/_/   \/_____/   \/_____/ ');                                                                  
	////////////////////////////////////////////////////////////////////////initialisation joueurs	
	TextColor(7);		
	writeln('Joueur1, veuillez rentrer votre prenom');
	readln(jA);
	writeln('Joueur1, veuillez rentrer votre age');
	readln(agej1);
	
	
	writeln('Joueur2, veuillez rentrer votre prenom');
	readln(jB);
	writeln('Joueur2, veuillez rentrer votre age');
	readln(agej2);
	ClrScr;
	begin
		repeat
			afficherMainJoueur(mainA,jA);	
			writeln();
			writeln(jA,' :indique le nombre de vos pions ayant un attribut commun, couleur ou forme, sans compter les pions en double, attention prenez le nombre de plus eleve');		
			readln(com1);
		until ((com1>=0) and (com1<=6))		
	end;
	ClrScr;		
	begin
		repeat
			afficherMainJoueur(mainB,jB);
			writeln();
			writeln(jB,' :indique le nombre de vos pions ayant un attribut commun, couleur ou forme, sans compter les pions en double, attention prenez le nombre de plus eleve');		
			readln(com2);
		until ((com2>=0) and (com2<=6))		
	end;			
	begin
		if com2>com1 then															//verifie que le 2eme joueur n'a pas plus de pions ayant un attribut commun dans sa pioche, que le joueur 1
			begin
				for l:=1 to 6 do															//si c'est le cas on échange les mains	
					begin
						main1[l]:=mainB[l];
						main2[l]:=mainA[l];
					end;	 																	
				j1:=jB;
				j2:=jA;
			end
		else 
			if com1=com2 then
				begin												//si égalité , on regarde l'age, sachant que le joueur le plus âgé commence
					for k:=1 to 6 do															//si c'est le cas on échange les mains	
						begin
							main1[k]:=mainB[k];
							main2[k]:=mainA[k];
						end;	 
					j1:=jB;
					j2:=jA;
				end 
			else
				begin
					for l:=1 to 6 do															
						begin
							main2[l]:=mainB[l];
							main1[l]:=mainA[l];
						end;																
					j2:=jB;
					j1:=jA;
				end;
	end;			
						
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////1er tour du joueur 1, avec obligation de poser un pion					
	ClrScr();
	writeln(j1, ' commence');
	writeln();
	writeln(j1,' a ',pointj1,' points.');												
	afficherMainJoueur(main1,j1);										
	pion:=choisirPion(main1);
	grille:=insererPremierPion(grille,pion);
	afficherGrille(grille);
	main1:=RemplacerPionInsere(main1,pion);
	ClrScr();
	compteur2pionPose:=0;
	begin
		repeat
			begin																				
				repeat  
					writeln();
					afficherGrille(grille);
					writeln();
					afficherMainJoueur(main1,j1);
					writeln();
					writeln(j1,' voulez-vous un deuxieme pion dans la grille ? oui/non ?');	
					readln(rep);
				until (( rep='oui') or (rep='non'))
			end;				  
			if rep='oui' then
						begin
							afficherMainJoueur(main1, j1);
							pion:=choisirPion(main1);
							afficherGrille(grille);
							begin
								repeat
								i:=insererPionCoordoneesi(grille);
								j:=insererPionCoordoneesj(grille);
								until ((grille[i,j].forme=pionPoint.forme) and (grille[i,j].couleur=pionPoint.couleur));
							end;
							grille:=insererPion(grille,pion,i,j);
							verif:=verifposition(grille,i,j);
							bool_1:=verifattributfinal(grille,i,j,verif);
							if bool_1=true then
								begin
									main1:=RemplacerPionInsere(main1,pion);
									compteur2pionPose:= 1 + compteur2pionPose;
									compteurpioche:= compteurpioche - 1;
									afficherGrille(grille);
									begin
										repeat
											afficherGrille(grille);
											afficherMainJoueur(main1,j1);
											writeln(j1,' voulez-vous continuer a poser des pions? oui/non?');
											readln(rep);
											if rep='oui' then
												begin
													afficherMainJoueur(main1, j1);
													pion:=choisirPion(main1);
													ClrScr();
													afficherGrille(grille);
													begin
														repeat
															i:=insererPionCoordoneesi(grille);
															j:=insererPionCoordoneesj(grille);
														until ((grille[i,j].forme=pionPoint.forme) and (grille[i,j].couleur=pionPoint.couleur));
													end;
													coupsuivant:=testcoupsuivant(i,j);
													If (coupsuivant=TRUE) then 
														begin
															grille:=insererPion(grille,pion,i,j);
															verif:=verifposition(grille,i,j);															//vérification des règles du jeu
															bool_1:=verifattributfinal(grille,i,j,verif);
															if bool_1=true then																			//cas où le pion inseré respecte les règles 
																begin
																	main1:=RemplacerPionInsere(main1,pion);
																	compteur2pionPose:= 1 + compteur2pionPose;
																	compteurpioche:= compteurpioche - 1;
																	afficherGrille(grille);
																end
															else 
																begin
																	grille[i,j]:=pionPoint;	//comme on inseré le pion choisi pour pouvoir vérifier les règles, si le pion ne vérifie pas les règles dans la grille alors on remet la valeur initiale de la grille à la place des coordonnées choisis par le joueur
																end;			
														end
													else
														begin
															writeln('Erreur. Impossible de placer le pion ici');
														end;				
												end																
											else	
												begin													//le joueur a déjà poser des pions dans la grille, donc il ne peut pas choisir de remplacer des pions, alors on remplit les pions manquants de pions provenant de la pioche
													for i:=1 to 6 do
														begin
															if main1[i].forme = pionPoint.forme then 
																begin
																	main1:=echangerPion(main1,pionPoint,pioche); 
																	pioche:=suppressionTete(pioche);
																end;
														end;
													pointj1:=pointj1+nPoints_nTour;		
													fintour:=true;		
												end;
										until (fintour=TRUE);		
									end
								end
							else 
								begin
									grille[i,j]:=pionPoint;
								end;							
						end																
			else	
				begin													//le joueur a déjà poser des pions dans la grille, donc il ne peut pas choisir de remplacer des pions, alors on remplit les pions manquants de pions provenant de la pioche
					for i:=1 to 6 do
						begin
							if main1[i].forme = pionPoint.forme then 
								begin
									main1:=echangerPion(main1,pionPoint,pioche); 
									pioche:=suppressionTete(pioche);
								end;
						end;
					pointj1:=pointj1+nPoints_nTour;			
					fintour:=true;		
				end;	
		until fintour = true
	end;		
	ClrScr;		
///////////////////////////////////////////////////////////////////////suite du jeu		
	fintour:=false;
	compteur2pionPose:=0;
	begin
		repeat	
					begin																				//joueur 2
						repeat							
							writeln();
							afficherGrille(grille);
							writeln();
							writeln(j2,' a ',pointj2,' points.');
							writeln();
							afficherMainJoueur(main2, j2);	
							writeln(j2,' voulez-vous poser des pions dans la grille ? oui/non ?');	
							readln(rep);
						until (( rep='oui') or (rep='non'))
					end;		  
					if rep='oui' then
						begin
							afficherMainJoueur(main2, j2);
							pion:=choisirPion(main2);
							afficherGrille(grille);
							begin
								repeat
									i:=insererPionCoordoneesi(grille);
									j:=insererPionCoordoneesj(grille);
								until ((grille[i,j].forme=pionPoint.forme) and (grille[i,j].couleur=pionPoint.couleur));
							end;
							grille:=insererPion(grille,pion,i,j);
							verif:=verifposition(grille,i,j);
							bool_1:=verifattributfinal(grille,i,j,verif);
							if bool_1=true then
								begin
									main2:=RemplacerPionInsere(main2,pion);
									compteur2pionPose:= 1 + compteur2pionPose;
									compteurpioche:= compteurpioche - 1;
									begin
										repeat
											afficherGrille(grille);
											afficherMainJoueur(main2,j2);
											writeln(j2,' voulez-vous continuer a poser des pions? oui/non?');
											readln(rep);
											if rep='oui' then
												begin
													afficherMainJoueur(main2, j2);
													pion:=choisirPion(main2);
													ClrScr();
													afficherGrille(grille);
													begin
														repeat
															i:=insererPionCoordoneesi(grille);
															j:=insererPionCoordoneesj(grille);
														until ((grille[i,j].forme=pionPoint.forme) and (grille[i,j].couleur=pionPoint.couleur));
													end;
													coupsuivant:=testcoupsuivant(i,j);
													If (coupsuivant=TRUE) then 
														begin
															grille:=insererPion(grille,pion,i,j);
															verif:=verifposition(grille,i,j);															//vérification des règles du jeu
															bool_1:=verifattributfinal(grille,i,j,verif);
															if bool_1=true then																			//cas où le pion inseré respecte les règles 
																begin
																	main2:=RemplacerPionInsere(main2,pion);
																	compteur2pionPose:= 1 + compteur2pionPose;
																	compteurpioche:= compteurpioche - 1;
																	afficherGrille(grille);
																end
															else 
																begin
																	grille[i,j]:=pionPoint;	//comme on inseré le pion choisi pour pouvoir vérifier les règles, si le pion ne vérifie pas les règles dans la grille alors on remet la valeur initiale de la grille à la place des coordonnées choisis par le joueur
																end;			
														end
													else
														begin
															writeln('Erreur. Impossible de placer le pion ici');
														end;				
												end																
											else	
												begin													//le joueur a déjà poser des pions dans la grille, donc il ne peut pas choisir de remplacer des pions, alors on remplit les pions manquants de pions provenant de la pioche
													for i:=1 to 6 do
														begin
															if main2[i].forme = pionPoint.forme then 
																begin
																	main2:=echangerPion(main2,pionPoint,pioche); 
																	pioche:=suppressionTete(pioche);
																end;
														end;
													pointj2:=pointj2+nPoints_nTour;		
													fintour:=true;		
												end;
										until (fintour=TRUE);		
									end
								end
							else 
								begin
									grille[i,j]:=pionPoint;
								end;						
						end																
					else 
						begin
							if compteur2pionPose=0 then
								begin										//cas ou le joueur veut échanger de pion dès le début
									afficherMainJoueur(main2, j2);
									begin	
										repeat
										writeln('combien voulez-vous echanger de pion?');
										read(nbP);
										until((nbP>0) and (nbP<7))
									end;	
									g:=0;
									while g<>nbP do
										begin 
											pion:=choisirPion(main2);
											main2:=echangerPion(main2,pion,pioche);
											pioche:=suppressionTete(pioche);
											pioche:=ajouterPionPiocheDebut(pioche,pion);
											pioche:=melangePioche(pioche);
											afficherMainJoueur(main2,j2);	
											g:=g+1;																							
										end;											
									fintour:=true;
								end
							else								
								begin													//cas ou le joueur a déjà poser des pions dans la grille, donc il ne peut pas choisir de remplacer des pions, alors on remplit les pions manquants de pions provenant de la pioche
									for i:=1 to 6 do
										begin
											if main2[i].forme = pionPoint.forme then 
												begin
													main2:=echangerPion(main2,pionPoint,pioche); 
													pioche:=suppressionTete(pioche);
												end;
										end;			
								end;
							pointj2:=pointj2+nPoints_nTour;	
							fintour:=true;			
						end;			
			ClrScr();		
			fintour:=false;
			compteur2pionPose:=0;
																						//joueur 1
										
					begin																				
						repeat 
						writeln();		
						afficherGrille(grille);
						writeln();
						writeln(j1,' a ',pointj1,' points.');	
						writeln();	 
						afficherMainJoueur(main1, j1);	
						writeln(j1,' voulez-vous poser des pions dans la grille ? oui/non ?');	
						readln(rep);
						until (( rep='oui') or (rep='non'))
					end;		  
					if rep='oui' then
						begin
							afficherMainJoueur(main1, j1);
							pion:=choisirPion(main1);
							afficherGrille(grille);
							begin
								repeat
								i:=insererPionCoordoneesi(grille);
								j:=insererPionCoordoneesj(grille);
								until ((grille[i,j].forme=pionPoint.forme) and (grille[i,j].couleur=pionPoint.couleur));
							end;
							grille:=insererPion(grille,pion,i,j);
							verif:=verifposition(grille,i,j);
							bool_1:=verifattributfinal(grille,i,j,verif);
							if bool_1=true then
								begin
									main1:=RemplacerPionInsere(main1,pion);
									compteur2pionPose:= 1 + compteur2pionPose;
									compteurpioche:= compteurpioche - 1;
									afficherGrille(grille);
									begin
										repeat
											afficherGrille(grille);
											afficherMainJoueur(main1,j1);
											writeln(j1,' voulez-vous continuer a poser des pions? oui/non?');
											readln(rep);
											if rep='oui' then
												begin
													afficherMainJoueur(main1, j1);
													pion:=choisirPion(main1);
													ClrScr();
													afficherGrille(grille);
													begin
														repeat
															i:=insererPionCoordoneesi(grille);
															j:=insererPionCoordoneesj(grille);
														until ((grille[i,j].forme=pionPoint.forme) and (grille[i,j].couleur=pionPoint.couleur));
													end;
													coupsuivant:=testcoupsuivant(i,j);
													If (coupsuivant=TRUE) then 
														begin
															grille:=insererPion(grille,pion,i,j);
															verif:=verifposition(grille,i,j);															//vérification des règles du jeu
															bool_1:=verifattributfinal(grille,i,j,verif);
															if bool_1=true then																			//cas où le pion inseré respecte les règles 
																begin
																	main1:=RemplacerPionInsere(main1,pion);
																	compteur2pionPose:= 1 + compteur2pionPose;
																	compteurpioche:= compteurpioche - 1;
																	afficherGrille(grille);
																end
															else 
																begin
																	grille[i,j]:=pionPoint;	//comme on inseré le pion choisi pour pouvoir vérifier les règles, si le pion ne vérifie pas les règles dans la grille alors on remet la valeur initiale de la grille à la place des coordonnées choisis par le joueur
																end;			
														end
													else
														begin
															writeln('Erreur. Impossible de placer le pion ici');
														end;				
												end																
											else	
												begin													//le joueur a déjà poser des pions dans la grille, donc il ne peut pas choisir de remplacer des pions, alors on remplit les pions manquants de pions provenant de la pioche
													for i:=1 to 6 do
														begin
															if main1[i].forme = pionPoint.forme then 
																begin
																	main1:=echangerPion(main1,pionPoint,pioche); 
																	pioche:=suppressionTete(pioche);
																end;
														end;
													pointj1:=pointj1+nPoints_nTour;			
													fintour:=true;		
												end;
										until (fintour=TRUE);		
									end
								end
							else 
								begin
									grille[i,j]:=pionPoint;
								end;							
						end																
					else 
						begin
							if compteur2pionPose=0 then
								begin										
									afficherMainJoueur(main1, j1);
									begin	
										repeat
											writeln('combien voulez-vous echanger de pion?');
											read(nbP);
										until((nbP>0) and (nbP<7))
									end;
									g:=0;
									while g<>nbP do
										begin 
											pion:=choisirPion(main1);
											main1:=echangerPion(main1,pion,pioche);
											pioche:=suppressionTete(pioche);
											pioche:=ajouterPionPiocheDebut(pioche,pion);
											pioche:=melangePioche(pioche);
											afficherMainJoueur(main1,j1);	
											g:=g+1;																							
										end;													
								end
							else								
								begin													
									for i:=1 to 6 do
										begin
											if main1[i].forme = pionPoint.forme then 
												begin
													main1:=echangerPion(main1,pionPoint,pioche); 
													pioche:=suppressionTete(pioche);
												end;
										end;			
								end;
							pointj1:=pointj1+nPoints_nTour;
							fintour:=true;			
						end;		
			
			testmain1:=testmainpionnul(main1);
			testmain2:=testmainpionnul(main2);
	until (compteurpioche=0) and ((testmain1=TRUE) or (testmain2=TRUE))
	end;		
end.
