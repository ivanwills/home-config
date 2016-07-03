#!/usr/bin/perl

# Created on: 2016-06-15 14:47:09
# Create by:  Ivan Wills
# $Id$
# $Revision$, $HeadURL$, $Date$
# $Revision$, $Source$, $Date$

use strict;
use warnings;
use version;
use Scalar::Util;
use List::Util;
#use List::MoreUtils;
use Getopt::Long;
use Pod::Usage;
use Data::Dumper qw/Dumper/;
use English qw/ -no_match_vars /;
use FindBin qw/$Bin/;
use Path::Tiny;
use YAML::Syck;
use File::Temp qw/tempfile/;

our $VERSION = version->new('0.0.1');
my ($name)   = $PROGRAM_NAME =~ m{^.*/(.*?)$}mxs;

my %option = (
    config  => $ENV{HOME} . '/.nw-hack.yml',
    verbose => 0,
    man     => 0,
    help    => 0,
    VERSION => 0,
);
my $config;

main();
exit 0;

sub main {
    Getopt::Long::Configure('bundling');
    GetOptions(
        \%option,
        'dev|device|d=s',
        'del',
        'host|h',
        'username|u=s',
        'config|c=s',
        'verbose|v+',
        'man',
        'help',
        'VERSION!',
    ) or pod2usage(2);

    if ( $option{'VERSION'} ) {
        print "$name Version = $VERSION\n";
        exit 1;
    }
    elsif ( $option{'man'} ) {
        pod2usage( -verbose => 2 );
    }
    elsif ( $option{'help'} ) {
        pod2usage( -verbose => 1 );
    }

    # do stuff here
    $config = eval { LoadFile($option{config}) } || {};

    if ( $option{host} ) {
        host();
        exit;
    }

    $option{dev} ||= $config->{device};

    my $type = $option{del} ? 'del' : 'add';
    for my $route (keys %{ $config->{routes} }) {
        my @cmd = ('sudo', 'route', $type, '-net', $route, 'netmask', $config->{routes}{$route}, 'dev', $option{dev} );
        warn join ' ', @cmd, "\n" if $option{verbose};
        return if $option{test};
        system @cmd;
    }

    hosts($option{del});

    return;
}

sub host {

    my $data = `ssh $option{username}\@$config->{landing} 'host $ARGV[0]'`;
    my ($server, $ip) = $data =~ /^([\w.]+) \s+ has \s+ address \s+ ([\d.]+)$/xms;

    if ( !$server || !$ip ) {
        die "Can't determine the IP address for $ARGV[0] (got $data,$server:$ip)!\n";
    }

    $config->{hosts}{$server} = $ip;

    DumpFile($option{config}, $config);

    return hosts($option{del});
}

sub hosts {
    my ($remove) = @_;
    my $file  = path(qw{ / etc hosts });
    my $hosts = $file->slurp;

    return if !$config->{hosts};

    chomp $hosts;
    $hosts .= "\n";

    for my $host (sort keys %{ $config->{hosts} }) {
        $hosts =~ s/$config->{hosts}{$host}\t$host\n//gxms;

        if ( ! $remove ) {
            $hosts .= "$config->{hosts}{$host}\t$host\n";
        }
    }

    my ($fh, $tempfile) = tempfile();
    print {$fh} $hosts;
    warn $tempfile;

    system 'sudo', 'cp', $tempfile, $file;
}

__DATA__

=head1 NAME

nw-hack.pl - A quick way for setting up temporary network routes/and host mappings

=head1 VERSION

This documentation refers to nw-hack.pl version 0.0.1

=head1 SYNOPSIS

   nw-hack.pl [(-d|--device)[=]name]
   nw-hack.pl --del  [(-d|--device)[=]name]
   nw-hack.pl --host [--username[=]user] host1 [host2 ...]

 OPTIONS:
  -d --device[=]str
                Use this device to route connections over
     --del      Remove routes and host mappings
  -h --host     Try to find the IP address of one or more hosts, these will
                then be added to the config hosts.
  -u --username[=]str
                The user to connect as for --host
  -c --config[=]file
                Use this file as the config file for nw-hack (Devault ~/.nw-hack.yml)

  -v --verbose  Show more detailed option
     --version  Prints the version information
     --help     Prints this help information
     --man      Prints the full documentation for nw-hack.pl

=head1 DESCRIPTION

=head2 CONFIG

The config file is usually stored in ~/.nw-hack.yml but you can specify
alternate files via the C<--config>. It is a YAML file where the following keys mean:

=over 4

=item hosts

Specify host/IP addresses to put/remove from the /etc/hosts file

=item routes

Specify IP/network masks to to route traffic the specified device

=item device

The network device to route traffic through (can be overridden with --device)

=item landing

The SSH server to connect to when trying to find IP addresses for hosts

=back

=head1 SUBROUTINES/METHODS

=head1 DIAGNOSTICS

=head1 CONFIGURATION AND ENVIRONMENT

=head1 DEPENDENCIES

=head1 INCOMPATIBILITIES

=head1 BUGS AND LIMITATIONS

There are no known bugs in this module.

Please report problems to Ivan Wills (ivan.wills@gmail.com).

Patches are welcome.

=head1 AUTHOR

Ivan Wills - (ivan.wills@gmail.com)

=head1 LICENSE AND COPYRIGHT

Copyright (c) 2016 Ivan Wills (14 Mullion Close, Hornsby Heights, NSW Australia 2077).
All rights reserved.

This module is free software; you can redistribute it and/or modify it under
the same terms as Perl itself. See L<perlartistic>.  This program is
distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

=cut
