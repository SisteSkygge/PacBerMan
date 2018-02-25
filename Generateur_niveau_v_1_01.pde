int[] creer_terrain(){
    /*
    Creer et renvoie une liste de largeur*hauteureur nombres entier de 0 à 1.
    0 correspondra aux murs et 1 aux chemins libres
    */

    int map[] = new int[largeur*hauteur];
    for(int i=0;i<largeur*hauteur;i++){
        map[i] = int(random(0,1.999));
    }

    base(map);
    isole(map);
    creer_chemin(map,hauteur,largeur);
    nettoyer(map);
    return map;
}

int[] base(int map[]){
 
     /*
     Creer les contours de base commun a toutes les cartes de pac-man et la carte des fantomes
     6 = chemin libre dans l'enclos des fantomes
     7 = chemin libre qui ne doit pas etre modifier
     8 = mur qui ne doit pas etre modifier
     2 = porte special pour les fantomes
     9 = milieu de la carte (repere)
     */
     
     //Mur tout à droite vertical
     for(int i=largeur-1;i<map.length;i+=largeur){
        map[i]=8; 
     }
     
     //Mur tout à gauche vertical
     for(int i=0;i<map.length;i+=largeur){
        map[i]=8; 
     }
     
     //Mur tout en haut horizontal
     for(int i=0;i<largeur;i++){
        map[i]=8; 
     }
     
     //Mur tout en bas horizontal
     for(int i=hauteur*largeur-largeur;i<map.length;i++){
        map[i]=8; 
     }
     
     //Creer le passage à droite et à gauche qui seront reliés ensemble : 3cases+3 autre devants
     for(int i =0;i<3;i++){
         map[centre-largeur/2-hauteur+i]=7;
         map[centre+largeur/2-hauteur-i]=7;
     }
     for(int i =0;i<3;i++){
         map[centre-largeur/2+i]=7;
         map[centre+largeur/2-i]=7;
     }
     for(int i =0;i<3;i++){
         map[centre-largeur/2+hauteur+i]=7;
         map[centre+largeur/2+hauteur-i]=7;
     }
     //Correction
     map[centre-largeur/2-hauteur]=8;
     map[centre+largeur/2+hauteur]=8;
     
     //Creation de la base des fantomes 
     /*Schema :             888222888
                            877777778
                            877797778
                            877777778
                            888888888
     */ 
     for(int i=0;i<3;i++){
        map[i+centre-4-2*hauteur]=8;
     }
     for(int i=0;i<3;i++){
        map[i+centre-1-2*hauteur]=2; 
     }
     for(int i=0;i<3;i++){
        map[i+centre+2-2*hauteur]=8; 
     }
     map[centre-4]=8;
     map[centre+4]=8;
     map[centre-4+hauteur]=8;
     map[centre+4+hauteur]=8;
     map[centre-4-hauteur]=8;
     map[centre+4-hauteur]=8;
     for(int i=0;i<7;i++){
         map[i+centre-3+hauteur]=6; 
         map[i+centre-3-hauteur]=6;
         map[i+centre-3]=6;
     }
     for(int i=0;i<9;i++){
        map[i+centre+2*hauteur-4]=8; 
     }
     map[centre] = 9;
     
     //Creation du passage autour de la base des fantomes
     for(int i=0;i<11;i++){
         map[i+centre-5-3*hauteur]=7;
         map[i+centre-5+3*hauteur]=7;
     }
     for(int i=-3;i<3;i++){
         map[i*hauteur+centre+5]=7;
         map[i*hauteur+centre-5]=7;
     }
     
     return map;
 }
 
int[] isole(int map[]){
 
    /* Trouve les chemins libres isoles leurs donnent une identite
    unique puis les relie tous ensemble par plusieurs chemins 
    En faisant une premiere lecture de 1 a hauteur*largeur
    puis de hauteur*largeur a 1 puis en en faisant une deuxieme
    pour avoir une bonne homogenite
    */
    int identite = 10;


    for(int i=0;i<map.length;i++){
        if(map[i]==1 || map[i]>=10){
            identite = detection(map,i,identite);
            remplacer(map,i);
        }
    }
    for(int i=largeur*hauteur;i<0;i--){
        if(map[i]==1 || map[i]>=10){
            identite = detection(map,i,identite);
            remplacer(map,i);
        }
    }
    for(int i=0;i<map.length;i++){
        if(map[i]==1 || map[i]>=10){
            identite = detection(map,i,identite);
            remplacer(map,i);
        }
    }
    for(int i=largeur*hauteur;i<0;i--){
        if(map[i]==1 || map[i]>=10){
            identite = detection(map,i,identite);
            remplacer(map,i);
        }
    }
    return map;
}

