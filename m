Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261784AbVAHBoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261784AbVAHBoH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 20:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVAHBnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 20:43:17 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:64914 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261773AbVAHBis convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 20:38:48 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Sat,_08_Jan_2005_01_38_36_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050108013836.5ABCD900DE@merlin.emma.line.org>
Date: Sat,  8 Jan 2005 02:38:36 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.259, 2005-01-07 16:09:19+01:00, samel@mail.cz
  shortlog: added 31 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+)

##### GNUPATCH #####
--- 1.228/shortlog	2005-01-05 12:56:02 +01:00
+++ 1.229/shortlog	2005-01-07 16:09:03 +01:00
@@ -292,6 +292,7 @@
 'andreas:fjortis.info' => 'Andreas Henriksson',
 'andreas:xss.co.at' => 'Andreas Haumer',
 'andrej.filipcic:ijs.si' => 'Andrej Filipcic',
+'andrew-lists:optusnet.com.au' => 'Andrew Dennison',
 'andrew.grover:intel.com' => 'Andy Grover', # "Andy" to match former entries
 'andrew.patterson:hp.com' => 'Andrew Patterson',
 'andrew.vasquez:qlogic.com' => 'Andrew Vasquez',
@@ -385,6 +386,7 @@
 'bart.de.schuymer:pandora.be' => 'Bart De Schuymer',
 'bart:samwel.tk' => 'Bart Samwel',
 'baruch:ev-en.org' => 'Baruch Even',
+'basic:mozdev.org' => 'Pang Lih Wuei',
 'bastian:waldi.eu.org' => 'Bastian Blank',
 'bbosch:iphase.com' => 'Bradley A. Bosch',
 'bbuesker:qualcomm.com' => 'Brian Buesker',
@@ -551,6 +553,7 @@
 'ciaranm:gentoo.org' => 'Ciaran McCreesh',
 'cieciwa:alpha.zarz.agh.edu.pl' => 'Wojciech Cieciwa',
 'cip307:cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
+'ckoerner:sysgo.com' => 'Christian Koerner',
 'ckulesa:as.arizona.edu' => 'Craig Kulesa',
 'clameter:sgi.com' => 'Christoph Lameter',
 'clear.zhang:uli.com.tw' => 'Clear Zhang',
@@ -580,6 +583,7 @@
 'cort:fsmlabs.com' => 'Cort Dougan',
 'cotte:de.ibm.com' => 'Carsten Otte',
 'coughlan:redhat.com' => 'Tom Coughlan',
+'coywolf:gmail.com' => 'Coywolf Qi Hunt',
 'coywolf:greatcn.org' => 'Coywolf Qi Hunt',
 'cp:absolutedigital.net' => 'Cal Peake',
 'cpg:aladdin.de' => 'Christian Groessler',
@@ -665,6 +669,7 @@
 'davidjoerg:web.de' => 'David Jörg',
 'davidm:hpl.hp.com' => 'David Mosberger',
 'davidm:napali.hpl.hp.com' => 'David Mosberger',
+'davidm:snapgear.com' => 'David McCullough',
 'davidm:tiger.hpl.hp.com' => 'David Mosberger',
 'davidm:wailua.hpl.hp.com' => 'David Mosberger',
 'davids:youknow.youwant.to' => 'David Schwartz', # google
@@ -680,6 +685,7 @@
 'debian:abeckmann.de' => 'Andreas Beckmann',
 'debian:sternwelten.at' => 'Maximilian Attems',
 'dedekind:infradead.org' => 'Artem Bityuckiy',
+'dedekind:yandex.ru' => 'Artem Bityuckiy',
 'deepfire:sic-elvis.zel.ru' => 'Samium Gromoff',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
 'delaunay:lix.polytechnique.fr' => 'Eric Delaunay',
@@ -721,9 +727,11 @@
 'dledford:redhat.com' => 'Doug Ledford',
 'dlstevens:us.ibm.com' => 'David Stevens',
 'dlsy:snoqualmie.dp.intel.com' => 'Dely Sy',
