package CGI::Upload::Simple;

use strict;
use warnings;
use utf8;
use 5.00801;
use Carp ();
use CGI::Upload ();

our $VERSION = '0.01';

sub new {
	my $class = shift;
	$class = ref $class || $class;
	my $cgi = shift;
	bless { cgi => $cgi }, $class;
}

sub obtain {
	my $self = shift;
	my $filed = shift;
	CGI::Upload::Simple::File->new({
		cgi   => $self->{cgi},
		field => $filed,
	});
}

package CGI::Upload::Simple::File;

sub new {
	my $class = shift;
	$class = ref $class || $class;
	my $args = shift;
	
	bless {
		upload => CGI::Upload->new($args->{cgi}),
		field  => $args->{field}
	}, $class;
}

sub mime_magic {
	my $self = shift;
	my $path = shift;
	$self->{upload}->mime_magic($path);
}

sub DESTROY {};

sub AUTOLOAD {
	my $method = our $AUTOLOAD;
	$method =~ s/.*:://o;
	
	no strict 'refs';
	*{$AUTOLOAD} = sub {
		my $self = shift;
		return $self->{upload}->$method($self->{field});
	};
	goto &$AUTOLOAD;
}

1;
__END__
=head1 NAME

CGI::Upload::Simple -

=head1 SYNOPSIS

  use CGI::Upload::Simple;

=head1 DESCRIPTION

CGI::Upload::Simple is

=head1 AUTHOR

Yuji Shimada E<lt>xaicron {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
