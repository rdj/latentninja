#!/usr/bin/env perl

use strict;
use warnings;

use inc::Module::Install;

name 'latentninja';

requires 'Dir::Self';
requires 'File::Spec';
requires 'Template';
requires 'YAML';

auto_install;
WriteAll;