+'dmarlin:redhat.com' => 'David Marlin',
 'dmccr:us.ibm.com' => 'Dave McCracken',
 'dmilburn:redhat.com' => 'David Milburn',
 'dmo:osdl.org' => 'Dave Olien',
+'dmp:davidmpye.dyndns.org' => 'David Pye',
 'doj:cubic.org' => 'Dirk Jagdmann',
 'dok:directfb.org' => 'Denis Oliver Kropp',
 'dolbeau:irisa.fr' => 'Romain Dolbeau',
@@ -761,6 +769,7 @@
 'duncan:sun.com' => 'Duncan Laurie',
 'duwe:suse.de' => 'Torsten Duwe',
 'dvhltc:us.ibm.com' => 'Darren Hart',
+'dvrabel:arcom.co.uk' => 'David Vrabel',
 'dvrabel:arcom.com' => 'David Vrabel',
 'dvrabel:com.rmk.(none)' => 'David Vrabel',
 'dwcraig:qualcomm.com' => 'Dave Craig',
@@ -886,6 +895,7 @@
 'frankie:cse.unsw.edu.au' => 'Frank Engel',
 'franz.sirl-kernel:lauterbach.com' => 'Franz Sirl',
 'franz.sirl:lauterbach.com' => 'Franz Sirl',
+'franz_pletz:t-online.de' => 'Franz Pletz',
 'frederik.deweerdt:laposte.net' => 'Frederik Deweerdt',
 'frediano.ziglio:vodafone.com' => 'Frediano Ziglio',
 'frival:zk3.dec.com' => 'Peter Rival',
@@ -952,6 +962,7 @@
 'gone:us.ibm.com' => 'Patricia Gaughen',
 'gordon.jin:intel.com' => 'Gordon Jin',
 'gorgo:thunderchild.debian.net' => 'Madarasz Gergely',
+'gortan:tttech.com' => 'Philipp Gortan',
 'gortmaker:yahoo.com' => 'Paul Gortmaker',
 'gotom:debian.or.jp' => 'Goto Masanori', # from shortlog
 'gphat:cafes.net' => 'Cory Watson',
@@ -970,6 +981,7 @@
 'grundler:parisc-linux.org' => 'Grant Grundler', # lbdb
 'grundym:us.ibm.com' => 'Michael Grundy',
 'gsromero:alumnos.euitt.upm.es' => 'Guillermo S. Romero',
+'gtj.member:com.rmk.(none)' => 'George T. Joseph',
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gtw:cs.bu.edu' => 'Gary Wong',
 'guido.barzini:com.rmk.(none)' => 'Guido Barzini',
@@ -1035,6 +1047,7 @@
 'hno:marasystems.com' => 'Henrik Nordstrom',
 'hoho:binbash.net' => 'Colin Slater',
 'holger.smolinski:de.ibm.com' => 'Holger Smolinski',
+'holindho:cs.helsinki.fi' => 'Heikki O. Lindholm',
 'holland:loser.net' => 'Shannon Holland',
 'hollis:austin.ibm.com' => 'Hollis Blanchard',
 'hollisb:us.ibm.com' => 'Hollis Blanchard',
@@ -1119,6 +1132,7 @@
 'janitor:at.none.(rmk)' => 'Maximilian Attems',
 'janitor:at.rmk.(none)' => 'Maximilian Attems',
 'janitor:sternwelten.at' => 'Maximilian Attems',
+'jarkko.lavinen:nokia.com' => 'Jarkko Lavinen',
 'jason.d.gaston:intel.com' => 'Jason Gaston',
 'jason.davis:unisys.com' => 'Jason Davis',
 'jasonuhl:sgi.com' => 'Jason Uhlenkott',
