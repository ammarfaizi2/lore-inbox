Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbULPKSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbULPKSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 05:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbULPKSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 05:18:40 -0500
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:28137 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261328AbULPKSc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 05:18:32 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu,_16_Dec_2004_10_18_24_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041216101824.8C145778CE@merlin.emma.line.org>
Date: Thu, 16 Dec 2004 11:18:24 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.252, 2004-12-16 07:22:19+01:00, samel@mail.cz
  shortlog: 11 new addresses

ChangeSet@1.251, 2004-12-08 08:39:15+01:00, samel@mail.cz
  shortlog: added 4 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

##### GNUPATCH #####
--- 1.222/shortlog	2004-12-02 12:10:21 +01:00
+++ 1.224/shortlog	2004-12-16 07:22:04 +01:00
@@ -547,6 +547,7 @@
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clameter:sgi.com' => 'Christoph Lameter',
+'clear.zhang:uli.com.tw' => 'Clear Zhang',
 'clemens-dated-1061728015.bf63:endorphin.org' => 'Fruhwirth Clemens',
 'clemens:endorphin.org' => 'Fruhwirth Clemens',
 'clemens:ladisch.de' => 'Clemens Ladisch',
@@ -593,6 +594,7 @@
 'cw:f00f.org' => 'Chris Wedgwood',
 'cw:sgi.com' => 'Chris Wedgwood',
 'cweidema:indiana.edu' => 'Christoph Weidemann',
+'cwernham:airspan.com' => 'Colin P. Wernham',
 'cwf:sgi.com' => 'Charles Fumuso',
 'cyeoh:samba.org' => 'Christopher Yeoh',
 'd.mueller:elsoft.ch' => 'David Müller',
@@ -806,11 +808,13 @@
 'engebret:brule.rchland.ibm.com' => 'David Engebretsen',
 'engebret:us.ibm.com' => 'David Engebretsen',
 'engel:us.ibm.com' => 'John Engel',
+'eradicator:gentoo.org' => 'Jeremy Huddleston',
 'eranian:frankl.hpl.hp.com' => 'Stéphane Eranian',
 'eranian:hpl.hp.co' => 'Stéphane Eranian', # typo
 'eranian:hpl.hp.com' => 'Stéphane Eranian',
 'erbenson:alaska.net' => 'Ethan Benson',
 'eric.lemoine:gmail.com' => 'Eric Lemoine',
+'eric.moore:lsil.com' => 'Eric Moore',
 'eric.piel:bull.net' => 'Eric Piel',
 'eric.valette:free.fr' => 'Eric Valette',
 'eric:lammerts.org' => 'Eric Lammerts',
@@ -829,6 +833,7 @@
 'eugene.teo:eugeneteo.net' => 'Eugene Teo',
 'eugeneteo:eugeneteo.net' => 'Eugene Teo',
 'evan.felix:pnl.gov' => 'Evan Felix',
+'evil:g-house.de' => 'Christian Kujau',
 'extreme:zayanionline.com' => 'Vineet Mehta',
 'eyal:eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'f.duncan.m.haldane:worldnet.att.net' => 'Duncan Haldane',
@@ -885,6 +890,7 @@
 'g.liakhovetski:gmx.de' => 'Guennadi Liakhovetski',
 'gaa:ulticom.com' => 'Gary Algier', # google
 'galak:blarg.somerset.sps.mot.com' => 'Kumar Gala',
+'galak:linen.sps.mot.com' => 'Kumar Gala',
 'galak:somerset.sps.mot.com' => 'Kumar Gala',
 'gamal:alternex.com.br' => 'Haroldo Gamal',
 'ganadist:nakyup.mizi.com' => 'Cha Young-Ho',
@@ -1262,6 +1268,7 @@
 'jrsantos:austin.ibm.com' => 'Jose R. Santos',
 'js189202:zodiac.mimuw.edu.pl' => 'Jerzy Szczepkowski',
 'js:convergence.de' => 'Johannes Stezenbach',
+'js:linuxtv.org' => 'Johannes Stezenbach',
 'jschopp:austin.ibm.com' => 'Joel Schopp',
 'jscross:veritas.com' => 'James Cross',
 'jsiemes:web.de' => 'Josef Siemes',
@@ -1288,6 +1295,7 @@
 'junkio:cox.net' => 'Junio C. Hamano',
 'junx.yao:intel.com' => 'Yao Jun',
 'jurgen:botz.org' => 'Jürgen Botz',
+'jurij:woodyd.org' => 'Jurij Smakov',
 'jwboyer:charter.net' => 'Josh Boyer',
 'jwboyer:infradead.org' => 'Josh Boyer',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
@@ -1339,6 +1347,7 @@
 'kenn:linux.ie' => 'Kenn Humborg',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel-hacker:bennee.com' => 'Alex Bennee',
+'kernel-stuff:comcast.net' => 'Parag Warudkar',
 'kernel:axion.demon.nl' => 'Monchi Abbad',
 'kernel:cornelia-huck.de' => 'Cornelia Huck',
 'kernel:jsl.com' => 'Jeffrey S. Laing',
@@ -1480,6 +1489,7 @@
 'lists:wildgooses.com' => 'Ed Wildgoose',
 'livio:ime.usp.br' => 'Livio Baldini Soares',
 'liyang:nerv.cx' => 'Liyang Hu',
