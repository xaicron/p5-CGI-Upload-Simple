package CGI::Upload::Simple;

use strict;
use warnings;
use utf8;
use 5.008001;
use Carp ();
use CGI::Upload ();

our $VERSION = '0.02';

sub new {
	my $class = shift;
	$class = ref $class || $class;
	my $args = shift || {query => 'CGI'};
	Carp::croak "Usage: $class->new({query => 'CGI'})" unless ref $args eq 'HASH' and $args->{query};
	bless { args => $args }, $class;
}

sub obtain {
	my $self = shift;
	my $field = shift || Carp::croak 'Usage: $upload->obtain($field)';
	
	CGI::Upload::Simple::File->new({
		args => $self->{args},
		field => $field,
	});
}

package CGI::Upload::Simple::File;

sub new {
	my $class = shift;
	$class = ref $class || $class;
	my $args = shift;
	
	bless {
		upload => CGI::Upload->new($args->{args}),
		field  => $args->{field},
	}, $class;
}

sub field {
	my $self = shift;
	$self->{field};
}

sub file_size {
	my $self = shift;
	
	unless (defined $self->{_CACHE}{file_size}) {
		$self->{_CACHE}{file_size} = -s $self->file_handle;
	}
	
	return $self->{_CACHE}{file_size};
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

CGI::Upload::Simple - CGI::Upload wrapper

=head1 SYNOPSIS

  use CGI::Upload::Simple;
  
  my $upload = CGI::Upload::Simple->new;
  my $up_file = $upload->obtain($up_file_field);
  
  $up_file->field;
  $up_file->file_size;

=head1 DESCRIPTION

CGI::Upload::Simple is CGI:: Upload to more easily

=head1 METHOD

=over

=item new(\%args)

  my $upload = CGI::Upload::Simple->new;
  my $upload = CGI::Upload::Simple->new({query => $q});

=item obtain($field)

  my $file = $upload->obtain('field'); # $file is CGI::Upload::Simple::File object

=back

=head1 AUTHOR

Yuji Shimada E<lt>xaicron {at} gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
