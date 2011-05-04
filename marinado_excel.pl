#!/usr/bin/perl 

use lib '/usr/bin/ph/perllib/share/perl/5.8.4';
use lib '/usr/bin/ph/perllib/lib/perl/5.8.4';
use HTML::TableExtract;
use OpenOffice::OODoc;
use lib '/usr/lib/perl5/lib/perl/5.8.4';
use DBI;

$ENV{PATH} .= ":\/usr\/bin\/ph";

# Quita Acentos y tambien limpia archivo HTML de tags y unicamente deja las tablas
sub quita_acentos {

    # El primer argumento es el nombre del archivo a leer
    # El segundo es el archivo donde se guarda el resultado
    # Se leen argumentos
    my ( $file, $output ) = @_;

    # Se limpia el archivo y se guarda en un archivo temporal
`sed -e '1,71d' -e '/336699/d' -e '/Back/d' -e '/body/d' -e '/HTML/d' -e 's/<table/<table class="descriptionTabla"/g' < $file > $file.tmp`;

    # Se abre el archivo temporal y se guarda en un arreglo
    open( HTML_FILE, "$file.tmp" );
    my @data = <HTML_FILE>;
    close(HTML_FILE);

    # Se quitan acentos
    foreach $line (@data) {
        $line =~ s/\&oacute\;/o/g;
        $line =~ s/\&aacute\;/a/g;
        open( FILE, ">>$output" );
        print FILE "$line";
    }
    close(FILE);

    # Se borran estos archivos
    unlink("$file.tmp");
    unlink("$file");
}

sub get_data_table {

    # Recibe como primer argumento el archivo html
    my ($file) = @_;

    # Se inicializa el parser de HTML
    $te = HTML::TableExtract->new();
    $te->parse_file($file);

    # Se obtienen los renglones de las tablas
    foreach $ts ( $te->tables ) {
        foreach $row ( $ts->rows ) {
            push( @data, join( ',', @$row, "\n" ) );
        }
    }

    #print "data: @data\n";

    # Se regresa el arreglo con los renglones
    return @data;

}

# Funcion para quitar datos que no se necesitan
sub clean_table {
    my @table = @_;

    # No se necesita parsear los renglones que tengan estos datos
    # Unicamente se usa la de Pronostico
    for my $i ( reverse 0 .. $#table ) {
        splice @table, $i, 1 if $table[$i] =~ /Diferencia/;
        splice @table, $i, 1 if $table[$i] =~ /Reales/;
        splice @table, $i, 1 if $table[$i] =~ /Horas/;
        splice @table, $i, 1 if $table[$i] =~ /Imprimir/;
    }

    # Se regresan los renglones
    return @table;
}

sub trim($) {
    my $string = shift;
    $string =~ s/^\s+//;
    $string =~ s/\s+$//;
    return $string;
}


