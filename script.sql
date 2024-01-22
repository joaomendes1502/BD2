load csv with headers from "file:///desportos.csv" as linha
create (d:desportos {cod_desporto: linha.cod_desporto, desporto: linha.desporto, participantes_femininos: linha.participantes_femininos, participantes_masculinos: linha.participantes_masculinos, total_participantes: linha.total_participantes});

load csv with headers from "file:///paises.csv" as linha
create (p:paises {cod_pais: linha.cod_pais, pais: linha.pais});

load csv with headers from "file:///treinadores.csv" as linha
match (d:desportos{cod_desporto: linha.cod_desporto})
match (p:paises{cod_pais: linha.cod_pais})
create (t:treinadores{cod_treinador: toInteger(linha.cod_treinador), nome_treinador: linha.nome_treinador})
create (t) - [:Treina] -> (d)
create (t) - [:NacionalidadeT] -> (p)

load csv with headers from "file:///oficiais_tecnicos.csv" as linha
match (d:desportos{cod_desporto: linha.cod_desporto})
match (p:paises{cod_pais: linha.cod_pais})
create (ot:oficiais_tecnicos{cod_tecnico: toInteger(linha.cod_tecnico), nome_tecnico: linha.nome_tecnico, genero_tecnico: linha.genero_tecnico, aniversario_tecnico: linha.aniversario_tecnico, funcao: linha.funcao})
create (ot) - [:Arbitra] -> (d)
create (ot) - [:NacionalidadeOT] -> (p)

load csv with headers from "file:///atletas.csv" as linha
match (d:desportos{cod_desporto: linha.cod_desporto})
match (p:paises{cod_pais: linha.cod_pais})
create (a:atletas{cod_atleta: toInteger(linha.cod_atleta), nome_atleta: linha.nome_atleta, aniversario_atleta: linha.aniversario_atleta, genero_atleta: linha.genero_atleta})
create (a) - [:Pratica] -> (d)
create (a) - [:NacionalidadeA] -> (d)

load csv with headers from "file:///medalhas.csv" as linha
match (p:paises{cod_pais: linha.cod_pais})
match (a:atletas{cod_atleta: toInteger(linha.cod_atleta)})
match (d:desportos{cod_desporto: linha.cod_desporto})
create (m:medalhas{evento: linha.evento, tipo_medalha: linha.tipo_medalha})
create (m) - [:Corresponde] -> (d)
create (m) - [:Pais] -> (p)
create (m) - [:Pertence_Medalha] -> (a)

load csv with headers from "file:///equipas.csv" as linha
match (d:desportos{cod_desporto: linha.cod_desporto})
match (p:paises{cod_pais: linha.cod_pais})
create (e:equipas{cod_equipa: toInteger(linha.cod_equipa), nome_equipa: linha.nome_equipa, evento: linha.evento})
create (e) - [:Equipa_Pratica] -> (d)
create (e) - [:Pertence_Equipa] -> (p)

load csv with headers from "file:///medalhas_por_pais.csv" as linha
match (p:paises{cod_pais: linha.cod_pais})
create (mp:medalhas_por_pais{rank_a: toInteger(linha.rank_a), medalha_ouro: toInteger(linha.medalha_ouro), medalha_prata: toInteger(linha.medalha_prata), medalha_bronze: toInteger(linha.medalha_bronze), medalhas_total: toInteger(linha.medalhas_total), rank_total: toInteger(linha.rank_total)})
create (mp) - [:Obteve] -> (p)