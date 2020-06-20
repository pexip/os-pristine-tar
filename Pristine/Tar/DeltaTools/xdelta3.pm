package Pristine::Tar::DeltaTools::xdelta3;

use Pristine::Tar;
use warnings;
use strict;

sub try_patch {
  my ($self, $fromfile, $diff, $tofile) = @_;
  return try_doit("xdelta3", "decode", "-f", "-D", "-s",
    $fromfile, $diff, $tofile) >> 8;
}

sub do_patch {
  my $self = shift;
  die "xdelta3 decode failed!" if ($self->try_patch(@_) != 0);
}

sub try_diff {
  my ($self, $fromfile, $tofile, $diff) = @_;
  return try_doit("xdelta3", "encode", "-0", "-f", "-D", "-s",
    $fromfile, $tofile, $diff) >> 8;
}

sub do_diff {
  my $self = shift;
  die "xdelta3 encode failed!" if ($self->try_diff(@_) != 0);
}

1;
