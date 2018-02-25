void spawn_fantome(){
    /* Defini l'identite d'un fantome et sa position; 
    le fantome idendite_fantome[0] aura sa position en position_fantome[0] */
    for(int i=0;i<nombre_fantome;i++){
        identite_fantome[i]=201+i;
        position_fantome[i]=centre-(3-(i*2%8))+(-hauteur+int(i/4)*hauteur);
        //Defini la distance sur laquelle les fantomes poursuivent pac-man
        //La fatigue se recharge a chaque fois qu'il se deplace d'une case jusqu'au maximum defini
        fatigue_fantome[i]=max_fatigue; 
    }
}

int get_out(int emplacement){
    /*Fait sortir les fantomes de leur enclos */

    int deplacement_fantome=position_fantome[emplacement];
    if(position_fantome[emplacement]%largeur==(centre+1)%largeur || position_fantome[emplacement]%largeur==(centre-1)%largeur){
        deplacement_fantome=position_fantome[emplacement]-hauteur;
    } else if(position_fantome[emplacement]%largeur<(centre-1)%largeur) {
        deplacement_fantome=position_fantome[emplacement]+1;
    } else if(position_fantome[emplacement]%largeur>(centre+1)%largeur) {
        deplacement_fantome=position_fantome[emplacement]-1;
    } else if(position_fantome[emplacement]==centre||//Fantome qui s'est fait detruire
    position_fantome[emplacement]==centre-hauteur||
    position_fantome[emplacement]==centre-2*hauteur){
        deplacement_fantome=position_fantome[emplacement]-hauteur;
    } else {
        deplacement_fantome=0;
    }
    
    return deplacement_fantome;
}

int choose_a_case(int emplacement){
    /*Fait choisir au fantome une case et regarde si la case n'est pas un mur(0) ou son enclos(2)
    car une fois sorti de leur enclos les fantomes ne sont pas censes y retourner 
    a part si ils se font tuer */

    //Direction => 0:gauche ; 1:droite ; 2:bas ; 3:haut
    int direction_fantome;
    int deplacement_fantome=position_fantome[emplacement];
    boolean direction_valide = false;

    //Condition permettant d'eviter la boucle infini si les fantomes n'ont aucune case de libre
    //Cas rare&particulier mais pouvant se produire avec un fantome entouré d'autre fantome et d'un mur

    if(case_libre(position_fantome[emplacement]+1)==false&&case_libre(position_fantome[emplacement]-1)==false&&
    case_libre(position_fantome[emplacement]-hauteur)==false&&case_libre(position_fantome[emplacement]+hauteur)==false){
        deplacement_fantome=position_fantome[emplacement];
    } else {
        while(direction_valide==false){
            
            direction_fantome = int(random(0,3.99));
            

            //Verifie si il n'y a pas un fantome sur la case
            //Pour empecher le chevauchement.
            if(direction_fantome==0&&case_libre(position_fantome[emplacement]-1)==false){
                direction_valide=false;
            } else if(direction_fantome==1&&case_libre(position_fantome[emplacement]+1)==false){
                direction_valide=false;
            }else if(direction_fantome==2&&case_libre(position_fantome[emplacement]+hauteur)==false){
                direction_valide=false;
            }else if(direction_fantome==3&&case_libre(position_fantome[emplacement]-hauteur)==false){
                direction_valide=false;
            }else{
                direction_valide=true;
                if(direction_fantome==0){
                    deplacement_fantome=position_fantome[emplacement]-1;
                } else if(direction_fantome==1){
                    deplacement_fantome=position_fantome[emplacement]+1;
                } else if(direction_fantome==2){
                    deplacement_fantome=position_fantome[emplacement]+hauteur;
                } else{
                    deplacement_fantome=position_fantome[emplacement]-hauteur;
                }
            }
        }
    }
    //regenere la fatigue du fantome
    if(fatigue_fantome[emplacement]<max_fatigue){
        fatigue_fantome[emplacement]+=1;
    }
    return deplacement_fantome;
}

