class Lista{
  String id;
  String nome;
  Lista({required this.id, required this.nome});

  Lista.fromMap(Map<String,dynamic>map):id=map["id"],
  nome=map["nome"];
  // transforma o dado de volta para String
  Map<String,dynamic> toMap(){
  return {"id":id,"nome":nome
  };
}
}