@@ -1149,6 +1163,7 @@
 'jdow:earthlink.net' => 'Joanne Dow',
 'jdr:farfalle.com' => 'David Ruggiero',
 'jdthood:yahoo.co.uk' => 'Thomas Hood',
+'jdub:us.ibm.com' => 'Josh Boyer',
 'jean-luc.richier:imag.fr' => 'Jean-Luc Richier',
 'jeb.j.cramer:intel.com' => 'Jeb J. Cramer',
 'jef:linuxbe.org' => 'Jean-Francois Dive',
@@ -1176,6 +1191,7 @@
 'jeremy:redfishsoftware.com.au' => 'Jeremy Kerr',
 'jeremy:sgi.com' => 'Jeremy Higdon',
 'jermar:itbs.cz' => 'Jakub Jermar',
+'jerone:gmail.com' => 'Jerone Young',
 'jes:trained-monkey.org' => 'Jes Sorensen',
 'jes:wildopensource.com' => 'Jes Sorensen',
 'jesse.brandeburg:intel.com' => 'Jesse Brandeburg',
@@ -1217,6 +1233,8 @@
 'jkluebs:com.rmk.(none)' => 'John K. Luebs',
 'jkmaline:cc.hut.fi' => 'Jouni Malinen',
 'jkt:helius.com' => 'Jack Thomasson',
+'jlan:engr.sgi.com' => 'Jay Lan',
+'jlan:sgi.com' => 'Jay Lan',
 'jlcooke:certainkey.com' => 'Jean-Luc Cooke',
 'jmcmullan:linuxcare.com' => 'Jason McMullan',
 'jmm:informatik.uni-bremen.de' => 'Moritz Mühlenhoff',
@@ -1336,6 +1354,7 @@
 'kaneshige.kenji:jp.fujitsu.com' => 'Kenji Kaneshige', # lbdb
 'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
+'kaos:melbourne.sgi.com' => 'Keith Owens',
 'kaos:ocs.com.au' => 'Keith Owens',
 'kaos:sgi.com' => 'Keith Owens', # sent by himself
 'kaos:sgi.o' => 'Keith Owens',
@@ -1403,6 +1422,7 @@
 'klassert:mathematik.ru-chemnitz.de' => 'Steffen Klassert', # typo, leave in
 'klassert:mathematik.tu-chemnitz.de' => 'Steffen Klassert',
 'kmannth:us.ibm.com' => 'Keith Mannthey',
+'kmartens:sonologic.nl' => 'Koen Martens',
 'kml:patheticgeek.net' => 'Kevin Lahey',
 'kmsmith:umich.edu' => 'Kendrick M. Smith',
 'knan:mo.himolde.no' => 'Erik Inge Bolsø',
@@ -1634,6 +1654,7 @@
 'maxk:viper.(none)' => 'Maksim Krasnyanskiy', # from shortlog
 'maxk:viper.qualcomm.com' => 'Maksim Krasnyanskiy',
 'mb:ozaba.mine.nu' => 'Magnus Boden',
+'mbellon:mvista.com' => 'Mark Bellon',
 'mbligh:aracnet.com' => 'Martin J. Bligh',
 'mbp:samba.org' => 'Martin Pool', # lbdb
 'mbp:sourcefrog.net' => 'Martin Pool',
@@ -1698,6 +1719,7 @@
 'mikenc:us.ibm.com' => 'Mike Christie',
 'mikep:linuxtr.net' => 'Mike Phillips',
 'miklos:szeredi.hu' => 'Miklos Szeredi',
+'mikma:users.sourceforge.net' => 'Mikael Magnusson',
 'mikpe:csd.uu.se' => 'Mikael Pettersson',
 'mikpe:user.it.uu.se' => 'Mikael Pettersson',
 'mikulas:artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
@@ -1765,6 +1787,7 @@
 'mrr:nexthop.com' => 'Mathew Richardson',
 'mru:inprovide.com' => 'Måns Rullgård',
 'mru:kth.se' => 'Måns Rullgård',
