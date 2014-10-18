use ExtUtils::MakeMaker;

WriteMakefile(
    NAME         => 'Pjsua',
    VERSION_FROM => 'Pjsua.pm',
    LIBS         => ['-lpjsua'],
    DEFINE       => '',
    INC          => '',
);
