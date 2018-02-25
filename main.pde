/* Nombre entier a ne pas reprendre [0-200] destine a la carte
    Nombre entier destine aux fantomes [201-212] (fantome_max=12)
    213 = pacman */
//hauteur et largeur doivent etre des nombres impairs

//Varaible général de la fenetre et de la carte(les deux sont liés)
int largeur= 31;
int hauteur= 31;
int largeur_carree = 20;
int centre = (largeur*hauteur)/2;
int map[];

//Variable général du jeu
int score = 0;
int score_du_niveau=0;
int vie = 3;
int nombre_fantome = 4;
int niveau = 1;
int case_vide;
int pourcentage_niveau;

//Variable pour les fantomes
PImage image_fantome[] = new PImage[4];
int identite_fantome[];
int position_fantome[];
int fatigue_fantome[];
int max_fatigue = 15;

//Variable pour les bombes
PImage bombe_image;
int max_bombe = 4;
int position_bombe[];

//Variable pour les petites points
PImage petit_point_image;
int position_petit_point[];

//Variable pour les cerises(plus de points)
PImage cerise_image;
int nb_cerise = 4;
int position_cerise[];

//Variable pour les super Pacman(bonus qui permet à pacman de manger les fantomes)
int pacman_is_superPacman[] = {0,0}; //Enregistre si pacman est sous le bonus et cb de temps a duré le bonus
PImage superPacman_image;
int nb_superPacman = 4;
int position_superPacman[];
int pacman_is_superPacman_for_turn = 15; //Definit le nombre de tour ou le bonus est activé

//Variable pour pacman
PImage pacman_image[] = new PImage[4];
int position_pacman;
int identite_pacman;
int pacman_direction;

int image = 0; //Sert a active la boucle du jeu

int onglet = 0; //sert à afficher le menu

//Variable pour le menu
PImage imageBoutonRetour;
PImage imageBoutonMoins;
PImage imageBoutonPlus;

//Variable qui active ou non la génération du niveau
//Notament pour appliquer les modifications fait dans les options
boolean generation=false;

//Variable pour enregistrer les scores dans le JSON
JSONObject json;
String nom = "";

void setup(){
    size(820,620); //largeur*hauteur <-- Ne peut pas être des variables a cause de processing Javascript
    background(0);
    smooth(8);
    imageBoutonRetour = loadImage("image/bouton_retour.jpeg");
    imageBoutonMoins = loadImage("image/moins.jpeg");
    imageBoutonPlus = loadImage("image/plus.jpeg");
    image_fantome[0] = loadImage("image/fantome0.png");
    image_fantome[1] = loadImage("image/fantome1.png");
    image_fantome[2] = loadImage("image/fantome2.png");
    image_fantome[3] = loadImage("image/fantome3.png");
    pacman_image[0] = loadImage("image/Pacman_bas.png");
    pacman_image[1] = loadImage("image/Pacman_haut.png");
    pacman_image[2] = loadImage("image/Pacman_droite.png");
    pacman_image[3] = loadImage("image/Pacman_gauche.png");
    json = loadJSONObject("score.json");
    frameRate(30); 
}

void draw(){
    //Faire apparaitre le menu
    affichage();
    
}
