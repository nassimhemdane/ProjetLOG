:- dynamic( nb_stations/2 ).
:- dynamic( num_stations/6).



/* Create_nbstations */
/* Creation du predicat nb_stations */

nb_stations(NomLigne, _):- \+ligne(NomLigne,_,_,_,_),!, write(' Il n\'y a pas de ligne avec ce nom! '),fail.
nb_stations(NomLigne, NbArrets):- ligne(NomLigne,_,L,_,_),length(L, NbArrets).

/* Creation_nbstations enumères toutes les lignes et leur nombre d arrêts */

create_nbstations :-
		assert(nb_stations(X,Y)).

/* Create_numstation */
/* Creation du preducat num_stations */

num_stations(NomStation, NomLigne, Dir1, NumD1, Dir2, NumD2):- ligne(NomLigne,_,[Dir2|L],_,_),
															last([Dir2|L],Dir1),nth1(NumD1, [Dir2|L], NomStation),
															length([Dir2|L],N),N2 is NumD1 -1 ,NumD2 is N - N2.

num_stations(NomStation, NomLigne, Dir2, NumD2, Dir1, NumD1):- ligne(NomLigne,_,[Dir2|L],_,_),
															last([Dir2|L],Dir1),nth1(NumD1, [Dir2|L], NomStation),
															length([Dir2|L],N),N2 is NumD1 -1 ,NumD2 is N - N2.


create_numstation :-
		assert(num_stations(A,B,C,D,E,F)).


/* Station */

ligne_station(X,S):-ligne(X,_,L,_,_),member(S,L). 

station(Station,LLignes):-
			findall(X,ligne_station(X,Station),LLignes).


/* Intersection */

is_intersection(Ligne1,Ligne2,Station):-
						ligne_station(Ligne1,Station),ligne_station(Ligne2,Station).

intersection(Ligne1, Ligne2, LStations) :- 
				findall(X,is_intersection(Ligne1,Ligne2,X),LStations).

/* Correspondance */


is_correspondance(Ligne,[X,S]):-ligne_station(Ligne,S),ligne_station(X,S),X\=Ligne.

correspondances(Ligne,LLignes):-
							findall(X,is_correspondance(Ligne,X),LLignes).

/* Dessert */

dessert(Ligne,Depart,Arrivee):- ligne_station(Ligne,Depart),
								ligne_station(Ligne,Arrivee).

/* Nbarrets */

nbarret(Ligne, Depart, Arrivee, Dir, NbArrets):- 
						num_stations(Depart, Ligne, Dir, NumD12,_,_),
						num_stations(Arrivee, Ligne, Dir, NumD22,_, _),
						 NumD22 >= NumD12, NbArrets is NumD22 - NumD12 .

nbarret(Ligne, Depart, Arrivee, Dir, NbArrets):- 
						ligne(Ligne,_,L,_,_),
						num_stations(Depart, Ligne, Dir, NumD12,_,_),
						num_stations(Arrivee, Ligne, Dir, NumD22,_, _),
						 NumD22 =< NumD12, 
						 Nb is NumD12 - NumD22,
						 length(L,Len), 
						 Nb2 is Len - NumD12,
						 Nb3 is 2*Nb2,
						 NbArrets is Nb3 + Nb .


min_arrets(Ligne,Depart,Arrivee,NbArrets):- 
									nbarret(Ligne, Depart, Arrivee, Dir, NbArrets),
									nbarret(Ligne, Depart, Arrivee, Dir2, Nb2),
									Dir\=Dir2, NbArrets < Nb2.

/* Itinieraire */



itineraire(Depart, Arrivee, [[[Depart,S,L]|GL],[[Ligne,S]|GC]]):- 
												is_correspondance(L,[Ligne,S]),
												dessert(L,Depart,S),Depart \=S,
												itineraire(S,Arrivee,[GL,GC]),
												\+member([_,S],GC).

itineraire(Depart, Arrivee, [[[Depart,Arrivee,Ligne]],[]]):- 
						dessert(Ligne,Depart,Arrivee).


