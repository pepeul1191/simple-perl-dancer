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
my $db = $client->get_database('comentarios');

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
# handler de 'comentario'
sub comentario_crear {
  my $rpta = '';
  my $status = 200;
  my $data = JSON::XS::decode_json(Encode::encode_utf8(param('data')));
  try {
    my $comentarios = $db->get_collection('comentarios');
    my $doc = $comentarios->insert_one($data);
    $rpta = $doc->inserted_id . '';
  } catch {
    my %temp = (
      tipo_mensaje => 'error',
      mensaje => [
        'Se ha producido un error en crear el comentario',
        $@->{'msg'},
      ],
    );
    $status = 500;
    $rpta = JSON::to_json(\%temp);
  };
  status $status;
  return Encode::decode('utf8', $rpta);
};
# directorio de archivos estáticos
public: '/public';
# rutas
get '/' => \&home;
get '/hola' => \&demo;
get '/listar' => \&listar;
# rutas comentario
post '/comentario/crear' => \&comentario_crear;
# ruta not_found
any qr{.*} => \&not_found;
# inicio de la aplicación
dance;
