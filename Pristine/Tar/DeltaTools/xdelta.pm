package Pristine::Tar::DeltaTools::xdelta;

use Pristine::Tar;
use warnings;
use strict;

sub try_patch {
  my ($self, $fromfile, $diff, $tofile) = @_;
  return try_doit("xdelta", "patch", "--pristine", $diff, $fromfile, $tofile)
    >> 8;
}

sub do_patch {
  my $self = shift;
  die "xdelta patch failed!" if ($self->try_patch(@_) != 0);
}

sub try_diff {
  my ($self, $fromfile, $tofile, $diff) = @_;
  my $ret =
    try_doit("xdelta", "delta", "-0", "--pristine", $fromfile, $tofile, $diff)
    >> 8;
  # xdelta delta returns either 0 or 1 on success
  return ($ret == 1 || $ret == 0) ? 0 : $ret;
}

sub do_diff {
  my $self = shift;
  die "xdelta delta failed!" if ($self->try_diff(@_) != 0);
}

1;