/* Liste Itinieraires */


listeitineraire(Depart, Arrivee, LTrajet):-
										findall(X,itineraire(Depart,Arrivee,X),LTrajet).

/* Temps Trajet */

tempstrajet([[[Depart,S,L]|GL],[[_,S]|GC]], Tps):-tempstrajet([GL,GC],N),
										min_arrets(L,Depart,S,Nb),
										N2 is Nb+5,
										Tps is N + N2.
tempstrajet([[[Depart,S,L]],[]], Tps):- min_arrets(L,Depart,S,Tps).



/* [[[pont_de_neuilly,chatelet,m1],[chatelet,nation,rerA],[nation,iena,m9]],[[rerA,chatelet],[m9,nation]]] */

/* [[[montparnasse_bienvenue,marcadet_poissonniers,m4],[marcadet_poissonniers,montparnasse_bienvenue,m12],[montparnasse_bienvenue,marcadet_poissonniers,m4],[marcadet_poissonniers,montparnasse_bienvenue,m12],[montparnasse_bienvenue,bercy,m6]],[[m12,marcadet_poissonniers],[m4,montparnasse_bienvenue],[m12,marcadet_poissonniers],[m6,montparnasse_bienvenue]]] */


/* reseaux emprutés */

reseau_emprunte([[[_,_,L]|GL],[_|GC]], LR):-metro(L),reseau_emprunte([GL,GC],LR),member(metro,LR).
reseau_emprunte([[[_,_,L]|GL],[_|GC]], [metro|LR]):-metro(L),reseau_emprunte([GL,GC],LR),\+member(metro,LR).
reseau_emprunte([[[_,_,L]|GL],[_|GC]], LR):-rer(L),reseau_emprunte([GL,GC],LR),member(rer,LR).
reseau_emprunte([[[_,_,L]|GL],[_|GC]], [rer|LR]):-rer(L),reseau_emprunte([GL,GC],LR),\+member(rer,LR).
reseau_emprunte([[[_,_,L]|GL],[_|GC]], LR):-tram(L),reseau_emprunte([GL,GC],LR),member(tram,LR).
reseau_emprunte([[[_,_,L]|GL],[_|GC]], [tram|LR]):-tram(L),reseau_emprunte([GL,GC],LR),\+member(tram,LR).
reseau_emprunte([[[_,_,L]],[]], LReseau):- metro(L),append([metro],[],LReseau).
reseau_emprunte([[[_,_,L]],[]], LReseau):- rer(L),append([rer],[],LReseau).
reseau_emprunte([[[_,_,L]],[]], LReseau):- tram(L),append([tram],[],LReseau).





metro(m1).
metro(m2).
metro(m3).
metro(m4).
metro(m5).
metro(m6).
metro(m7).
metro(m8).
metro(m9).
metro(m10).
metro(m11).
metro(m12).
metro(m13).
metro(m3b).
metro(m7inter1).
metro(m7inter1).
metro(m7b).
metro(m13inter1).
metro(m13inter2).
metro(m14).
rer(rerA).
rer(rerB).
rer(rerC1).
rer(rerC2).
rer(rerD).
rer(rerE).
tram(t1).
tram(t2).
tram(t3).

















/* Les lignes de metro */


ligne(m1, metro,[la_defense, 
		 esplanade_defense,
		 pont_de_neuilly, 
		 les_sablons, 
		 porte_maillot, 
		 argentine,
		 charles_de_gaulle_etoile,
		 george_V, 
		 franklin_d_roosevelt,
		 champs_elysees_clemenceau,
		 concorde, 
		 tuileries,
		 palais_royal_musee_du_louvre,
		 louvre_rivoli, 
		 chatelet,
		 hotel_de_ville, 
		 saint_paul,
		 bastille, 
		 gare_de_lyon,
		 reuilly_diderot, 
		 nation,
		 porte_de_vincennes, 
		 saint_mande,
		 berault, 
		 chateau_de_vincennes], 
      la_defense, chateau_de_vincennes).