+'msalter:redhat.com' => 'Mark Salter',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
 'mtk-lkml:gmx.net' => 'Michael Kerrisk',
@@ -1837,6 +1860,7 @@
 'nuno:itsari.org' => 'Nuno Monteiro',
 'obelix123:toughguy.net' => 'Raj',		# Hmm..
 'obi:saftware.de' => 'Andreas Oberritter',
+'obiwan:mailmij.org' => 'Danny Tholen',
 'od:suse.de' => 'Olaf Dabrunz',
 'oe:port.de' => 'Heinz-Juergen Oertel',
 'ogasawara:osdl.org' => 'Leann Ogasawara',
@@ -1929,7 +1953,9 @@
 'pekon:fi.muni.cz' => 'Petr Konecny',
 'pekon:informatics.muni.cz' => 'Petr Konecny',
 'pelle:dsv.su.se' => 'Per Olofsson',
+'pelzi:flying-snail.de' => 'Andreas Feldner',
 'penberg:cs.helsinki.fi' => 'Pekka Enberg',
+'penguin:muskoka.com' => 'Paul Gortmaker',
 'pepe:attika.ath.cx' => 'Piotr Kaczuba',
 'pepinto:student.dei.uc.pt' => 'Pedro Emanuel M. D. Pinto',
 'per.winkvist:telia.com' => 'Per Winkvist',
@@ -2045,6 +2071,7 @@
 'ramune:net-ronin.org' => 'Daniel A. Nobuto',
 'randolph:tausq.org' => 'Randolph Chung',
 'randy.dunlap:verizon.net' => 'Randy Dunlap',
+'rankincj:yahoo.com' => 'Chris Rankin',
 'ranty:debian.org' => 'Manuel Estrada Sainz',
 'ranty:ranty.pantax.net' => 'Manuel Estrada Sainz',
 'rask:sygehus.dk' => 'Rask Ingemann Lambertsen',
@@ -2068,6 +2095,7 @@
 'reeja.john:amd.com' => 'Reeja John',
 'reiser:namesys.com' => 'Hans Reiser',
 'rem:osdl.org' => 'Bob Miller',
+'remy.bruno:trinnov.com' => 'Remy Bruno',
 'rene.herman:keyaccess.nl' => 'Rene Herman', # lbdb
 'rene.herman:nl.rmk.(none)' => 'Rene Herman',
 'rene.rebe:gmx.net' => 'Rene Rebe',
@@ -2136,6 +2164,7 @@
 'rover:tob.ru' => 'Sergei Golod',
 'rpjday:mindspring.com' => 'Robert P. J. Day',
 'rpurdie:net.rmk.(none)' => 'Richard Purdie',
+'rpurdie:rpsys.net' => 'Richard Purdie',
 'rread:clusterfs.com' => 'Robert Read',
 'rsa:us.ibm.com' => 'Ryan S. Arnold',
 'rscott:attbi.com' => 'Rob Scott',
@@ -2230,6 +2259,7 @@
 'sebek64:post.cz' => 'Marcel Sebek',
 'seife:suse.de' => 'Stefan Seyfried',
 'sergio.gelato:astro.su.se' => 'Sergio Gelato',
+'serue:us.ibm.com' => 'Serge Hallyn',
 'set:pobox.com' => 'Paul Thompson',
 'seto.hidetoshi:jp.fujitsu.com' => 'Hidetoshi Seto',
 'sezero:superonline.com' => 'Özkan Sezer',
@@ -2498,6 +2528,7 @@
 'tv:lio96.de' => 'Thomas Voegtle',
 'tv:tv.debian.net' => 'Tommi Virtanen',
 'tvignaud:mandrakesoft.com' => 'Thierry Vignaud',