sub opening_costoflabor_data {

    # Recibe como argumentos, el archivo de OOo que se esta usando,
    # la hoja del archivo que se va a usar y los datos con los que se
    # va a llenar
    my ( $calc, $sheet, @array ) = @_;

    # Las columnas en los que se llenan los datos dentro del archivo
    my $columns = 16;

    my $flag = 0;

    # Se lee el arreglo con los datos y se buscan cadenas especificas para saber
    # donde y que se va a modificar
    foreach $line (@array) {
        chomp($line);
        chop($line);
        if ( $line =~ m/Transacciones\ Totales/ ) {
            $flag = 1;
        }
        if ( $line =~ m/Receta\ Secreta/ ) {
            $flag = 2;
        }
        if ( $line =~ m/Cruji\ Pollo/ ) {
            $flag = 3;
        }
        if ( $line =~ m/Receta\ de\ Pure/ ) {
            $flag = 4;
        }
        if ( $line =~ m/Cabezas\ Totales/ ) {
            $flag = 5;
        }
        if ( $line =~ m/^Pronostico/ ) {

            #Parsear Transacciones Totales
            if ( $flag == 1 ) {
                @info = split( ',', $line );
                $calc->updateCell( $sheet, "C10", $info[15] );
                $flag = 0;
            }

            #Parsear Transacciones Secreta hasta las 19 horas
            if ( $flag == 2 ) {
                @info = split( ',', $line );
                $tot_secreta_19 = 0;
                for ( $i = 0 ; $i < $columns - 6 ; $i++ ) {
                    $tot_secreta_19 += $info[ $i + 1 ];
                }
                $calc->updateCell( $sheet, "C16", $tot_secreta_19 );
                $flag = 0;
            }

            #Parsear Transacciones Cruji hasta las 19 horas
            if ( $flag == 3 ) {
                @info = split( ',', $line );
                $tot_cruji_19 = 0;
                for ( $i = 0 ; $i < $columns - 6 ; $i++ ) {
                    $tot_cruji_19 += $info[ $i + 1 ];
                }
                $calc->updateCell( $sheet, "C15", $tot_cruji_19 );
                $flag = 0;
            }

            #Parsear Transacciones Pure
            if ( $flag == 4 ) {
                @info = split( ',', $line );

                $total_pure_10 = 0;
                $total_pure_14 = 0;
                $total_pure_18 = 0;

                # Total pure de las 10 hasta las 14 horas
                for ( $i = 0 ; $i < $columns - 10 ; $i++ ) {
                    $total_pure_10 += $info[ $i + 1 ];
                }
                $calc->updateCell( $sheet, "C31", $total_pure_10 );

                # Total pure de las 14 hasta las 18 horas
                for ( $i = 6 ; $i < 10 ; $i++ ) {
                    $total_pure_14 += $info[$i];
                }
                $calc->updateCell( $sheet, "D31", $total_pure_14 );

                # Total pure de las 18 hasta las 22 horas
                for ( $i = 10 ; $i < 15 ; $i++ ) {
                    $total_pure_18 += $info[$i];
                }
                $calc->updateCell( $sheet, "E31", $total_pure_18 );

                $flag = 0;
            }

            #Parsear Cabezas totales
            if ( $flag == 5 ) {
                @info = split( ',', $line );
                $calc->updateCell( $sheet, "C12", $info[15] );
                $flag = 0;
            }
        }
    }
}

sub closing_costoflabor_data_seleccionada {

    # Recibe como argumentos, el archivo de OOo que se esta usando,
    # la hoja del archivo que se va a usar y los datos con los que se
    # va a llenar
    my ( $calc, $sheet, @array ) = @_;

    # Las columnas en los que se llenan los datos dentro del archivo
    my $columns = 16;

    my $flag = 0;

    # Se lee el arreglo con los datos y se buscan cadenas especificas para saber
    # donde y que se va a modificar
    foreach $line (@array) {
        chomp($line);
        chop($line);
        if ( $line =~ m/Receta\ Secreta/ ) {
            $flag = 2;
        }
        if ( $line =~ m/Cruji\ Pollo/ ) {
            $flag = 3;
        }
        if ( $line =~ m/Receta\ de\ Biscuit\ \(Charolas\)/ ) {
            $flag = 4;
        }
        if ( $line =~ m/^Pronostico/ ) {

            #Parsear Transacciones Secreta de las 15 a 22
            if ( $flag == 2 ) {
                @info = split( ',', $line );
                $tot_secreta = 0;
                for ( $i = 7 ; $i < $columns - 1 ; $i++ ) {
                    $tot_secreta += $info[ $i ];
                }
                $calc->updateCell( $sheet, "C16", $tot_secreta );
                #$flag = 0;
            }

            #Parsear Transacciones Cruji de las 15 a 22
            if ( $flag == 3 ) {
                @info = split( ',', $line );
                $tot_cruji = 0;
                for ( $i = 7 ; $i < $columns - 1 ; $i++ ) {
                    $tot_cruji += $info [ $i ];
                }
                $calc->updateCell( $sheet, "C15", $tot_cruji );
                #$flag = 0;
            }
        }
        if ( $line =~ m/^Porcentaje/ ) {

            #print "entre a porcentaje, flag = $flag\n";

            #Parsear porcentaje (index) de biscuit de 14 a 15
            if ( $flag == 4 ) {
                @info          = split( ',', $line );
                $index_biscuit = 0;
                $index_biscuit = $info[6];
                $calc->updateCell( $sheet, "D22", $index_biscuit );
                $flag = 0;
            }

            #Parsear porcentajes (index de cruji de 14 a 15
            if ( $flag == 3 ) {
                @info          = split( ',', $line );
                $index_cruji = 0;
                $index_cruji = $info[6]; 
                #print "cruji index: @info\n";
                $calc->updateCell( $sheet, "D15", $index_cruji );
                $flag = 0;
            }
            #Parsear porcentajes (index de secreta de 14 a 15
            if ( $flag == 2 ) {
                @info          = split( ',', $line );
                $index_secreta = 0;
                $index_secreta = $info[6];
                #print "secreta index: @info\n";
                $calc->updateCell( $sheet, "D16", $index_secreta );
                $flag = 0;
            }
        }
    }
}

