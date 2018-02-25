void test(int map[],int largeur_carree,int hauteur,int largeur){

     /*
     Creer un damier pour visualiser la map
     Modulo pour gérer le X de la largeur comme ca X ne dépasse jamais largeur
     Diviser pour faire les "couches" et comme int arrondie les float à l'inferieur.
     Multiplier par largeur_carree pour bien faire les espacements entre chaque carree
    */

    for(int i=0;i<map.length;i++){
     if(map[i]==0){
         stroke(255);
         fill(0,0,0);
         rect((i%largeur)*largeur_carree,int(i/hauteur)*largeur_carree,largeur_carree,largeur_carree);
     }else if(map[i]==2){
         stroke(255,255,0);
         fill(255,255,0);
         rect((i%largeur)*largeur_carree,int(i/hauteur)*largeur_carree,largeur_carree,largeur_carree);
     }else if(map[i]==9){
         stroke(255,0,0);
         fill(255,0,0);
         rect((i%largeur)*largeur_carree,int(i/hauteur)*largeur_carree,largeur_carree,largeur_carree); 
     }else if(map[i]==8){
         stroke(75,75,75);
         fill(75,75,75);
         rect((i%largeur)*largeur_carree,int(i/hauteur)*largeur_carree,largeur_carree,largeur_carree);
     }else if(map[i]==7){
         stroke(0,255,255);
         fill(0,255,255);
         rect((i%largeur)*largeur_carree,int(i/hauteur)*largeur_carree,largeur_carree,largeur_carree); 
     }else if(map[i] >= 10 && map[i]<=200){
         stroke(255);
         fill(255);
         rect((i%largeur)*largeur_carree,int(i/hauteur)*largeur_carree,largeur_carree,largeur_carree);
         fill(0);
         stroke(0);
         textSize(10);
         text(str(map[i]),(i%largeur)*largeur_carree+2,int(i/hauteur)*largeur_carree+largeur_carree);
     }else if(map[i]==6){
        stroke(255,165,0);
        fill(255,165,0);
        rect((i%largeur)*largeur_carree,int(i/hauteur)*largeur_carree,largeur_carree,largeur_carree);
     }else{
         stroke(255);
         fill(255,255,255);
         rect((i%largeur)*largeur_carree,int(i/hauteur)*largeur_carree,largeur_carree,largeur_carree); 
     }
    }
    //Affichage des fantomes
    for(int i=0;i<identite_fantome.length;i++){
         /*fill(0);
         stroke(0);
         textSize(10);
         text(str(identite_fantome[i]),(position_fantome[i]%largeur)*largeur_carree+2,int(position_fantome[i]/hauteur)*largeur_carree+largeur_carree);
         */
         image(image_fantome[i%4],position_fantome[i]%largeur*largeur_carree,int(position_fantome[i]/hauteur)*largeur_carree,largeur_carree,largeur_carree);  
     }
    //Affichage de pacman
    /*stroke(0);
    fill(0);
    textSize(10);
    text(str(identite_pacman),(position_pacman%largeur)*largeur_carree+2,int(position_pacman/hauteur)*largeur_carree+largeur_carree);
    */
    image(pacman_image[pacman_direction],position_pacman%largeur*largeur_carree,int(position_pacman/hauteur)*largeur_carree,largeur_carree,largeur_carree);
    
    //Affichage des petits points
    for(int i=0;i<position_petit_point.length;i++){
        stroke(0,255,255);
        fill(0,255,255);
        ellipse(position_petit_point[i]%largeur*largeur_carree+5,int(position_petit_point[i]/hauteur)*largeur_carree+5,5,5);
    }

    //Affichage des bombes
    for(int i=0;i<position_bombe.length;i++){
        stroke(25,25,25);
        fill(25,25,25);
        ellipse(position_bombe[i]%largeur*largeur_carree+5,int(position_bombe[i]/hauteur)*largeur_carree+5,5,5);
    }

    //Affichage des cerises
    for(int i=0;i<position_cerise.length;i++){
        stroke(255,0,0);
        fill(255,0,0);
        ellipse(position_cerise[i]%largeur*largeur_carree+5,int(position_cerise[i]/hauteur)*largeur_carree+5,5,5);
    }

    //Affichage des superPacman
    for(int i=0;i<nb_superPacman;i++){
        stroke(255,0,255);
        fill(255,0,255);
        ellipse(position_superPacman[i]%largeur*largeur_carree+5,int(position_superPacman[i]/hauteur)*largeur_carree+5,5,5);
    }
	
	//Cache les bonus situés dans la case 0
	stroke(255);
    fill(0);
    rect(0,0,largeur_carree,largeur_carree); 
}

void save_map(int map[]){
 
 /* Sauvegarde la map dans un fichier qui pourra être lu par un
 autre programme */
 
 String[] text = new String[map.length];
 
 for(int i=0;i<map.length;i++){
 text[i] = str(map[i]);
 }
 saveStrings("map",text);
}
