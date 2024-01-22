-- Codigo dos atletas que ganharam uma medalha de ouro

MATCH (m:medalhas) - [:Pertence_Medalha] -> (a:atletas)
WHERE m.tipo_medalha = "Gold Medal"
RETURN a.cod_atleta;


-- Código dos técnicos oficiais que têm a funçao de Árbitro de Judo

MATCH (ot:oficiais_tecnicos) - [:Arbitra] -> (d:desportos)
WHERE ot.funcao = "Referee" AND d.cod_desporto = "JUD"
RETURN ot.cod_tecnico;

-- -Codigo dos paises que ganharam entre 10 e 20 medalhas de prata

MATCH (mp:medalhas_por_pais) - [:Obteve] -> (p:paises)
WHERE 10 < mp.medalha_prata < 20
RETURN p.cod_pais, mp.medalha_prata;


-- -Cod dos treinadores e nome que treinam alguma equipa do Wheelchair Basketball (WBK) ordenados por ordem decrescente

MATCH (t:treinadores) - [:Treina] -> (d:desportos)
WHERE d.cod_desporto = 'WBK'
RETURN t.cod_treinador, t.nome_treinador
ORDER BY t.cod_treinador DESC;

-- Atletas que nasceram no ano de 1993

MATCH (a:atletas)
WHERE "1993-01-01" < a.aniversario_atleta < "1993-12-31"
RETURN a.cod_atleta, a.nome_atleta, a.aniversario_atleta 

