use strict;
use warnings;
use Test::Exception;
use Test::More tests => 4;

use CGI::Upload::Simple;

ok my $upload = CGI::Upload::Simple->new, 'new';
isa_ok $upload, 'CGI::Upload::Simple';

dies_ok { CGI::Upload::Simple->new(query => 'CGI') };
dies_ok { CGI::Upload::Simple->new({}) };