+'tvrtko.ursulin:sophos.com' => 'Tvrtko A. Ursulin',
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh:redhat.com' => 'Tim Waugh',
 'twogood:users.sourceforge.net' => 'David Eriksson',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAJw530ECA7VW30/cRhB+xn/FSnmgVXrGP85355WIGqAJhFS5kqRVn6o9e85ebO9au+sD
o/vjO7vLcUCaSm1T4AF7vu/mm/lmBl6QizN6YKTasLbUP/YgqoGL0CgmdAeGhYXstqc1ExV8
BLNNoijB7zhJo1mWb5N8lmVbSCDLimnMVvPFHIokeEE+a1D0oGPG1JzpkIlSAeD7c6kNPai6
27C0j1dS4uORHjQcNaAEtEcnl/gz8Q8TI2WrAwQumSlqsgGl6UEcpg9vzNgDPbj66e3n96+v
guD4mDxoJcfHwTeuS7MO2h87xtuwuHvKzqI4yuI4m6XJdjZN8jg4I3GYZDmJsqMoPormJJ7R
KKdx/jKKaRSRJx9GXsZkEgUn5BsrPg0KomupTCsrSlhZQknSmAi4sQ8KtAYdXBKrOA2W++YF
k3/4FQQRi4JXe/217OCZ+J0Qrz2LF9F8Oo8X2zSe59l2DTlbF/MoZxGUbFU+bdATsm32PM6i
PEq3+Gs+dc7vEE+M/88ygr+X4TyPEnycpTPvefKF51H6156n/5/pX7XatesDmaibW/szuUXb
d0X9C9cvknxK4uDQbfjNpOXaaCp7M2gBxqoP2XBIjl+Rw9cOQc5ACK6lOPwhuEgXc8tdMc0L
2sm7EjahVJXHL7Fo8p7X5LcBuEVnWWrRRSPtcVBUj7qSNoXHn9YKk3MmyKUHOM4icRw53sh2
TSvf+geKf01+4eR8EMYSZjMnqWQbXnZUC9ZXwNSecmYD5OfidGhbOVS14/gk2HBouCjpiM2A
21DtClcGOnLCzTgUDR8tY564UsqOqZYLqqCsmfkiiQt6+MzDe+qF9SOE5ShKoff98qTlCI4x
8wk2iq2gpUxZJwoZDs1j8K8uavGLxcLi1zh3d3/0LZg7aiZSYH5MBJ7zxgbJ0gYtJc+c8RWO
DhPUGANFvS9hWfOW9z1568IOP3ddqsx12EG3QgOtJtU14XdCCvje894CFgTkU0jeSQ29628c
pc6UWqKespa00GENreai4eGae+I58Kbh5EOIM2NBbeeocRJb6jVTTSPDFssWIKiQDWd7se9c
lLz3Uc/LPK8cVnTQIV91j+BS1+REjn7E4njuencNCst4PmLv3FvyuxxE5dBJnJME0S02Dbdd
hbrij5WMKMNK8IivBC/iNHVJGyY1xZuykgOO/NPPugRuavLhBoR2lGmUOQoOncF3FJdQ4tLz
IhTtPUOCsGNndhS8aZaCbuG0C9ptcMMe9Q2hDTlxMQef44mzcI45sGv41zrUKKyAtTU1xItw
z+MNgxYzVWLQekf2m9dp1hocjuc74XJ9dDEHX6S5hcsVv8E+2aZ3/PrxNggxkk84B/eG5qkz
tIf2jtN1O3JRTXC90avdfLsDxTR5A215fz6QlXiWu8u0G3Qjm0cdWLKhdTPescZTkmjq6sBl
wWNQXOM1qOXzM0WuXNTj565pCroxXKlBSGoUF0Ju9pwrjJETG3OM2Huv+kGVHKjq8RLum3vF
i5opvAQu6giJrwINGeCLaf4IduHOWduOXlDmXTQbZXBlBqUHe6O07Gup97RPLkxeh+SzRyD3
4d+yooai0UN3vM6zGFi+Cv4EG5XxGWgKAAA=