sub closing_costoflabor_data_maniana {

    # Recibe como argumentos, el archivo de OOo que se esta usando,
    # la hoja del archivo que se va a usar y los datos con los que se
    # va a llenar
    my ( $calc, $sheet, @array ) = @_;

    # Las columnas en los que se llenan los datos dentro del archivo
    my $columns = 16;

    my $flag = 0;

    # Se lee el arreglo con los datos y se buscan cadenas especificas para saber
    # donde y que se va a modificar
    foreach $line (@array) {
        chomp($line);
        chop($line);
        if ( $line =~ m/Receta\ Secreta/ ) {
            $flag = 1;
        }
        if ( $line =~ m/Cruji\ Pollo/ ) {
            $flag = 2;
        }
        if ( $line =~ m/^Pronostico/ ) {

            #Parsear Transacciones Secreta de las 15 a 22
            if ( $flag == 1 ) {
                @info = split( ',', $line );
                $tot_secreta = 0;
                for ( $i = 0 ; $i < 5 ; $i++ ) {
                    $tot_secreta += $info[ $i + 1 ];
                }
                $calc->updateCell( $sheet, "F16", $tot_secreta );
                $flag = 0;
            }

            #Parsear Transacciones Cruji de las 15 a 22
            if ( $flag == 2 ) {
                @info = split( ',', $line );
                $tot_cruji = 0;
                for ( $i = 0 ; $i < 5 ; $i++ ) {
                    $tot_cruji += $info[ $i + 1 ];
                }
                $calc->updateCell( $sheet, "F15", $tot_cruji );
                $flag = 0;
            }
        }
    }
}