ligne(m2, metro, [nation,
		  avron, 
		  alexandre_dumas,
		  philippe_auguste,
		  pere_lachaise,
		  menilmontant,
		  couronnes,
		  belleville,
		  colonel_fabien,
		  jaures,
		  stalingrad,
		  la_chapelle,
		  barbes_rochechouart,
		  anvers,
		  pigalle,
		  blanche,
		  place_clichy,
		  rome,
		  villiers,
		  monceau,
		  courcelles,
		  ternes,
		  charles_de_gaulle_etoile,
		  victor_hugo,
		  porte_dauphine],
      nation, porte_dauphine).

ligne(m3, metro, [pont_levallois_becon,
		  anatole_france,
		  louise_michel,
		  porte_de_champerret,
		  pereire,
		  wagram,
		  malesherbes,
		  villiers,
		  europe,
		  saint_lazare,
		  havre_caumartin,
		  opera,
		  quatre_septembre,
		  bourse,
		  sentier,
		  reaumur_sebastopol,
		  arts_metiers,
		  temple,
		  republique,
		  parmentier,
		  rue_saint_maur,
		  pere_lachaise,
		  gambetta,
		  porte_de_bagnolet,
		  gallieni],
      pont_levallois_becon, gallieni).

ligne(m3b, metro, [porte_lilas,
		   saint_fargeau,
		   pelleport,
		   gambetta],
      porte_lilas, gambetta).


ligne(m4, metro, [porte_de_clignancourt,
		  simplon,
		  marcadet_poissonniers,
		  chateau_rouge,
		  barbes_rochechouart,
		  gare_du_nord,
		  gare_de_est,
		  chateau_eau,
		  strasbourg_saint_denis,
		  reaumur_sebastopol,
		  etienne_marcel,
		  les_halles,
		  chatelet,
		  cite,
		  saint_michel,
		  odeon,
		  saint_germain_des_pres,
		  saint_sulpice,
		  saint_placide,
		  montparnasse_bienvenue,
		  vavin,
		  raspail,
		  denfert_rochereau,
		  mouton_duvernet,
		  alesia,
		  porte_orleans],
      porte_de_clignancourt, porte_orleans).

ligne(m5, metro, [
		 bobigny_pablo_picasso, 
		 bobigny_pantin, 
		 eglise_de_pantin, 
		 hoche,
		 porte_pantin,
		 ourcq,
		 laumiere,
		 jaures,
		 stalingrad,
		 gare_du_nord,
		 gare_de_est,
		 jacques_bonsergent,
		 republique,
		 oberkampf,
		 richard_lenoir,
		 breguet_sabin,
		 bastille,
		 quai_de_la_rapee,
		 gare_austerlitz,
		 saint_marcel,
		 campo_formio,
		 place_italie],
    bobigny_pablo_picasso, place_italie).

ligne(m6, metro, [charles_de_gaulle_etoile,
		  kleber,
		  boissiere,
		  trocadero,
		  passy,
		  bir_hakeim,
		  dupleix,
		  la_motte_picquet_grenelle,
		  cambronne,
		  sevres_lecourbe,
		  pasteur,
		  montparnasse_bienvenue,
		  edgar_quinet,
		  raspail,
		  denfert_rochereau,
		  saint_jacques,
		  glaciere,
		  corvisart,
		  place_italie,
		  nationale,
		  chevaleret,
		  quai_de_la_gare,
		  bercy,
		  dugommier,
		  daumesnil,
		  bel_air,
		  picpus,
		  nation],
      charles_de_gaulle_etoile, nation).


ligne(m7, metro, [la_courneuve,
		  fort_aubervilliers,
		  aubervilliers_pantin_quatre_chemins,
		  porte_de_la_villette,
		  corentin_cariou,
		  crimee,
		  riquet,
		  stalingrad,
		  louis_blanc,
		  chateau_landon,
		  gare_de_est,
		  verdun,
		  poissonniere,
		  cadet,
		  le_peletier,
		  chaussee_antin_la_fayette,
		  opera,
		  pyramides,
		  palais_royal_musee_du_louvre,
		  pont_neuf,
		  chatelet,
		  pont_marie,
		  sully_morland,
		  jussieu,
		  place_monge,
		  censier_daubenton,
		  les_gobelins,
		  place_italie,
		  tolbiac,
		  maison_blanche],
      la_courneuve, maison_blanche).

