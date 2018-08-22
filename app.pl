use Dancer2;
use MongoDB;

my $client = MongoDB->connect();

# hook a todos los request
hook before => sub {
  response_header 'X-Powered-By' => 'Perl Dancer 2.0016, Ubuntu';
};
# sub handlers de rutas
sub demo {
  'hola';
};

sub home {
  'Hello World!!!'
};

sub not_found {
  status 'not_found';
  '404';
}
# directorio de archivos estáticos
public: '/public';
# rutas
get '/' => \&home;
get '/hola' => \&demo;
any qr{.*} => \&not_found;
# inicio de la aplicación
dance;
