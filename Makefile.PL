use inc::Module::Install;
name 'Log-Minimal-File';
all_from 'lib/Log/Minimal/File.pm';

requires 'Log::Minimal' => '0.04';
requires 'Scope::Guard' => '0.20';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
build_requires 'File::Temp';
auto_include;
WriteAll;