sub opening_pron_data {

    # Recibe como argumentos, el archivo de OOo que se esta usando,
    # la hoja del archivo que se va a usar y los datos con los que se
    # va a llenar
    my ( $calc, $sheet, $file ) = @_;

    $filename = `basename $file`;

    chomp( $filename );

    `/usr/bin/links -dump $file | grep Proyectada > /tmp/marinado/pronostico/$filename.txt`;

    open FILE, "/tmp/marinado/pronostico/$filename.txt" or die $!;

    my @lines = <FILE>;
    close( FILE );

    $i = 1;

    foreach $row ( @lines ) {
        # Big Crunch Totales
        if ( $i == 6 ) {
            @data = split( /\|/, $row );
            $total = trim( $data[18] );
            $calc->updateCell( $sheet, "C20", $total ); 
        }
        # Pure individual primera linea de Proyectada
        if ( $i == 25 ) {
            @data = split( /\|/, $row );
            for ( $j = 4; $j < 8; $j++ ) { 
                $total_pure_individual_1014  += trim( $data[$j] );
            }
            for ( $j = 8; $j < 10; $j++ ) {
                $total_pure_individual_1418 = trim( $data[$j] );
            }
        }
        # Pure individual segunda linea de Proyectada
        if ( $i == 26 ) {
            @data = split( /\|/, $row );
            for ( $j = 2; $j < 4; $j++ ) { 
                $total_pure_individual_1418  += trim( $data[$j] );
            }
            for ( $j = 4; $j < 10; $j++ ) {
                $total_pure_individual_1822 += trim ( $data[$j] );
            }
        }
        # Pure jumbo primera linea de Proyectada
        if ( $i == 27 ) {
            @data = split( /\|/, $row );
            for ( $j = 4; $j < 8; $j++ ) { 
                $total_pure_jumbo_1014  += trim( $data[$j] );
            }
            for ( $j = 8; $j < 10; $j++ ) {
                $total_pure_jumbo_1418 = trim( $data[$j] );
            }
        }
        # Pure jumbo segunda linea de Proyectada
        if ( $i == 28 ) {
            @data = split( /\|/, $row );
            for ( $j = 2; $j < 4; $j++ ) { 
                $total_pure_jumbo_1418  += trim( $data[$j] );
            }
            for ( $j = 4; $j < 10; $j++ ) {
                $total_pure_jumbo_1822 += trim ( $data[$j] );
            }
        }
        # Pure familiar primera linea de Proyectada
        if ( $i == 29 ) {
            @data = split( /\|/, $row );
            for ( $j = 4; $j < 8; $j++ ) { 
                $total_pure_familiar_1014  += trim( $data[$j] );
            }
            for ( $j = 8; $j < 10; $j++ ) {
                $total_pure_familiar_1418 = trim( $data[$j] );
            }
        }
        # Pure familiar segunda linea de Proyectada
        if ( $i == 28 ) {
            @data = split( /\|/, $row );
            for ( $j = 2; $j < 4; $j++ ) { 
                $total_pure_familiar_1418  += trim( $data[$j] );
            }
            for ( $j = 4; $j < 10; $j++ ) {
                $total_pure_familiar_1822 += trim ( $data[$j] );
            }
        }
        # Ensalada Individual Total
        if ( $i == 32 ) {
            @data = split( /\|/, $row );
            $total = trim( $data[10] );
            $calc->updateCell( $sheet, "C25", $total );
        }
        # Ensalada Jumbo Total
        if ( $i == 34 ) {
            @data = split( /\|/, $row );
            $total = trim( $data[10] );
            $calc->updateCell( $sheet, "C26", $total );
        }
        # Ensalada Familiar Total
        if ( $i == 36 ) {
            @data = split( /\|/, $row );
            $total = trim( $data[10] );
            $calc->updateCell( $sheet, "C27", $total );
        }
        # Para obtener totales biscuit de 15 a 22
        if ( $i == 39 ) {
            @data = split( /\|/, $row );
            $total_biscuit_1516 = trim( $data[9] );
        }
        # Biscuit piezas totales
        if ( $i == 40 ) {
            @data = split( /\|/, $row );
            $total = trim( $data[10] );
            $calc->updateCell( $sheet, "C35", $total );
            for ( $i = 2; $i < 8; $i++ ) {
                $total_biscuit_1622 += trim( $data[$i] );
            }
            $total_biscuit_1522 = $total_biscuit_1622 + $total_biscuit_1516;
            $calc->updateCell( $sheet, "C36", $total_biscuit_1522 );
        }
        $i++;
    }
    # Calcular receta salsa gravy de 10 a 14
    $gravy_1014 = ( $total_pure_familiar_1014 / 30 ) + ( $total_pure_individual_1014 / 120 ) + ( $total_pure_jumbo_1014 / 60 );
    $gravy_1418 = ( $total_pure_familiar_1418 / 30 ) + ( $total_pure_individual_1418 / 120 ) + ( $total_pure_jumbo_1418 / 60 );
    $gravy_1822 = ( $total_pure_familiar_1822 / 30 ) + ( $total_pure_individual_1822 / 120 ) + ( $total_pure_jumbo_1822 / 60 );

    #print "gravy: $gravy_1014 $gravy_1418 $gravy_1822\n";
    #print "$total_pure_familiar_1014 $total_pure_individual_1014 $total_pure_jumbo_1014 $total_pure_familiar_1418 $total_pure_individual_1418 $total_pure_jumbo_1418 $total_pure_familiar_1822 $total_pure_individual_1822 $total_pure_jumbo_1822\n";
    
    $calc->updateCell( $sheet, "G31", $gravy_1014 );
    $calc->updateCell( $sheet, "H31", $gravy_1418 );
    $calc->updateCell( $sheet, "I31", $gravy_1822 );

}

