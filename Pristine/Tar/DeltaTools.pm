#!/usr/bin/perl
# Wrappers around delta computing programs
# the following naming is used:
#  - try_* : tries to run the command
#            and returns the return code
#  - do_*  : runs the command and fails if it failed

package Pristine::Tar::DeltaTools;

use Pristine::Tar;
use warnings;
use strict;

use Exporter q{import};
our @EXPORT = qw(get_delta_tool get_delta_tool_by_version get_version_from_tool);

my $DEFAULT_TOOL = $ENV{PRISTINE_ALL_XDELTA} || "xdelta3";

sub get_delta_tool {
  my $tool = shift;
  $tool ||= $DEFAULT_TOOL;

  eval "require Pristine::Tar::DeltaTools::$tool";
  die $@ if $@;
  return bless {}, "Pristine::Tar::DeltaTools::$tool";
}

sub get_delta_tool_by_version {
  my ($version, %mapping) = @_;
  my $tool = $mapping{$version};
  if (defined $tool) {
    return get_delta_tool($tool)
  } else {
    die "Unknown format: $version!";
  }
}

sub get_version_from_tool {
  my ($tool, %mapping) = @_;
  $tool ||= $DEFAULT_TOOL;
  my $version = $mapping{$tool};
  if (! defined $version) {
    die "Unknown delta tool: $tool!";
  }
  return $version;
}

1;