ligne(m7inter1, metro, [maison_blanche,
			le_kremlin_bicetre,
			villejuif_leo_lagrange,
			villejuif_paul_vaillant_couturier,
			villejuif_louis_aragon], 
      maison_blanche, villejuif_louis_aragon).

ligne(m7inter2, metro, [maison_blanche,
			porte_italie,
			porte_de_choisy,
			porte_ivry,
			pierre_et_marie_curie,
			mairie_ivry], 
      maison_blanche, mairie_ivry).


ligne(m7b, metro, [pre_saint_gervais,
		   place_fetes, 
		   danube, 
		   bolivar, 
		   buttes_chaumont, 
		   botzaris, 
		   jaures, 
		   louis_blanc], 
      pre_saint_gervais, louis_blanc).

ligne(m8, metro, [balard,
		  lourmel,
		  boucicaut,
		  felix_faure,
		  commerce,
		  la_motte_picquet_grenelle,
		  ecole_militaire,
		  la_tour_maubourg,
		  invalides,
		  concorde,
		  madeleine,
		  opera,
		  richelieu_drouot,
		  grands_boulevards,
		  bonne_nouvelle,
		  strasbourg_saint_denis,
		  republique,
		  filles_du_calvaire,
		  saint_sebastien_froissart,
		  chemin_vert,
		  bastille,
		  ledru_rollin,
		  faidherbe_chaligny,
		  reuilly_diderot,
		  montgallet,
		  daumesnil,
		  michel_bizot,
		  porte_doree,
		  porte_de_charenton,
		  liberte,
		  charenton_ecoles,
		  ecole_veterinaire_de_maisons_alfort,
		  maisons_alfort_stade,
		  maisons_alfort_les_juilliottes,
		  creteil_echat,
		  creteil_universite,
		  creteil_prefecture,
		  pointe_du_lac], 
      balard, pointe_du_lac).

ligne(m9, metro, [pont_de_sevres,
		  billancourt,
		  marcel_sembat,
		  porte_de_saint_cloud,
		  exelmans,
		  michel_ange_molitor,
		  michel_ange_auteuil,
		  jasmin,
		  ranelagh,
		  la_muette,
		  rue_de_la_pompe,
		  trocadero,
		  iena,
		  alma_marceau,
		  franklin_d_roosevelt,
		  saint_philippe_du_roule,
		  miromesnil,
		  saint_augustin,
		  havre_caumartin,
		  chaussee_antin_la_fayette, 
		  richelieu_drouot,
		  grands_boulevards,
		  bonne_nouvelle,
		  strasbourg_saint_denis,
		  republique,
		  oberkampf,
		  saint_ambroise,
		  voltaire,
		  charonne,
		  rue_des_boulets,
		  nation,
		  buzenval,
		  maraichers,
		  porte_de_montreuil,
		  robespierre,
		  croix_de_chavaux,
		  mairie_de_montreuil], 
      pont_de_sevres, mairie_de_montreuil).

/*Par souci de simplification, on suppose que toutes les stations de la ligne 10 sont accessibles dans les deux directions.*/

ligne(m10, metro, [boulogne_pont_de_saint_cloud,
		   boulogne_jean_jaures,
		   porte_auteuil,
		   michel_ange_molitor,
		   michel_ange_auteuil,
		   chardon_lagache,
		   eglise_auteuil,
		   mirabeau,
		   javel_andre_citroen,
		   charles_michels,
		   avenue_emile_zola,
		   la_motte_picquet_grenelle,
		   segur,
		   duroc,
		   vaneau,
		   sevres_babylone,
		   mabillon,
		   odeon,
		   cluny_la_sorbonne,
		   maubert_mutualite,
		   cardinal_lemoine,
		   jussieu,
		   gare_austerlitz], 
     boulogne_pont_de_saint_cloud, gare_austerlitz).

