#!/bin/awk -f


BEGIN {
  #nastaveni separatoru zaznamu na znak <
  #nastaveni separatoru pole na znak > 
  RS="<"
  FS=">"
}
#tedy adresa bude vzdycky v $1


#pokud jsou pred href i jiny atributy tak se odstrani
{
  sub(/[aA]([\n\t ]+[a-zA-z]+[\n\t ]*=[\n\t ]*\"[^"]*\")+[\t\n ]+[hH][rR][eE][fF]/,"a href",$1) 
}


#odstrani nadbytecni mezery a novy radky
#podminka prazdna, vyhovuje vsem radkum
{
  gsub(/[Aa][\t\n ]+[hH][Rr][Ee][Ff][\t\n ]*=[\t\n ]*/, "a href=", $1)
}


#pokud odkaz neobsahuje mezery a neni v uvozovkach, pridame uvozovky
#znak & znaci cely regexp, a href=... je vzdycky posledni atribut
{
  if ($1 ~ /[aA] [hH][rR][Ee][Ff]=[^"' ]+$/) {
    sub(/[Aa] [hH][rR][Ee][Ff]=/, "a href=\"", $1)
    sub(/.*/, "&\"", $1)
  }
}


{
  if ($1 ~ /[Aa] [hH][rR][Ee][Ff]=['"][^"']*['"]/) {
    sub(/[aA] [hH][rR][Ee][Ff]=["']/, "", $1)
    sub(/["']/, "", $1)

    gsub("&quot;", "\"", $1)  
    gsub("&lt;", "<", $1)
    gsub("&gt;", ">", $1)
    gsub("&amp;", "\&", $1)  

    print $1
  }
} 
