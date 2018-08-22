use strict;
use warnings;
use Dancer2;
use MongoDB;
use utf8;
use JSON;
use Try::Tiny;
use JSON::Parse 'parse_json';
use Encode qw(decode encode);
use Data::Dumper;

my $client = MongoDB->connect();
my $db = $client->get_database('demo');

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
};

sub listar {
  my $rpta = '';
  my $status = 200;
  try {
    my $blogs = $db->get_collection('blogs');
    my @docs = $blogs->find->all;
    my @temp = ();
    for my $doc(@docs){
      push @temp, {(
        id => '' . $doc->{'_id'},
        nombre => $doc->{'nombre'},
        descripcion => $doc->{'descripcion'},
      )};
    }
    $rpta = \@temp;
  } catch {
    #warn "got dbi error: $_";
    $rpta = {
      tipo_mensaje => 'error',
      mensaje => [(
        'Se ha producido un error en listar los blogs',
        '' . $_,
      )],
    };;
  };
  status $status;
  return Encode::decode('utf8', JSON::to_json($rpta));
};
# directorio de archivos estáticos
public: '/public';
# rutas
get '/' => \&home;
get '/hola' => \&demo;
get '/listar' => \&listar;
any qr{.*} => \&not_found;
# inicio de la aplicación
dance;
