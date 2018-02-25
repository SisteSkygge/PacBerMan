//choisi quelle affichage mettre
void affichage(){
    switch(onglet){
        case 0:
            onglet = menu();
            break;
        case 1:
            onglet = score();
            break;
        case 2:
            onglet = option();
            break;
        case 3:
            onglet = credit();
            break;
        case 4:
            onglet = jouer();
            break;
        case 5:
            onglet=gameOver();
            break;
    }
}

//Affiche l'onglet du menu clasique
int menu(){
    int onglet=0;
    background(0);
    int boutonJouer[] = bouton("Jouer",820/2-320/2,50,320,100);
    int boutonScore[] = bouton("Scores",820/2-320/2,180,320,100);
    int boutonOption[] = bouton("Options",820/2-320/2,310,320,100);
    int boutonCredit[] = bouton("Credits",820/2-320/2,440,320,100);
    if(mousePressed){
        if((mouseButton==LEFT)&&(overButton(boutonJouer)==true)){
            onglet = 4;
        }
        if((mouseButton==LEFT)&&(overButton(boutonScore)==true)){
            onglet = 1;
        }
        if((mouseButton==LEFT)&&(overButton(boutonOption)==true)){
            onglet = 2;
        }
        if((mouseButton==LEFT)&&(overButton(boutonCredit)==true)){
            onglet = 3;
        }
    }
    if(overButton(boutonJouer)==true){
        illumination(boutonJouer[0],boutonJouer[1],boutonJouer[2],boutonJouer[3]);
    }
    if(overButton(boutonScore)==true){
        illumination(boutonScore[0],boutonScore[1],boutonScore[2],boutonScore[3]);
    }
    if(overButton(boutonOption)==true){
        illumination(boutonOption[0],boutonOption[1],boutonOption[2],boutonOption[3]);
    }
    if(overButton(boutonCredit)==true){
        illumination(boutonCredit[0],boutonCredit[1],boutonCredit[2],boutonCredit[3]);
    }
    return onglet;
}

//Affiche les scores
int score(){
    int onglet=1;
    background(0);
    int retour[] = boutonRetour(25,25,50,50);
    int y_option_reference = 20;
    int x_option_reference = 140;
    int i=0;
    JSONObject player;
    while(true){
        try{
            player = json.getJSONObject(str(i));
            textSize(14);
            fill(255);
            text(player.getString("name")+" : "+str(player.getInt("score")),
                x_option_reference*int((i+28)/28),y_option_reference+(((i%28)+1)*20));
        } catch (Exception e) {
            break;
        }
        i++;
    }
    
    if(mousePressed){
        if(mouseButton==LEFT&&overButton(retour)){
            onglet=0;
        }
    }
    return onglet;
}

//Affiche les options
int option(){
    score = 0;
    score_du_niveau=0;
    generation=false;
    int onglet=2;
    background(0);
    int retour[] = boutonRetour(25,25,50,50);
    //Reglage des vies
    stroke(255);
    fill(255);
    textSize(12);
    text("Nombre de vies :",125,50);
    int boutonPlusVie[] = boutonImage(imageBoutonPlus,255,25,50,50);
    text(str(vie),310,50);
    int boutonMoinsVie[] = boutonImage(imageBoutonMoins,330,25,50,50);
    //Reglage des fantomes
    text("Nombre de fantomes :",125,150);
    int boutonPlusFantome[] = boutonImage(imageBoutonPlus,260,125,50,50);
    text(str(nombre_fantome),320,150);
    int boutonMoinsFantome[] = boutonImage(imageBoutonMoins,335,125,50,50);
    //Reglage du nombre de bombes
    text("Nombre de bombes :",125,250);
    int boutonPlusBombe[] = boutonImage(imageBoutonPlus,255,225,50,50);
    text(str(max_bombe),315,250);
    int boutonMoinsBombe[] = boutonImage(imageBoutonMoins,330,225,50,50);
    //Reglage du nombre de cerises
    text("Nombres de cerises :",125,350);
    int boutonPlusCerise[] = boutonImage(imageBoutonPlus,255,325,50,50);
    text(str(nb_cerise),315,350);
    int boutonMoinsCerise[] = boutonImage(imageBoutonMoins,330,325,50,50);
    //Reglage du nombre de superPacman
    text("Nombre de superPacman :",125,450);
    int boutonPlusSuperPacman[] = boutonImage(imageBoutonPlus,275,425,50,50);
    text(str(nb_superPacman),335,450);
    int boutonMoinsSuperPacman[] = boutonImage(imageBoutonMoins,350,425,50,50);

    if(mousePressed){
        //Controle bouton retour
        if(mouseButton==LEFT&&overButton(retour)){
			//Corrige si l'utilisateur selectionne des valeurs interdites
			if(nombre_fantome>12){
				nombre_fantome = 12;
			}
			if(vie<0){
				vie = 0;
			}
			if(nombre_fantome<0){
				nombre_fantome = 0;
			}
			if(max_bombe<0){
				max_bombe = 0;
			}
			if(nb_cerise<0){
				nb_cerise = 0;
			}
			if(nb_superPacman<0){
				nb_superPacman = 0;
			}
            onglet=0;
        }
        //Controle bouton des vies
        if(mouseButton==LEFT&&overButton(boutonPlusVie)){
            vie++;
            delay(250);
        }
        if(mouseButton==LEFT&&overButton(boutonMoinsVie)){
            vie--;
            delay(250);
        }
        //Controle bouton du nombre des fantomes
        if(mouseButton==LEFT&&overButton(boutonPlusFantome)){
            nombre_fantome++;
            delay(250);
        }
        if(mouseButton==LEFT&&overButton(boutonMoinsFantome)){
            nombre_fantome--;
            delay(250);
        }
        //Controle bouton du nombre de bombes
        if(mouseButton==LEFT&&overButton(boutonMoinsBombe)){
            max_bombe--;
            delay(250);
        }
        if(mouseButton==LEFT&&overButton(boutonPlusBombe)){
            max_bombe++;
            delay(250);
        }
        //Controle bouton du nombre de cerises
        if(mouseButton==LEFT&&overButton(boutonMoinsCerise)){
            nb_cerise--;
            delay(250);
        }
        if(mouseButton==LEFT&&overButton(boutonPlusCerise)){
            nb_cerise++;
            delay(250);
        }
        if(mouseButton==LEFT&&overButton(boutonMoinsSuperPacman)){
            nb_superPacman--;
            delay(250);
        }
        if(mouseButton==LEFT&&overButton(boutonPlusSuperPacman)){
            nb_superPacman++;
            delay(250);
        }

    }
    return onglet;
}

