use strict;
use warnings;
use Test::More tests => 2;

use CGI::Upload::Simple;

ok my $upload = CGI::Upload::Simple->new, 'new';
isa_ok $upload, 'CGI::Upload::Simple';
