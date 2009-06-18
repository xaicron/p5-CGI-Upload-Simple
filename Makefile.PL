use inc::Module::Install;
name 'CGI-Upload-Simple';
all_from 'lib/CGI/Upload/Simple.pm';

requires 'CGI::Upload';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
use_test_base;
auto_include;
WriteAll;
