//Fonction pour créer un bouton
int[] bouton(String text,int posX,int posY,int buttonWidth,int buttonHeight){
    int position[] = new int[4];
    position[0]=posX;
    position[1]=posY;
    position[2]=buttonWidth;
    position[3]=buttonHeight;
    fill(150);
    stroke(255);
    textSize(14);
    rect(posX,posY,buttonWidth,buttonHeight);
    fill(255);
    text(text,820/2-25,(posY+buttonHeight)-buttonHeight/2);
    return position;
}

//fonction pour créer le bouton retour
int[] boutonRetour(int posX,int posY,int buttonWidth,int buttonHeight){
    int position[] =new int[4];
    position[0]=posX;
    position[1]=posY;
    position[2]=buttonWidth;
    position[3]=buttonHeight;
    image(imageBoutonRetour,posX,posY,buttonWidth,buttonHeight);
    return position;
}

//Savoir si la souris est par-dessus un bouton
boolean overButton(int position[]){
    if(mouseX>=position[0]&&mouseX<=position[0]+position[2]&&mouseY>=position[1]&&mouseY<=position[1]+position[3]){
        return true;
    } else{
        return false;
    }
}

int[] boutonImage(PImage imageDuBouton,int posX,int posY,int buttonWidth,int buttonHeight){
    int position[] = new int[4];
    position[0]=posX;
    position[1]=posY;
    position[2]=buttonWidth;
    position[3]=buttonHeight;
    image(imageDuBouton,posX,posY,buttonWidth,buttonHeight);
    return position;
}

void illumination(int posX,int posY,int buttonWidth,int buttonHeight){
    fill(200,200,200,90);
    stroke(200,200,200,90);
    rect(posX,posY,buttonWidth,buttonHeight);
}

void illumination_case(int position_case,int couleur[]){
    fill(couleur[0],couleur[1],couleur[2],couleur[3]);
    stroke(couleur[0],couleur[1],couleur[2],couleur[3]);
    rect((position_case%largeur)*largeur_carree,int(position_case/hauteur)*largeur_carree,largeur_carree,largeur_carree);
}

boolean fantome_in_case(int la_case){
    //Verifie si il n'y a pas un fantome dans la case
    boolean verification = false;
    for(int i=0;i<position_fantome.length;i++){
        if(position_fantome[i]==la_case){
            verification=true;
        }
    }
    return verification;
}

boolean case_libre(int la_case){
    //Verifie si il n'y a pas un fantome ou un mur dans la case
    boolean verification = false;
    if(fantome_in_case(la_case)==false&&map[la_case]==1){
        verification=true;
    }
    return verification;
}

boolean vague_dans_la_case(int la_case,int vague[][]){
    //regarde si il y a une vague dans la case
    boolean verification= false;
    int j=0;
    while(vague[0][j]!=0){
        if(la_case==vague[0][j]){
            verification=true;
            break;
        }
        j++;
    }
    return verification;
}

int recup_num_vague_avec_position(int la_case, int vague[][]){
    //recupere dans la liste vague le numero de la vague via sa position
    int i=0;
    int num_vague=100;
    boolean trouver=false;
    while(trouver==false){
        if(vague[0][i]==la_case){
            trouver=true;
            num_vague=vague[1][i];
            break;
        }
        if(i==vague[0].length-1){
          break;
        }
        i++;
    }
    return num_vague;
}

int vague_plus_petite(int la_case,int vague[][]){
    int position=0;
    if(vague_dans_la_case(la_case+1,vague)==true&&recup_num_vague_avec_position(la_case+1,vague)==recup_num_vague_avec_position(la_case,vague)-1){
        position = la_case+1;
    } else if(vague_dans_la_case(la_case-1,vague)==true&&recup_num_vague_avec_position(la_case-1,vague)==recup_num_vague_avec_position(la_case,vague)-1){
        position = la_case-1;
    } else if(vague_dans_la_case(la_case+hauteur,vague)==true&&recup_num_vague_avec_position(la_case+hauteur,vague)==recup_num_vague_avec_position(la_case,vague)-1){
        position = la_case+hauteur;
    } else if(vague_dans_la_case(la_case-hauteur,vague)==true&&recup_num_vague_avec_position(la_case-hauteur,vague)==recup_num_vague_avec_position(la_case,vague)-1){
        position = la_case-hauteur;
    } else {

    }
    return position;
}

int[][] replication(int vague[][],int numeroAAttribuer,int laCaseARepliquer,int compteur){
    /* Creer des vagues autour des 4 direction de la case si possible les inscrits 
    dans vague puis les renvoie avec les modifications du compteur */
    int la_case = laCaseARepliquer;
    int num_vague = numeroAAttribuer;

    if(vague_dans_la_case(la_case+1,vague)==false&&map[la_case+1]==1){
        compteur++;
        vague[0][compteur]=la_case+1;
        vague[1][compteur]=num_vague;
        vague[2][compteur]=0;
    }
    if(vague_dans_la_case(la_case-1,vague)==false&&map[la_case-1]==1){
        compteur++;
        vague[0][compteur]=la_case-1;
        vague[1][compteur]=num_vague;
        vague[2][compteur]=0;
    }
    if(vague_dans_la_case(la_case+hauteur,vague)==false&&map[la_case+hauteur]==1){
        compteur++;
        vague[0][compteur]=la_case+hauteur;
        vague[1][compteur]=num_vague;
        vague[2][compteur]=0;
    }
    if(vague_dans_la_case(la_case-hauteur,vague)==false&&map[la_case-hauteur]==1){
        compteur++;
        vague[0][compteur]=la_case-hauteur;
        vague[1][compteur]=num_vague;
        vague[2][compteur]=0;
    }
    int resultat[][] = new int[4][vague[0].length];
    for(int i=0;i<vague[0].length;i++){
        resultat[0][i]=vague[0][i];
        resultat[1][i]=vague[1][i];
        resultat[2][i]=vague[2][i];
    }
    resultat[3][0]=compteur;
    return resultat;
}

void affichage_liste(int liste[]){
    for(int i=0;i<liste.length;i++){
        println(liste[i]);
    }
}

void affichage_position_fantome(int position_fantome[], int identite_fantome[]){
    for(int i=0;i<identite_fantome.length;i++){
        println("identite : "+identite_fantome[i]+", position : "+position_fantome[i]);
    }
}

int compte_case_vide(){
    int compteur = 0;
    for(int i=0;i<map.length;i++){
        if(map[i]==1){
            compteur++;
        }
    }
    return compteur;
}