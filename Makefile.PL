use warnings; use strict;

use ExtUtils::MakeMaker;
use ExtUtils::PkgConfig;

my %pjsua = ExtUtils::PkgConfig->find('libpjproject');

WriteMakefile(
    NAME         => 'Pjsua',
    VERSION_FROM => 'Pjsua.pm',
    LICENSE      => 'gpl2',
    ($] >= 5.005 ?
     (ABSTRACT_FROM  => 'Pjsua.pm',
      AUTHOR         => 'Finbar Crago <finbar.crago@gmail.com>'):()),


    LIBS         => [$pjsua{libs}],
    DEFINE       => $pjsua{cflags},
    INC          => '',
);
