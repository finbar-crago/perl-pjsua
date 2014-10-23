#!/usr/bin/env perl
use ExtUtils::testlib;
use Pjsua;

my $test = Pjsua->new({host => "192.168.2.1", user => "user", pass => "pass"});
$test->call('1234');

while(1){}