int detection(int map[],int i,int identite){

    /* Detecte autour du chemin d'autre libre deja converti
    et associe au chemin libre le numero le plus petit
    autour de lui si il y a plusieurs chemin converti 
    si il n'y en a pas il prend la valeur identite*/

    int inferieur;
    if(map[i]!=1){
        inferieur=map[i]; 
    }else{
        inferieur = identite;
    }

    if(map[i-1] >= 10 && inferieur > map[i-1]){
        inferieur = map[i-1];
    }
    if(map[i-hauteur] >=10 && inferieur > map[i-1]){
        inferieur = map[i-hauteur];
    }
    if(map[i+1] >= 10 && inferieur > map[i+1]){
        inferieur = map[i+1];
    }
    if(map[i+hauteur] >=10 && inferieur > map[i+hauteur]){
        inferieur = map[i+hauteur]; 
    }

    map[i] = inferieur;
    if(inferieur == identite){
        identite +=1; 
    }
    return identite;
}

void remplacer(int map[],int i){
    /*Remplace autour du chemin converti les chemins libres
    Et qui change l'identite de map[i] si il rencontre
    une identite inferieur*/

    int inferieur = map[i];
    int j = 0;

    //while qui parcourt vers la droite
    while(map[i-j] == 1 || map[i-j] >= 10){
        if(map[i-j] >= 10 && map[i-j] < inferieur){
            inferieur = map[i-j];
            j = 0;
            while(map[i-j] == 1 || map[i-j] >=10){
                map[i-j] = inferieur;
                j++; 
            }
            break;
        }else{
            map[i-j] = inferieur;
        }
         j++; 
    }
    //While qui parcourt vers la gauche
    j = 0;
    while(map[i+j] == 1 || map[i+j] >= 10){
        if(map[i+j] >= 10 && map[i+j] < inferieur){
            inferieur = map[i+j];
            j = 0;
            while(map[i+j] == 1 || map[i+j] >=10){
                map[i+j] = inferieur;
                j++;
            }
            break;
        }else{
         map[i+j] = inferieur;
    }
     j++; 
    }
    //While qui parcourt vers le bas
    j = 0;
    while(map[i+j*hauteur] == 1 || map[i+j*hauteur] >= 10){
    if(map[i+j*hauteur] >= 10 && map[i+j*hauteur] < inferieur){
        inferieur = map[i+j*hauteur];
        j = 0;
        while(map[i+j*hauteur] == 1 || map[i+j*hauteur] >=10){
            map[i+j*hauteur] = inferieur;
            j++; 
        }
        break;
        }else{
            map[i+j*hauteur] = inferieur;
        }
     j++; 
    }

    //While qui parcourt vers le haut
    j = 0;
    while(map[i-j*hauteur] == 1 || map[i-j*hauteur] >= 10){
    if(map[i-j*hauteur] >= 10 && map[i-j*hauteur] < inferieur){
    inferieur = map[i-j*hauteur];
    j = 0;
    while(map[i-j*hauteur] == 1 || map[i-j*hauteur] >=10){
    map[i-j*hauteur] = inferieur;
    j++; 
    }
    break;
    }else{
    map[i-j*hauteur] = inferieur;
    }
     j++; 
    }
}

