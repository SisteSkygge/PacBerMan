void enregistrer_score(JSONObject json,String name,int score){
    //Enregistre le nouveau score du joueur dans le fichier score.json
    if(name==""){
        name="Nameless";    
    }
    int id = 0;
    JSONObject player;
    while(true){
        try{
            player = json.getJSONObject(str(id));
        } catch(Exception e) {
            break;
        }
        id++;
    }
    player = new JSONObject();
    player.setString("name",name);
    player.setInt("score",score);
    json.setJSONObject(str(id),player);
    saveJSONObject(json,"score.json");
}
