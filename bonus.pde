int [] spawn_bombe(){

    int [] position_bombe = new int[max_bombe];
    int position = int(random(0,hauteur*largeur));
    for(int i=0;i<max_bombe;i++){
        do {
            position = int(random(0,hauteur*largeur));
        } while(case_libre(position)==false);
        position_bombe[i]=position;
    }

    return position_bombe;
}
  
void bombe(int position_bombe){
    //Marche pas pour la zone d'explosion n'est pas à l'endroit de la bombe
    
    //Recherche les fantomes sur la droite(+), s'arrete au premier mur
    int compteur = 0;
    while(map[position_bombe+compteur]!=0){
        //Fonction de fantome.pde
        int couleur [] = {255,0,0,100};
        illumination_case(position_bombe+compteur,couleur);
        if(fantome_in_case(position_bombe+compteur)==true){
            for(int i=0;i<position_fantome.length;i++){
                if(position_fantome[i]==position_bombe+compteur){
                    position_fantome[i]=centre;
                }
            }
        }
        compteur++;
    }
    //Recherche les fantomes sur la gauche(-), s'arrete au premier mur
    compteur=0;
    while(map[position_bombe-compteur]!=0){
        //Fonction de fantome.pde
        int couleur [] = {255,0,0,100};
        illumination_case(position_bombe-compteur,couleur);
        if(fantome_in_case(position_bombe-compteur)==true){
            for(int i=0;i<position_fantome.length;i++){
                if(position_fantome[i]==position_bombe-compteur){
                    position_fantome[i]=centre;
                }
            }
        }
        compteur++;
    }
    //Recherche les fantomes en haut(-*hauteur), s'arrete au premier mur
    compteur=0;
    while(map[position_bombe-compteur*hauteur]!=0){
        //Fonction de fantome.pde
        int couleur [] = {255,0,0,100};
        illumination_case(position_bombe-compteur*hauteur,couleur);
        if(fantome_in_case(position_bombe-compteur*hauteur)==true){
            for(int i=0;i<position_fantome.length;i++){
                if(position_fantome[i]==position_bombe-compteur*hauteur){
                    position_fantome[i]=centre;
                }
            }
        }
        compteur++;
    }
    //Recherche les fantomes en bas(+*hauteur), s'arrete au premier mur
    compteur=0;
    while(map[position_bombe+compteur*hauteur]!=0){
        //Fonction de fantome.pde
        int couleur [] = {255,0,0,100};
        illumination_case(position_bombe+compteur*hauteur,couleur);
        if(fantome_in_case(position_bombe+compteur*hauteur)==true){
            for(int i=0;i<position_fantome.length;i++){
                if(position_fantome[i]==position_bombe+compteur*hauteur){
                    position_fantome[i]=centre;
                }
            }
        }
        compteur++;
    }

    //Fait une petite explosion autour de la bombe en carré(5*5) de -2 +2 de la position de la bombe
    int case_x;
    int case_y;
    int couleur [] = {255,0,0,100};
    for(int i=0;i<5*5;i++){
        case_y = int(-2+int((i/5)));
        case_x = (-2+(i%5));
        illumination_case(position_bombe+case_x+case_y*hauteur,couleur);

        if(fantome_in_case(position_bombe+case_x+case_y*hauteur)==true){
            for(int j=0;j<position_fantome.length;j++){
                if(position_fantome[j]==position_bombe+case_x+case_y*hauteur){
                    position_fantome[j]=centre;
                }
            }
        }
    }

}
    
int[] spawn_petit_point(){
    int compteur = 0;
    //Compte le nombre de case libre ou on mettra les points
    for(int i=0;i<map.length;i++){
        if(map[i]==1||map[i]==7){
            compteur++;
        }
    }
    int position_point[] = new int[compteur];
    compteur=0;
    //Enregistre les petis points dans la liste à la suite i étant la position du point
    //Dans le cas ou la position est une case vide
    for(int i=0;i<map.length;i++){
        if(map[i]==1||map[i]==7){
            position_point[compteur] = i;
            compteur++;
        }
    }
    return position_point;
}

int[] spawn_cerise(){
    //peut buguer et spawn dans les murs
    int position_cerise[] = new int[nb_cerise];
    int position = int(random(0,hauteur*largeur));
    for(int i=0;i<nb_cerise;i++){
         do{
             position = int(random(0,hauteur*largeur));
         } while(case_libre(position)==false);
         position_cerise[i]=position;
    }
  return position_cerise;
}

int [] spawn_superPacman(){
    int position_superPacman[] = new int[nb_superPacman];
    for(int i=0;i<nb_superPacman;i++){
        int position = int(random(0,hauteur*largeur));
        do{
            position = int(random(0,hauteur*largeur));
        }while(case_libre(position)!=true);
        position_superPacman[i]=position;
    }
    return position_superPacman;
}

int [] superPacman(){
    int pacman_is_super [] = {1,pacman_is_superPacman_for_turn};
    return pacman_is_super;
}
