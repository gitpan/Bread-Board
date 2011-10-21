
use strict;
use warnings;



use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'A solderless way to wire up your application components',
  'AUTHOR' => 'Stevan Little <stevan@iinteractive.com>',
  'BUILD_REQUIRES' => {
    'Test::Fatal' => '0',
    'Test::Moose' => '0',
    'Test::More' => '0.88',
    'Test::Requires' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Bread-Board',
  'EXE_FILES' => [
    'bin/visualize-breadboard'
  ],
  'LICENSE' => 'perl',
  'NAME' => 'Bread::Board',
  'PREREQ_PM' => {
    'Moose' => '1.00',
    'MooseX::Clone' => '0.05',
    'MooseX::Params::Validate' => '0.14',
    'Try::Tiny' => '0'
  },
  'VERSION' => '0.25',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



