void pacman_spawn(){
    position_pacman = centre+3*hauteur;
    identite_pacman = 213;
}

int controle_bas(){
    int pacman_direction=0;
    return pacman_direction;
}

int controle_haut(){
    int pacman_direction=1;
    return pacman_direction;
}

int controle_droite(){
    int pacman_direction=2;
    return pacman_direction;
}

int controle_gauche(){
    int pacman_direction=3;
    return pacman_direction;
}

int deplacement_pacman(int pacman_direction){
    if(pacman_direction==0&&map[position_pacman+hauteur]==1||map[position_pacman+hauteur]==7){
        position_pacman+=hauteur;
    } else if(pacman_direction==1&&map[position_pacman-hauteur]==1||map[position_pacman-hauteur]==7){
        position_pacman-=hauteur;
    } else if(pacman_direction==2&&map[position_pacman+1]==1||map[position_pacman+1]==7){
        position_pacman+=1;
    } else if(pacman_direction==3&&map[position_pacman-1]==1||map[position_pacman-1]==7){
        position_pacman-=1;
    } else {
        
    }
    return position_pacman;
}