//Affiche les credits
int credit(){
    int onglet=3;
    background(0);
    int retour[] = boutonRetour(25,25,50,50);
    fill(255);
    stroke(255);
    textSize(14);
    text("Créateur : GILLES Marco et Chloé Dupont",125,310);
    if(mousePressed){
        if(mouseButton==LEFT&&overButton(retour)){
            onglet=0;
        }
    }
    return onglet;
}

int jouer(){
    int onglet=4;
    if(generation==false){
        identite_fantome = new int[nombre_fantome];
        position_fantome = new int[nombre_fantome];
        fatigue_fantome = new int[nombre_fantome];
        position_bombe = new int[max_bombe];
        position_cerise = new int[nb_cerise];
        position_superPacman = new int[nb_superPacman];
        map=creer_terrain();
        case_vide = compte_case_vide();
        spawn_fantome();
        position_bombe = spawn_bombe();
        position_petit_point = spawn_petit_point();
        position_cerise = spawn_cerise();
        position_superPacman = spawn_superPacman();
        pacman_spawn();
        generation=true;
    }

    if(keyPressed){
        if(key=='z'){
            pacman_direction = controle_haut();
        }
        if(key=='s'){
            pacman_direction = controle_bas();
        }
        if(key=='q'){
            pacman_direction = controle_gauche();
        }
        if(key=='d'){
            pacman_direction = controle_droite();
        }
        if(key=='&'){
            onglet=0;
        }
    }

    if(image>=15){
        background(0);

        //Modelise la map
        test(map,largeur_carree,hauteur,largeur);

        //Verifie les positions des bombes et de pacman
        for(int i=0;i<position_bombe.length;i++){
            if(position_pacman==position_bombe[i]){
                bombe(position_bombe[i]);
                position_bombe[i]=0;
            }
        }

        //Verifie les positions des cerises et de pacman
        for(int i=0;i<position_cerise.length;i++){
            if(position_pacman==position_cerise[i]){
                score += 40;
                score_du_niveau += 40;
                position_cerise[i]=0;
            }
        }

       //Verifie la position des petits points et attribue 1 points
       for(int j=0;j<position_petit_point.length;j++){
            if(position_pacman==position_petit_point[j]){
                score +=1;
                score_du_niveau += 1;
                position_petit_point[j]=0;
            }
        }
        
        //Verifie si pacman est à bout de son bonus superPacman
        if(pacman_is_superPacman[1]==0){
            pacman_is_superPacman[0]=0;
        }
        //Verifie si pacman est sous superPacman et lui enleve un tour de bonus
        if(pacman_is_superPacman[0]==1){
            pacman_is_superPacman[1]-=1;    
        }
        //Verifie la position des superPacman et de pacman
        for(int i=0;i<nb_superPacman;i++){
            if(position_pacman==position_superPacman[i]){
                pacman_is_superPacman = superPacman();
                position_superPacman[i]=0;
            }
        }
        
        //Gerer les fantomes
        for(int k=0;k<identite_fantome.length;k++){
            position_fantome[k]=comportement_fantome(k);
        }

        //Gerer le deplacement de pacman
        position_pacman = deplacement_pacman(pacman_direction);

        //Savoir si les fantomes ont capture pacman
        for(int i=0;i<position_fantome.length;i++){
            if(position_fantome[i]==position_pacman&&pacman_is_superPacman[0]==0){
                vie -=1;
                position_pacman = centre+3*hauteur;
            } else if(position_fantome[i]==position_pacman&&pacman_is_superPacman[0]==1){
                score+=10;
                score_du_niveau += 10;
                position_fantome[i]=centre;
            } else {

            }
        }

        //Quand on pase au niveau suivant
        if(score_du_niveau>=case_vide/2){
            score_du_niveau = 0;
            niveau++;
            generation=false;
        }

        //Affiche le nombre de vie restante et le score
        //Barre d'info : X[620-820] Y[0-620]
        fill(255);
        stroke(255);
        textSize(12);
        text("Nombre de vie :",630,50);
        text(str(vie),630,70);
        text("Votre score :",630,90);
        text(str(score),630,110);
        text("Tour restant du superPacman :",630,130);
        text(str(pacman_is_superPacman[1]),630,150);
        text("Score du niveau requis :",630,170);
        text(str(case_vide/2),630,190);
        text("Score du niveau :",630,210);
        text(str(score_du_niveau),630,230);

        //GAME OVER
        if(vie<0){
            onglet = 5;
        }

        //Remet l'image à 0 pour reset le cycle
        image=0;
    } else {
        image +=1;
    }
    return onglet;
}

