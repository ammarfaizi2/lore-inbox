Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUHJMYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUHJMYt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 08:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUHJMYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 08:24:49 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:3989 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264648AbUHJMYP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 08:24:15 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue,_10_Aug_2004_12_24_15_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040810122415.BDF22C66EA@merlin.emma.line.org>
Date: Tue, 10 Aug 2004 14:24:15 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.209, 2004-08-10 14:23:03+02:00, matthias.andree@gmx.de
  Minor corrections suggested by vita.

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

##### GNUPATCH #####
--- 1.181/shortlog	2004-08-10 04:52:19 +02:00
+++ 1.182/shortlog	2004-08-10 14:23:03 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.316 2004/08/04 09:00:07 emma Exp $
+# $Id: lk-changelog.pl,v 0.318 2004/08/10 12:19:52 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -721,7 +721,7 @@
 'fb.arm:net.rmk.(none)' => 'Frank Becker',
 'fbecker:com.rmk.(none)' => 'Frank Becker',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
-'fbl:netbank.com.br' => 'Flavio B. Leitner',
+'fbl:netbank.com.br' => 'Flávio Bruno Leitner',
 'fcusack:fcusack.com' => 'Frank Cusack',
 'fdavis:si.rr.com' => 'Frank Davis',
 'felipe_alfaro:linuxmail.org' => 'Felipe Alfaro Solana',
@@ -1430,7 +1430,7 @@
 'miles:mctpc71.ucom.lsi.nec.co.jp' => 'Miles Bader',
 'miles:megapathdsl.net' => 'Miles Lane',
 'milli:acmeps.com' => 'Michael Milligan',
-'miltonm:bga.com' => 'Milton Miller', # by Kristian Peters
+'miltonm:bga.com' => 'Milton D. Miller II',
 'miltonm:realtime.net' => 'Milton D. Miller II',
 'mingo:earth2.(none)' => 'Ingo Molnar',
 'mingo:elte.hu' => 'Ingo Molnar',
@@ -1709,7 +1709,7 @@
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
 'ralphs:org.rmk.(none)' => 'Ralph Siemsen',
-'ramon.rey:hispalinux.es' => 'Ramn Rey Vicente',
+'ramon.rey:hispalinux.es' => 'Ramón Rey Vicente',
 'ramune:net-ronin.org' => 'Daniel A. Nobuto',
 'randolph:tausq.org' => 'Randolph Chung',
 'randy.dunlap:verizon.net' => 'Randy Dunlap',
@@ -2115,7 +2115,7 @@
 'vince:kyllikki.org' => 'Vincent Sanders',
 'vinsci:floss.(none)' => 'Leonard Norrgard',
 'viro:math.psu.edu' => 'Alexander Viro',
-'viro:parcelfarce.linux.org.uk' => 'Al Viro',
+'viro:parcelfarce.linux.org.uk' => 'Alexander Viro',
 'viro:parcelfarce.linux.theplanet.co.uk' => 'Alexander Viro',
 'viro:www.linux.org.uk' => 'Alexander Viro',
 'vmlinuz386:yahoo.com.ar' => 'Gerardo Exequiel Pozzi', # lbdb



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAG++GEECA8WUXWvbMBSGr6NfcaCFXKxRJDmOPyClH+m20JaVjPZecU4TE1sKkpIl4D+7
37A/MNnuB+3oRbfCbKGDhPTwntcvPoDJOO04bbaymNuTNarFJlfUGalsiU7STJfV+VKqBX5H
VwnGhH+5CNgwTCqRDMOwQoFhmA24nEVxhJkgB3Br0aSdUjq3zKWlUs0Not//qq1LO4tyR+f1
cqq1X/btxmJ/hUZh0T+79KPXLnpO68ISf/BGumwJWzQ27XAaPO24/RrTzvTiy+3V6ZSQ0Qie
tMJoRD64r2fcOksiRrWdF1SbxUvQgMXc40LBk4rxQAgyBk4FS4AN+izucwZ8kIogZcEnJlLG
4JVPJ60/8IlDj5Ez+OAuzkkG17nSBjJtDGYu18qC3SwWaB3OYbaHbe7Z5BK4YENy8+wp6b3z
IYRJRo6fW1jqEl/pt0ttXKEXrfyQxywaRDyuAh4lYXWPibzPIpZIhnM5m79h1gtK8wW48DYE
VcDieNgk4/HEi2D8s563Q/GHoodM1IrCJhM8Fu/ORAi98L9mojX0G/TMj109ejufkMde/yIg
Y86Bk0kzH8DhZJ5CseplTQOeSNfF0RYYDXgMtZGPbomUJ2koAMtSwsVuDYdkHIlBjWpL935W
pArdTKpV7QmdmS6MjqH7ufi5zTWcmY3ScIW5U2i6R17HIAgaJW3tlnnhtCrT2aLxtL183WzC
mHq7igINTCbN3YiL5m5bu0aWWlGD+3SZ27UscrXZUbQtYyrLXwqmuIe7PEPlsCYI7hv0hIfa
3eZGp2tpMizu65m2DB8sulm1nNMCdz4dXsSdP+whT7/FbInZym7KUZzNwngYZ+Q3SqWlHugF
AAA=

