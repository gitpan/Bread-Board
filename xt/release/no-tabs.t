use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::NoTabsTests 0.05

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Bread/Board.pm',
    'lib/Bread/Board/BlockInjection.pm',
    'lib/Bread/Board/ConstructorInjection.pm',
    'lib/Bread/Board/Container.pm',
    'lib/Bread/Board/Container/FromParameterized.pm',
    'lib/Bread/Board/Container/Parameterized.pm',
    'lib/Bread/Board/Dependency.pm',
    'lib/Bread/Board/Dumper.pm',
    'lib/Bread/Board/LifeCycle.pm',
    'lib/Bread/Board/LifeCycle/Singleton.pm',
    'lib/Bread/Board/LifeCycle/Singleton/WithParameters.pm',
    'lib/Bread/Board/Literal.pm',
    'lib/Bread/Board/Manual.pod',
    'lib/Bread/Board/Manual/Concepts.pod',
    'lib/Bread/Board/Manual/Concepts/Advanced.pod',
    'lib/Bread/Board/Manual/Concepts/Typemap.pod',
    'lib/Bread/Board/Manual/Example.pod',
    'lib/Bread/Board/Manual/Example/FormSensible.pod',
    'lib/Bread/Board/Manual/Example/LogDispatch.pod',
    'lib/Bread/Board/Service.pm',
    'lib/Bread/Board/Service/Alias.pm',
    'lib/Bread/Board/Service/Deferred.pm',
    'lib/Bread/Board/Service/Deferred/Thunk.pm',
    'lib/Bread/Board/Service/Inferred.pm',
    'lib/Bread/Board/Service/WithClass.pm',
    'lib/Bread/Board/Service/WithDependencies.pm',
    'lib/Bread/Board/Service/WithParameters.pm',
    'lib/Bread/Board/SetterInjection.pm',
    'lib/Bread/Board/Traversable.pm',
    'lib/Bread/Board/Types.pm'
);

notabs_ok($_) foreach @files;
done_testing;