int chase(int emplacement){
    int direction_fantome=position_fantome[emplacement];
    //fais des vagues numerote pour trouver pacman
    //Quand une des vagues se situent a cote de pac man on arrete d'en faire
    //Et on remonte la numerotation du plus petit a cote de pacman jusqua 0 donc le fantome
    //De cette facon on obtient le chemin le plus court du fantome a pacman
    boolean pacman_trouve = false;
    /* vague contient 3 sous-liste
    vague[0] sert à stocker la position des vagues
    vague[1] sert à stocker le numéro de la vague dans laquelle celle ci a été crée
    vague[2] sert à connaitre si la vague a déjà été répliqué*/
    int vague[][]=new int[3][hauteur*largeur]; //Par defaut avec processing vague est remplie de 0
    //On regle les replications à 1 par défaut pour éviter les erreurs
    //Car replication() les set sur 0 lors de la creation d'une vague
    for(int i=0;i<vague[2].length;i++){
        vague[2][i]=1;
    }
    //Set du point originel défini comme étant le fantome
    vague[0][0] = position_fantome[emplacement];
    vague[1][0] = 0;
    vague[2][0] = 0;
    int num_vague=1; //1 car 0 est déjà pris par le point originel     
    int compteur=0;
    while(pacman_trouve==false){
        boolean next_num = false;
        int i=0;
        while(next_num==false){
            if(vague[1][i]==num_vague-1&&vague[2][i]==0){
                vague[2][i]=1;
                int resultat[][] = replication(vague,num_vague,vague[0][i],compteur);
                vague[0]=resultat[0];
                vague[1]=resultat[1];
                vague[2]=resultat[2];
                compteur = resultat[3][0];
            }
            if(vague[1][i]==num_vague){
                next_num = true;
            }
            i++;
        }
        int j=0;
        while(vague[0][j]!=0){
            //Verifie si une vague ne se trouve pas sur pacman
            //Si il y en a une alors on arrête la boucle.
            if(vague[0][j]==position_pacman){
                pacman_trouve=true;
            }
            j++;
        }
        num_vague++;   
    }
    //Retrace les vagues de pacman jusqu'au fantome pour obtenir
    //Le chemin à suivre de pacman vers le fantome
    //On prendra à la fin le dernier chemin comme la case la ou devra
    //se déplcer le fantome.
    int [] chemin = new int[hauteur*largeur];
    chemin[0]=position_pacman;
    compteur = 1;
    boolean fantome_trouve=false;
    //TODO à réécrire pour le ré-adapter à la réecriture de la premiere partie de chase
    while(fantome_trouve==false){
        chemin[compteur]=vague_plus_petite(chemin[compteur-1],vague);
        if(recup_num_vague_avec_position(chemin[compteur],vague)==0){
            fantome_trouve=true;
            direction_fantome=chemin[compteur-1];
        }
        compteur++;
    }

    if(case_libre(direction_fantome)==false){
        direction_fantome=position_fantome[emplacement];
    }
    //Gere la fatigue du fantome
    if(fatigue_fantome[emplacement]==0){
        direction_fantome=choose_a_case(emplacement);
    } else{
        fatigue_fantome[emplacement]-=1;
    }
    return direction_fantome;
}

int comportement_fantome(int emplacement){
    /*Fait bouger le fantome en fonction de :
        -Soit il est dans son enclos il doit donc en sortir(get_out)
        -Se deplacer aleatoirement car pac-man n'est pas en visuel(choose_a_case)
        -Se deplacer vers pac-man car il est en visuel et qu'il n'est pas fatigue(chase)
    La fatigue sert a ce qu'il ne poursuit pas le joueur jusqu'a sa mort cela rendrait le jeu impossible
    ou au contraire trop facile
    */
    int deplacement_fantome=position_fantome[emplacement];

    //si les fantomes sont dans leurs enclos
    if(position_fantome[emplacement]%largeur>(centre-4)%largeur&&int(position_fantome[emplacement]/hauteur)>int((centre-2*hauteur)/hauteur)
    &&position_fantome[emplacement]%largeur<(centre+4)%largeur&&int(position_fantome[emplacement]/hauteur)<int((centre+2*hauteur)/hauteur)){
        deplacement_fantome = get_out(emplacement);
    }
    //si pacman est sous bonus superPacman
    else if(pacman_is_superPacman[0]==1){
        deplacement_fantome = choose_a_case(emplacement);
    }
    //Si les fantomes sont a portee de pacman
    else if(position_pacman%largeur>position_fantome[emplacement]%largeur-5&&position_pacman%largeur<position_fantome[emplacement]+5
    &&int(position_pacman/hauteur)>int(position_fantome[emplacement]/hauteur-5)&&int(position_pacman/hauteur)<int(position_fantome[emplacement]/hauteur+5)){
        deplacement_fantome = chase(emplacement);
    }
    //Si y a rien d'autre à faire les fantomes se déplacent normalement
    else{
        deplacement_fantome = choose_a_case(emplacement);
    }
    return deplacement_fantome; 
}
