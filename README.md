## Perl Dancer

Instalación de paquetes de CPANM

	$ curl -L http://cpanmin.us | perl - --sudo Dancer2
	$ sudo cpanm Plack::Middleware::Deflater DBD::SQLite DBD::mysql JSON JSON::Create JSON::XS Crypt::MCrypt Try::Tiny Plack::Loader::Shotgun Plack::Handler::Starman Plack::Middleware::Headers Dancer2::Session::Cookie Switch DBIx::Transaction

Arrancar Dancer:

	$ plackup -r bin/app.psgi

Arrancar Dancer con autoreload luego de hacer cambios:

	$ plackup -L Shotgun bin/app.psgi

Arrancar en modo de producción con workers:

	$ plackup -E deployment -s Starman --workers=50 -p 5000 -a bin/app.psgi

### Mmigraciones

Migraciones con DBMATE - ubicaciones:

    $ dbmate -d "ubicaciones/migrations" -e "DATABASE_UBICACIONES" new <<nombre_de_migracion>>
    $ dbmate -d "ubicaciones/migrations" -e "DATABASE_UBICACIONES" up

### Dump de variables

		use Data::Dumper;

    #print("\nA\n");print($url);print("\nB\n");
    #print("\n");print Dumper(%temp);print("\n");

---

Fuentes:

+ http://blog.endpoint.com/2015/01/cleaner-redirection-in-perl-dancer.html
+ https://metacpan.org/pod/Dancer2::Manual#response_headers
+ https://metacpan.org/pod/DBIx::Class
+ https://metacpan.org/pod/DBIx::Class::Schema
+ https://metacpan.org/pod/release/ARCANEZ/DBIx-Class-0.08126/lib/DBIx/Class/Schema.pm
+ https://www.perlmonks.org/?node_id=1114821
+ https://metacpan.org/pod/Dancer2::Tutorial
+ https://perlmaven.com/refactoring-dancer2-using-before-hook
+ https://metacpan.org/pod/Dancer::Session::Cookie
+ https://metacpan.org/pod/Dancer::Session
+ https://github.com/PerlDancer/Dancer2-Session-Cookie/issues/18
+ https://stackoverflow.com/questions/1814196/quickly-getting-to-yyyy-mm-dd-hhmmss-in-perl
+ http://dancer-users.dancer.narkive.com/se0ZYJ6t/dancer2-session-destroy-fails
+ https://stackoverflow.com/questions/23262932/custom-404-route-not-matching-website-root
