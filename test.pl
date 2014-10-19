#!/usr/bin/env perl
use ExtUtils::testlib;
use Pjsua;

Pjsua::start();
my $acc_id = Pjsua::add_account_xs("192.168.2.1", "user", "pass");
print Pjsua::call_xs($acc_id, "sip:123@192.168.2.1");