ligne(m11, metro, [mairie_lilas,
                   porte_lilas, 
                   telegraphe,
                   place_fetes,
                   jourdain, 
                   pyrenees, 
                   belleville, 
                   goncourt, 
                   republique, 
                   arts_metiers,
                   rambuteau, 
                   hotel_de_ville, 
                   chatelet], 
      mairie_lilas, chatelet).

ligne(m12, metro, [porte_de_la_chapelle,
		   marx_dormoy,
		   marcadet_poissonniers,
		   jules_joffrin,
		   lamarck_caulaincourt,
		   abbesses,
		   pigalle,
		   saint_georges,
		   notre_dame_de_lorette,
		   trinite_estienne_orves,
		   saint_lazare, 
		   madeleine,
		   concorde,
		   assemblee_nationale,
		   solferino,
		   rue_du_bac,
		   sevres_babylone,
		   rennes,
		   notre_dame_des_champs,
		   montparnasse_bienvenue,
		   falguiere,
		   pasteur,
		   volontaires,
		   vaugirard,
		   convention,
		   porte_de_versailles,
		   corentin_celton,
		   mairie_issy], 
      porte_de_la_chapelle, mairie_issy).

ligne(m13, metro, [la_fourche,
		   place_de_clichy,
		   liege,
		   saint_lazare,
		   miromesnil,
		   champs_elysees_clemenceau,
		   invalides,
		   varenne,
		   saint_francois_xavier,
		   duroc,
		   montparnasse_bienvenue,
		   gaite,
		   pernety,
		   plaisance,
		   porte_de_vanves,
		   malakoff_plateau_de_vanves,
		   malakoff_rue_etienne_dolet,
		   chatillon_montrouge],
      la_fourche, chatillon_montrouge).

ligne(m13inter1, metro, [saint_denis_universite,
			 basilique_de_saint_denis,
			 saint_denis_porte_de_paris,
			 carrefour_pleyel,
			 mairie_de_saint_ouen,
			 garibaldi,
			 porte_de_saint_ouen,
			 guy_moquet,
			 la_fourche], 
      saint_denis_universite, la_fourche).

ligne(m13inter2, metro, [les_courtilles,
			 les_agnettes,
			 gabriel_peri,
			 mairie_de_clichy,
			 porte_de_clichy,
			 brochant,
			 la_fourche], 
      les_courtilles, la_fourche).

ligne(m14, metro, [saint_lazare,
		   madeleine,
		   pyramides,
		   chatelet,
		   gare_de_lyon,
		   bercy,
		   cour_saint_emilion,
		   bibliotheque_francois_mitterrand,
		   olympiades], 
      saint_lazare, olympiades).

/* Les lignes de rer */

ligne(rerA, rer,[nanterre_prefecture,
		 la_defense,
		 charles_de_gaulle_etoile,
		 auber,
		 chatelet,
		 les_halles,
		 gare_de_lyon,
		 nation,
		 vincennes], 
      nanterre_prefecture, vincennes).

ligne(rerB, rer,[aulnay_sous_bois,
		 le_blanc_mesnil,
		 drancy,
		 le_bourget,
		 la_courneuve_aubervilliers,
		 la_plaine_stade_de_france,
		 gare_du_nord,
		 chatelet,
		 les_halles,
		 saint_michel,
		 luxembourg,
		 port_royal,
		 denfert_rochereau,
		 cite_universitaire,
		 gentilly,
		 laplace,
		 arcueil_cachan,
		 bagneux,
		 bourg_la_reine], 
      aulnay_sous_bois, bourg_la_reine).