+'lklm:lengard.net' => 'Pascal Lengard',
 'lkml001:vrfy.org' => 'Kay Sievers',
 'lkml:felipe-alfaro.com' => 'Felipe Alfaro Solana',
 'lkml:lievin.net' => 'Romain Liévin',
@@ -1757,6 +1767,7 @@
 'nathans:bruce.melbourne.sgi.com' => 'Nathan Scott',
 'nathans:sgi.com' => 'Nathan Scott',
 'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
+'nboullis:debian.org' => 'Nicolas Boullis',
 'nbryant:optonline.net' => 'Nathan Bryant',
 'ncunningham:linuxmail.org' => 'Nigel Cunningham',
 'ncunningham:users.sourceforge.net' => 'Nigel Cunningham',
@@ -1939,6 +1950,7 @@
 'pg:futureware.at' => 'Philipp Gühring',
 'phelps:dstc.edu.au' => 'Ted Phelps',
 'phil.el:wanadoo.fr' => 'Philippe Elie',
+'phil:fifi.org' => 'Philippe Troin',
 'phil:ipom.com' => 'Phil Dibowitz',
 'philipc:snapgear.com' => 'Philip Craig',
 'philipp:void.at' => 'Philipp Friedrich',
@@ -1948,6 +1960,7 @@
 'piggin:cyberone.com.au' => 'Nick Piggin',
 'piggy:timesys.com' => 'La Monte H.P. Yarroll',
 'pilo.c:wanadoo.fr' => 'Pilo Chambert',
+'pisa:cmp.felk.cvut.cz' => 'Pavel Pisa',
 'pixi:burble.org' => 'Maurice S. Barnum',
 'pj:sgi.com' => 'Paul Jackson',
 'pjones:redhat.com' => 'Peter Jones',
@@ -2195,6 +2208,8 @@
 'sfeldma:pobox.com' => 'Scott Feldman',
 'sfr:au1.ibm.com' => 'Stephen Rothwell',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
+'sfrench:sambaltcdom.austin.ibm.com' => 'Steve French',
+'sfrench:smft41.(none)' => 'Steve French',
 'sfrench:us.ibm.com' => 'Steve French',
 'sfrost:snowman.net' => 'Stephen Frost',
 'shaggy:austin.ibm.com' => 'Dave Kleikamp',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAPBgwUECA9VWXW/bNhR9Dn8FgT54Q2uZ1IclEXCRJf3K0m5GsqLA3mjp2mJMkQZJ2Ung
Hz9KiuM4Sx66pRhmG4JFniPdc889sl/hs3fsyGmz5rK0xytQi0aowBmubA2OB4Wut6cVVwu4
BLcNCQn9m4YRGSf5NszHSbKFEJKkiCmfpVkKRYhe4a8WDDuquXOV4DbgqjQAfv2Tto4dLerr
oGxPL7T2p6M1N6OZcEuAFZjRyflwCUaBHDqtpUUeN+WuqPAajGVHNIjuV9zNCtjRxfuPXz//
coHQZILvS8WTCXphWY/kHPcyDi8TU38hSqk/bAkZ0xy9wzQIE4pJPKLhiGSYZCzKGU1eE8oI
wZbXII9rLmRQ3OLXFA8JOsEvXPopKrCttHFSLxjmZQkljrGCTfvdgLVg0TkeJ2Eeoem+iWj4
nS+ECCfo7b78StfwqPZdHX3pCc1IGqc020Y0zZPtHHI+L1KScwIln5WH/Tkgt7325ChLsm2Y
0ihE6BD8N2dadE6TbS+0dya8c4aOMUlZGDKa/3fOUPqUKRn9X5lCx2QchiTeEprnYRfLHeIg
lf+6jOcS+XhIdoGkvpNJb3sYHQYyY0n2tO3xD7P9uRj2s/w7HprNdfsZXnv7d5r+gftnWUQx
RQNYC8kWw0o3FnybBnjyFg9OKyOsE1zh8+aKN4M36IxGcYe/ewpb18znzIssuHWBAtcTp9zw
Bf7GTVMuuel4aZK3PDXTjZTCshJm/sKBNoue8psotOQWn/T7HSfv77WqfG1zMRd79NQvidUK
8B9GC+XB6HseBb3L8eNwk/iZcP+4dD+R6S4XL2hwEneNLyRwE9y2NbJGirbiwG3ufG738J/t
Xtv3JE86xsZ7XPGacWHsynvlKXd4LYXC0wB/6xEtKfNhaefI8FIU3LeKLUD5H+m9Z7+CgfoG
f2rKUoJ1WnU0GvU0UQS11gaYtG3bd7d67zfwl3ajQ2fdTRZc8iXzNYAK7Mp6otszzpvai/no
Id0MheNOzJVt8c21Wz8oSHvFCiy+dHALasaLqqfk3dhdNUZcsY3W5U35gNSu4suaL/W6Q8dZ
3KLlUtZM+sHgpnwYBFtwiT/36/1QJx1+JSxnRb0K5iCXQbFuvITbHWkNEk89oCX4pyXFIRrY
uQFVVMwP54xLV5TeQN74eKpAzOq9fi9mDfhDB/b8Pa+eu5gGPymt4Ocnofd/nYoKiqVt6kmZ
kmwGkKK/AIGrA48LCgAA

