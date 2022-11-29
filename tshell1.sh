#!/bin/bash
#Trabalho Shell 1
#Thales Carvalho
#set -x

#1 - fazer o ssh para entrar a um host do dinf

#2
#entra no diretorio
pushd /home/html/inf/cursos/ci1001/tshell1 
#procura o nome do diretório em PISTA 1 e armazena na var1
var1=$(cut -d '|' -f2 PISTA1 | head -n3 | tail -n1)
#var1 = pista2.txt

#3
#utiliza base64 para decodificar o conteudo do arquivo cujo nome esta em var1
var2=$(base64 -d $var1)
#var2 = .outrapista

#4
#insere o conteudo do arquivo que o nome esta armazenado em var2 na var3
var3=$(cat "$var2")
#var3= --

#5
#encontra o arquivo com o tamanho em bites igual a quantidade de linhas de var3 e o insere em var4
var4=$(cat $(find /home/html/inf/cursos/ci1001/tshell1 -size $(cat ./$var3 | wc -l )c 2>/dev/null))
#var4=mais_uma_pista

#6
#checa se o alias já existe em .bashrc e caso não exista o cria 
if ! grep -q rot13 ~/.bashrc 
then
    #faz o deslocamento de 13 caracteres 
    echo "alias rot13=\"tr 'a-z' 'n-za-m'\"">>~/.bashrc 
    #executa o .bashrc     
    source ~/.bashrc
fi
#armazena no var5 o conteudo de var4 com o rot13 aplicado 
var5=.$(echo $var4 | rot13)
#var5 = .znvf_hzn_cvfgn

#7
#procura o diretorio oculto com permissão de leitura para "outros" e entra nele 
pushd $(find -perm 777 2>/dev/null)
#procura o arquivo nesse diretorio 
for file in $(ls);
do
 #procura um arquivo que não é vazio e não é um diretorio
 if [ -s $file ] && [ -f $file ]   
 then 
  #armazena o conteúdo do arquivo encontrado em var6
  var6=$(cat $file);
  #var6 = is.9ioseo^,78.ss9927<
 fi
done


#8
#faz as substituições utilizando sed
coordenadas=$(echo "$var6" | sed 's/i/1/g' |sed 's/s/5/g' | sed 's/o/0/g' | sed 's/e/3/g' | sed 's/\^/N/g' | sed 's/_/S/g' | sed 's/>/E/g' | sed 's/</W/g')
echo "Coordenadas do tesouro: $coordenadas"