ligne(rerC1, rer,[porte_de_clichy,
		  pereire_levallois,
		  neuilly_porte_maillot,
		  avenue_foch,
		  avenue_henri_martin,
		  boulainvilliers,
		  avenue_du_president_kennedy,
		  champ_de_mars_tour_eiffel,
		  pont_de_alma,
		  invalides,
		  musee_orsay,
		  saint_michel,
		  gare_austerlitz,
		  bibliotheque_francois_mitterrand,
		  ivry_sur_seine,
		  vitry_sur_seine,
		  les_ardoines], 
      porte_de_clichy, les_ardoines).

ligne(rerC2, rer,[versailles_chateau,
		  viroflay_rive_gauche,
		  chaville_velizy,
		  meudon_val_fleury,
		  issy,
		  issy_val_de_seine,
		  pont_du_garigliano,
		  javel,
		  champ_de_mars_tour_eiffel,
		  pont_de_alma,
		  invalides,
		  musee_orsay,
		  saint_michel,
		  gare_austerlitz,
		  bibliotheque_francois_mitterrand,
		  ivry_sur_seine,
		  vitry_sur_seine,
		  les_ardoines], 
      versailles_chateau, les_ardoines).

ligne(rerD, rer,[saint_denis,
		 stade_de_france_saint_denis,
		 gare_du_nord,
		 chatelet,
		 les_halles,
		 gare_de_lyon,
		 maisons_alfort_alfortville,
		 le_vert_de_maisons,
		 villeneuve_prairie,
		 villeneuve_triage,
		 villeneuve_saint_georges], 
      saint_denis, villeneuve_saint_georges).

ligne(rerE, rer,[saint_lazare,
		 magenta,
		 gare_du_nord,
		 gare_de_est,
		 pantin,
		 noisy_le_sec], 
      saint_lazare, noisy_le_sec).


/* Les lignes de tramway */

ligne(t1, tramway,[saint_denis,
		   theatre_gerard_philipe,
		   marche_de_saint_denis,
		   basilique_de_saint_denis,
		   cimetiere_de_saint_denis,
		   hopital_delafontaine,
		   cosmonautes,
		   la_courneuve_six_routes,
		   hotel_de_ville_de_la_courneuve,
		   stade_geo_andre,
		   danton,
		   la_courneuve,
		   maurice_lachatre,
		   drancy_avenir,
		   hopital_avicenne,
		   gaston_roulaud,
		   escadrille_normandie_niemen,
		   la_ferme,
		   liberation,
		   hotel_de_ville_de_bobigny,
		   bobigny_pablo_picasso,
		   jean_rostand,
		   auguste_delaune,
		   pont_de_bondy,
		   petit_noisy,
		   noisy_le_sec], 
      saint_denis, noisy_le_sec).

ligne(t2, tramway,[la_defense,
		   puteaux,
		   belvedere,
		   suresnes_longchamp,
		   les_coteaux,
		   les_milons,
		   parc_de_saint_cloud,
		   musee_de_sevres,
		   brimborion,
		   meudon_sur_seine,
		   les_moulineaux,
		   jacques_henri_lartigue,
		   issy_val_de_seine,
		   henri_farman,
		   suzanne_lenglen,
		   porte_issy,
		   porte_de_versailles], 
      la_defense, porte_de_versailles).

ligne(t3, tramway,[pont_du_garigliano,
		   balard,
		   desnouettes,
		   porte_de_versailles,
		   georges_brassens,
		   brancion,
		   porte_de_vanves,
		   didot,
		   jean_moulin,
		   porte_orleans,
		   montsouris,
		   cite_universitaire,
		   stade_charlety,
		   poterne_des_peupliers,
		   porte_italie,
		   porte_de_choisy,
		   porte_ivry], 
      pont_du_garigliano, porte_ivry).

ligne(t4, tramway,[aulnay_sous_bois,
		   rougemont_chanteloup,
		   freinville_sevran,
		   abbaye,
		   lycee_henri_sellier,
		   gargan19,
		   les_pavillons_sous_bois,
		   allee_de_la_tour_rendez_vous,
		   les_coquetiers,
		   remise_a_jorelle, 
		   bondy], 
      aulnay_sous_bois, bondy).