void creer_chemin(int map[],int largeur,int hauteur){
 /* creer les 2 chemins reliant chaque zone d'identite differente
        via un decoupage de la carte en 4 parties */
 int deja_fait[] = new int [150];
 boolean inside = false;
 int compteur = 0;
 for(int i=0;i<map.length;i++){
     //Boucle for/if qui detecte si l'identite est present dans deja_fait
     for(int k=0;k<deja_fait.length;k++){
         if(map[i]==deja_fait[k]){
             inside = true; 
         }
     }
     //Verifie si le chemin n'a pas deja ete cree pour cette identite
     //Et si le carree correspond bien a un chemin avec une identite
     if(inside==false && map[i]>=10){
         //Division de la carte en 4 partie egale
         //Partie Nord-Ouest
         int j=0;

         if(i<=map.length/2 && i%largeur<=largeur/2){
             //Direction : Gauche et bas
             while(map[i+j]==0 || map[i+j]==map[i]){
                 //Verification des cases autour
                 if(map[i+j]==map[i]&&map[i+1]==0){
                     map[i+1]=map[i];
                 }else if(map[i+(j-1)+hauteur]>=10 && map[i+(j-1)+hauteur]!=map[i]){
                     break;
                 }else if(map[i+(j-1)-hauteur]>=10 && map[i+(j-1)-hauteur]!=map[i]){
                     break;
                 }else{
                     map[i+j]=map[i];
                 }
                 j++;     
             }
             j = 0;
             while(map[i+j*hauteur]==0 || map[i+j*hauteur]>=10){
                 //Verification des cases autour
                 if(map[i+j*hauteur]==map[i]&&map[i+hauteur]==0){
                     map[i+hauteur]=map[i];
                 }else if(map[i+(j-1)*hauteur+1]>=10 && map[i+(j-1)*hauteur+1]!=map[i]){
                     break;
                 }else if(map[i+(j-1)*hauteur-1]>=10 && map[i+(j-1)*hauteur-1]!=map[i]){
                     break;
                 }else{
                     map[i+j*hauteur]=map[i];
               }
                 j++;
             }
         }
         //Partie Nord-Est
         else if(i<map.length/2 && i%largeur>=largeur/2){
             //Direction Droite et bas
             while(map[i-j]==0 || map[i-j]>=10){
                 //Verification des cases autour
                 if(map[i-j]==map[i]&&map[i-1]==0){
                     map[i-1]=map[i];
                 }else if(map[i-(j-1)+hauteur]>=10 && map[i-(j-1)+hauteur]!=map[i]){
                     break;
                 }else if(map[i-(j-1)-hauteur]>=10 && map[i-(j-1)-hauteur]!=map[i]){
                     break;
                 }else{
                     map[i-j]=map[i];
                 }
                 j++;
             }
             j=0;
             while(map[i+j*hauteur]==0 || map[i+j*hauteur]>=10){
                 //Verification des cases autour
                 if(map[i+j*hauteur]==map[i]&&map[i+hauteur]==0){
                     map[i+hauteur]=map[i];
                 }else if(map[i+(j-1)*hauteur-1]>=10 && map[i+(j-1)*hauteur-1]!=map[i]){
                     break;
                 }else if(map[i+(j-1)*hauteur+1]>=10 && map[i+(j-1)*hauteur+1]!=map[i]){
                     break;
                 }else{
                     map[i+j*hauteur]=map[i];
                 }
                 j++;
             }
         }
         //Partie Sud-Ouest
         else if(i>map.length/2 && i%largeur<=largeur/2){
             //Direction gauche et haut
             while(map[i+j]==0 || map[i+j]>=10){
                 //Verification des cases autours
                 if(map[i+j]==map[i]&&map[i+1]==0){
                     map[i+1]=map[i];
                 }else if(map[i+(j-1)+hauteur]>=10 && map[i+(j-1)+hauteur]!=map[i]){
                     break;
                 }else if(map[i+(j-1)-hauteur]>=10 && map[i+(j-1)-hauteur]!=map[i]){
                     break;
                 }else{
                     map[i+j]=map[i];
                 }
                 j++;
             }
             j=0;
             while(map[i-j*hauteur]==0 || map[i-j*hauteur]>=10){
                 //Verification des cases autours
                 if(map[i-j*hauteur]==map[i]&&map[i-hauteur]==0){
                     map[i-hauteur]=map[i];
                 }else if(map[i-(j-1)*hauteur+1]>=10 && map[i-(j-1)*hauteur+1]!=map[i]){
                     break;
                 }else if(map[i-(j-1)*hauteur-1]>=10 && map[i-(j-1)*hauteur-1]!=map[i]){
                     break;
                 }else{
                    map[i-j*hauteur]=map[i];
                 }
                 j++;
             }
         }
         //Partie Sud-Est
         else{
             //Direction droite et haut
             while(map[i-j]==0 || map[i-j]>=10){
                 //Verification des cases autours
                 if(map[i-j]==map[i]&&map[i-1]==0){
                     map[i-1]=map[i];
                 }else if(map[i-(j-1)+hauteur]>=10 && map[i-(j-1)+hauteur]!=map[i]){
                     break;
                 }else if(map[i-(j-1)-hauteur]>=10 && map[i-(j-1)-hauteur]!=map[i]){
                     break;
                 }else{
                    map[i-j]=map[i];
                 }
                 j++;
             }
             j=0;
             while(map[i-j*hauteur]==0 || map[i-j*hauteur]>=10){
                 //Verification des cases autours
                 if(map[i-j*hauteur]==map[i]&&map[i-hauteur]==0){
                     map[i-hauteur]=map[i];
                 }else if(map[i-(j-1)*hauteur+1]>=10 && map[i-(j-1)*hauteur+1]!=map[i]){
                     break;
                 }else if(map[i-(j-1)*hauteur-1]>=10 && map[i-(j-1)*hauteur-1]!=map[i]){
                     break;
                 }else{
                    map[i-j*hauteur]=map[i];
                 }
                 j++;
             }
         }
         deja_fait[compteur] = map[i];
         compteur++;
     }
    //Reset du bool pour savoir si l'identite est present dans deja_fait
    inside=false; 
 }
}

void nettoyer(int map[]){
    /*Sert à nettoyer les identites des chemins car ils ne sont plus utiles */
    //Change les murs inchangeable en mur normal car plus d'utilite, de meme pour les chemins
    for(int i=0;i<map.length;i++){
        if(map[i]>=10){
            map[i]=1;
        }
        if(map[i]==7){
            map[i]=1;
        }
        if(map[i]==8){
            map[i]=0;
        }
    }
}