sub big_crunch_totales {

    # Recibe como argumentos, el archivo de OOo que se esta usando,
    # la hoja del archivo que se va a usar y los datos con los que se
    # va a llenar
    my ( $calc, $sheet, $file, $cell ) = @_;

    $filename = `basename $file`;

    chomp( $filename );

    `/usr/bin/links -dump $file | grep Proyectada > /tmp/marinado/pronostico/$filename.txt`;

    open FILE, "/tmp/marinado/pronostico/$filename.txt" or die $!;

    my @lines = <FILE>;
    close( FILE );

    $i = 1;

    foreach $row ( @lines ) {
        # Big Crunch Totales
        if ( $i == 6 ) {
            @data = split( /\|/, $row );
            $total = trim( $data[18] );
            $calc->updateCell( $sheet, $cell, $total ); 
        }
        $i++;
    }

}

# Se valida el numero de argumentos
$numArgs = $#ARGV + 1;
if ( $numArgs != 4 ) {
    die "Uso: $0 dia semana periodo anio\n. Ejem: $0 19 8 2 2011\n";
}

# Se asigna a una variable los argumentos
$day    = $ARGV[0];
$week   = $ARGV[1];
$period = $ARGV[2];
$year   = $ARGV[3];

# Se realiza la conexion a la base de datos de PostgresSQL
# De aqui se obtienen las fechas de acuerdo al periodo, semana y anio
$dbh = DBI->connect( "dbi:Pg:dbname=dbeyum", "postgres", "" );

if ( !defined $dbh ) {
    die "Error al conectarse a la db!\n";
}

# Se borra el directorio que es usado para descargar los htmls
system("mkdir -p /tmp/marinado/{modelo,pronostico}");

# Se borra dentro de Tomcat los htmls usados en algun reporte anterior
system(
    "rm -f /usr/local/tomcat/webapps/ROOT/Planning/MarinationPlan/Rpt/*.html");

# Este es el query para obtener las fechas.
$query = $dbh->prepare(
"SELECT to_char(date_id, 'YY-MM-DD') AS begindate FROM ss_cat_time WHERE year_no=$year AND period_no=$period AND week_no=$week AND EXTRACT (day FROM date_id)=$day"
);

if ( !defined $query ) {
    die "Error: $DBI::errstr\n";
}

$query->execute;

my $fecha_seleccionada = $query->fetchrow();

chomp( $fecha_seleccionada );

my $fecha_maniana = `/usr/bin/ph/dsig.s $fecha_seleccionada`;
chomp( $fecha_maniana);
my $fecha_pasado_maniana = `/usr/bin/ph/dsig.s $fecha_maniana`;
chomp( $fecha_pasado_maniana);

push( @fechas, $fecha_seleccionada, $fecha_maniana, $fecha_pasado_maniana );

#print "fecha_pasado_maniana: $fecha_pasado_maniana\n";
#print "fecha_maniana: $fecha_maniana\n";
#print "fecha_seleccionada $fecha_seleccionada\n";

#print "fechas: @fechas\n";

# Con ayuda de los scripts del reporteador, se obtienen los reportes
# del modelo de labor con las fechas necesarias y se guardan en un
# directorio temporal
for ( $i = 0 ; $i < $#fechas; $i++ ) {
    system(
"/usr/bin/wget -q -O /tmp/marinado/modelo/$fechas[$i].html http://localhost/php/View.php?file=./modelodelabor/history.php\\&date=$fechas[$i]\\&year=\\&period=\\&week="
    );
}