int gameOver(){
    onglet = 5;
    background(0);
    fill(255);
    stroke(255);
    textSize(20);
    text("GAME OVER",820/2-60,620/2-160);
    text("Vous êtes arrivés au niveau :",820/2-125,620/2-130);
    text(str(niveau),820/2-5,620/2-100);
    text("Avec un score de :",820/2-65,620/2-70);
    text(str(score),820/2-5,620/2-40);
    text("Entrez votre nom puis appuiyez sur entrée :",820/2-200,620/2-10);
    textSize(40);
    text(nom,820/2-100,620/2+50);
    //reset des variables
    vie = 3;
    nombre_fantome = 4;
    score_du_niveau=0;
    niveau = 1;
    generation=false;
    if(keyPressed){
        if(key==ENTER){
	  if(nom.length()>5){
	    nom = str(nom.charAt(0))+str(nom.charAt(1))+str(nom.charAt(2))+str(nom.charAt(3))+str(nom.charAt(4));
	  }
            enregistrer_score(json, nom,score);
            nom = "";
            score = 0;
            onglet=0;
        }
        if(key==BACKSPACE){
            nom ="";
            delay(100);
        }
        if(key=='a'){
            nom += "a";
            delay(100);
        }
        if(key=='b'){
            nom += "b";
            delay(100);
        }
        if(key=='c'){
            nom += "c";
            delay(100);
        }
        if(key=='d'){
            nom += "d";
            delay(100);
        }
        if(key=='e'){
            nom += "e";
            delay(100);
        }
        if(key=='f'){
            nom += "f";
            delay(100);
        }
        if(key=='g'){
            nom += "g";
            delay(100);
        }
        if(key=='h'){
            nom += "h";
            delay(100);
        }
        if(key=='i'){
            nom += "i";
            delay(100);
        }
        if(key=='j'){
            nom += "j";
            delay(100);
        }
        if(key=='k'){
            nom += "k";
            delay(100);
        }
        if(key=='l'){
            nom += "l";
            delay(100);
        }
        if(key=='m'){
            nom += "m";
            delay(100);
        }
        if(key=='n'){
            nom += "n";
            delay(100);
        }
        if(key=='o'){
            nom += "o";
            delay(100);
        }
        if(key=='p'){
            nom += "p";
            delay(100);
        }
        if(key=='q'){
            nom += "q";
            delay(100);
        }
        if(key=='r'){
            nom += "r";
            delay(100);
        }
        if(key=='s'){
            nom += "s";
            delay(100);
        }
        if(key=='t'){
            nom += "t";
            delay(100);
        }
        if(key=='u'){
            nom += "u";
            delay(100);
        }
        if(key=='v'){
            nom += "v";
            delay(100);
        }
        if(key=='w'){
            nom += "w";
            delay(100);
        }
        if(key=='x'){
            nom += "x";
            delay(100);
        }
        if(key=='y'){
            nom += "y";
            delay(100);
        }
        if(key=='z'){
            nom += "z";
            delay(100);
        }
    }
    return onglet;
}
