package Types::GitLab;
$Types::GitLab::VERSION = '0.03';
=head1 NAME

Types::GitLab - Type::Tiny types for GitLab stuff.

=head1 SYNOPSIS

  package Foo;
  
  use Types::GitLab -types;
  
  use Moo;
  use strictures 1;
  use namespace::clean;
  
  has token => (
    is  => 'ro',
    isa => GitLabToken,
  );

=head1 DESCRIPTION

L<GitLab|https://about.gitlab.com> is an open source git server.

This module provides several L<Type::Tiny> types for several of
GitLab's data types.

=cut

use Type::Library -base;
use Type::Utils -all;
use Types::Standard -types;
use Types::Common::Numeric -types;
use URI;

use strictures 1;
use namespace::clean;

=head1 TYPES

=head2 GitLabUsername

Username can contain only letters, digits, '_', '-' and '.'. It must
start with letter, digit or '_', optionally preceeded by '.'. It must
not end in '.git'.

=cut

declare 'GitLabUsername',
  as Str,
  where {
    length($_) > 0 and
    $_ !~ m{[^A-Za-z0-9_.-]} and
    $_ =~ m{^[A-Za-z_]} and
    $_ !~ m{\.git$}
  };

=head2 GitLabToken

The API token for a user.

=cut

declare 'GitLabToken',
  as Str,
  where { length($_) == 20 and $_ !~ m{[^a-zA-Z0-9]} };

=head2 GitLabAPIURI

The value must be an L<URI> object.  A coercion is available to
convert a C<Str>.

=cut

declare 'GitLabAPIURI',
    as InstanceOf[ 'URI' ];

coerce 'GitLabAPIURI',
    from Str,
    via { URI->new($_) };

=head2 GitLabProjectID

This type requires that the value by a positive integer.

=cut

declare 'GitLabProjectID',
    as PositiveInt;

1;
__END__

=head1 SEE ALSO

=over

=item *

L<Types::Git>

=back

=head1 AUTHOR

Aran Clary Deltac <bluefeet@gmail.com>

=head1 ACKNOWLEDGEMENTS

Thanks to L<ZipRecruiter|https://www.ziprecruiter.com/>
for encouraging their employees to contribute back to the open
source ecosystem.  Without their dedication to quality software
development this distribution would not exist.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