# Con ayuda de los scripts del reporteador, se obtienen los reportes
# de pronostico y ensamble con las fechas necesarias y se guardan en un
# directorio temporal
for ( $i = 0 ; $i < $#fechas + 1 ; $i++ ) {
    system(
"/usr/bin/wget -q -O /tmp/marinado/pronostico/$fechas[$i].html http://localhost/php/View.php?file=pronens/pronostico.php\\&date=$fechas[$i]\\&year=\\&period=\\&week="
    );
}

# Se abre el archivo de OOo
# Se usa un archivo que no se edita, solo se lee.
$calcsheet =
  ooDocument( file =>
'/usr/local/tomcat/webapps/ROOT/Planning/MarinationPlan/Rpt/Planeacion_Diaria_Marinado_y_Ajuste_Marinado_orig.sxc'
  );

# Se normaliza cada Hoja del archivo
my $apertura_sheet = $calcsheet->normalizeSheet( "Apertura", 36, 10 );
my $cierre_sheet   = $calcsheet->normalizeSheet( "Cierre",   23, 12 );

# Se obtienen datos del modelo de labor para hoja de apertura
quita_acentos(
    "/tmp/marinado/modelo/$fechas[0].html",
    "/tmp/marinado/modelo/$fechas[0]-sa.html"
);



my @array =
  clean_table( get_data_table("/tmp/marinado/modelo/$fechas[0]-sa.html") );

opening_costoflabor_data( $calcsheet, $apertura_sheet, @array );

# Se obtienen datos del modelo de labor para hoja de cierre
closing_costoflabor_data_seleccionada( $calcsheet, $cierre_sheet, @array );

# Se obtienen datos del modelo de labor para hoja de cierre pero del dia siguiente
quita_acentos(
    "/tmp/marinado/modelo/$fechas[1].html",
    "/tmp/marinado/modelo/$fechas[1]-sa.html"
);

undef(@array);
@array =
  clean_table( get_data_table("/tmp/marinado/modelo/$fechas[1]-sa.html") );
closing_costoflabor_data_maniana( $calcsheet, $cierre_sheet, @array );


opening_pron_data( $calcsheet, $apertura_sheet, "/tmp/marinado/pronostico/$fechas[0].html" );

big_crunch_totales( $calcsheet, $apertura_sheet, "/tmp/marinado/pronostico/$fechas[1].html", "C21" );
big_crunch_totales( $calcsheet, $apertura_sheet, "/tmp/marinado/pronostico/$fechas[2].html", "C22" );


# Llenar fecha y centro
# Obtener nombre de la tienda
$query = $dbh->prepare("select store_id,store_name from stores");
if ( !defined $query) {
        die "Error: $DBI::errstr\n";
}

$query->execute;

$query->bind_columns(undef, \$cc, \$store_name);
# Llenar nombre de la tienda
while ($query->fetch()) {
	$calcsheet->updateCell($apertura_sheet, "C5", "$cc $store_name $fecha_seleccionada");
}

# Guardar archivo
$calcsheet->save("/usr/local/tomcat/webapps/ROOT/Planning/MarinationPlan/Rpt/marinado.sxc");


# Cerrar conexiones a BD
$query->finish;
$dbh->disconnect();

# Copiar reportes de html a Tomcat para ser desplegados
system("cp /tmp/marinado/modelo/*.html /usr/local/tomcat/webapps/ROOT/Planning/MarinationPlan/Rpt/");
#system("cp /tmp/marinado/pronostico/*.html /usr/local/tomcat/webapps/ROOT/Planning/MarinationPlan/Rpt/");

# Borrar el directorio temporal
system("rm -rf /tmp/marinado");

# Permisos
system("chmod 644 /usr/local/tomcat/webapps/ROOT/Planning/MarinationPlan/Rpt/marinado.sxc");
