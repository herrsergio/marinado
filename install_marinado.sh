#!/bin/bash

TOMCAT="/usr/local/tomcat/webapps/ROOT"

PLANNING="/usr/local/tomcat/webapps/ROOT/Planning"

if [ ! -d $PLANNING ]; then
    mkdir $PLANNING
fi

tar xvjf /tmp/marinadoKFC.tar.bz2 -C /tmp

/bin/mv /tmp/MarinationPlan $PLANNING/

chown -R root.root $PLANNING/MarinationPlan

if [ ! -f $TOMCAT/SQL/ss_cat_menu_option_kfc.sql.`date +%d%m%y` ]; then
    /bin/cp $TOMCAT/SQL/ss_cat_menu_option_kfc.sql  $TOMCAT/SQL/ss_cat_menu_option_kfc.sql.`date +%d%m%y`
fi

/bin/mv /tmp/ss_cat_menu_option_kfc.sql $TOMCAT/SQL/ss_cat_menu_option_kfc.sql

psql -U postgres -d dbeyum < $TOMCAT/SQL/ss_cat_menu_option_kfc.sql

/bin/mv /tmp/marinado_excel.pl /usr/bin/ph/perllib/bin/
chown admin.sus /usr/bin/ph/perllib/bin/marinado_excel.pl
chmod 755 /usr/bin/ph/perllib/bin/marinado_excel.pl
chown admin.sus /usr/bin/ph/perllib/bin/marinado_excel.pl


sum -r /usr/bin/ph/perllib/bin/marinado_excel.pl > /tmp/marinado.sum
sum -r $PLANNING/MarinationPlan/Rpt/* >> /tmp/marinado.sum


