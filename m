Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVCIJjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVCIJjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 04:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVCIJjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 04:39:36 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:49568 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262196AbVCIJjM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 04:39:12 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
CC: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed,_09_Mar_2005_09_39_06_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050309093906.1A5FB77D06@merlin.emma.line.org>
Date: Wed,  9 Mar 2005 10:39:06 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.281, 2005-03-09 07:35:11+01:00, samel@mail.cz
  shortlog: add 23 new names

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+)

##### GNUPATCH #####
--- 1.245/shortlog	2005-03-07 13:47:06 +01:00
+++ 1.246/shortlog	2005-03-09 07:34:55 +01:00
@@ -144,6 +144,7 @@
 '[alex.williamson:hp.com' => 'Alex Williamson', # typo
 '_nessuno_:katamail.com' => 'Davide Andrian',
 'a.kasparas:gmc.lt' => 'Aidas Kasparas',
+'a.llano:usyscom.com' => 'Asier Llano Palacios',
 'a.othieno:bluewin.ch' => 'Arthur Othieno',
 'a.othieno:ch.rmk.(none)' => 'Arthur Othieno',
 'a.pugachev:pcs-net.net' => 'Anatoly Pugachev',
@@ -287,11 +288,13 @@
 'ananth:in.ibm.com' => 'Ananth N. Mavinakayanahalli',
 'andersen:codepoet.org' => 'Erik Andersen',
 'andersg:0x63.nu' => 'Anders Gustafsson',
+'andi:cosy.sbg.ac.at' => 'Andreas Maier',
 'andikies:t-online.de' => 'Andreas Kies',
 'andmike:us.ibm.com' => 'Mike Anderson', # lbdb
 'andre.breiler:null-mx.org' => 'André Breiler',
 'andre.landwehr:gmx.net' => 'Andre Landwehr',
 'andre:linux-ide.org' => 'Andre Hedrick',
+'andrea:cpushare.com' => 'Andrea Arcangeli',
 'andrea:novell.com' => 'Andrea Arcangeli',
 'andrea:suse.de' => 'Andrea Arcangeli',
 'andreas:fjortis.info' => 'Andreas Henriksson',
@@ -476,9 +479,11 @@
 'breuerr:mc.net' => 'Bob Breuer',
 'brewt-linux-kernel:brewt.org' => 'Adrian Yee',
 'brian.haley:hp.com' => 'Brian Haley',
+'brian:murphy.dk' => 'Brian Murphy',
 'brian:rentec.com' => 'Brian Childs',
 'brihall:pcisys.net' => 'Brian Hall', # google
 'brill:fs.math.uni-frankfurt.de' => 'Björn Brill',
+'brix:gentoo.org' => 'Henrik Brix Andersen',
 'brking:us.ibm.com' => 'Brian King',
 'brm:murphy.dk' => 'Brian Murphy',
 'brownfld:irridia.com' => 'Ken Brownfield',
@@ -700,6 +705,7 @@
 'davmac:ozonline.com.au' => 'Davin McCall',
 'dax:gurulabs.com' => 'Dax Kelson',
 'dbrownell:users.sourceforge.net' => 'David Brownell',
+'dcbw:redhat.com' => 'Dan Williams',
 'dcn:sgi.com' => 'Dean Nelson',
 'ddstreet:ieee.org' => 'Dan Streetman',
 'ddstreet:us.ibm.com' => 'Dan Streetman',
@@ -721,6 +727,7 @@
 'devenyga:mcmaster.ca' => 'Gabriel Devenyi',
 'devik:cdi.cz' => 'Martin Devera',
 'dfages:arkoon.net' => 'Daniel Fages',
+'dfarnsworth:mvista.com' => 'Dale Farnsworth',
 'dfries:mail.win.org' => 'David Fries',
 'dgibson:samba.org' => 'David Gibson',
 'dhinds:sonic.net' => 'David Hinds', # google
@@ -728,6 +735,7 @@
 'dhowells:cambridge.redhat.com' => 'David Howells',
 'dhowells:redhat.com' => 'David Howells',
 'dhylands:com.rmk.(none)' => 'Dave Hylands',
+'didickman:yahoo.com' => 'Daniel Dickman',
 'diegocg:teleline.es' => 'Diego Calleja García',
 'dignome:gmail.com' => 'Lonnie Mendez',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
@@ -1113,6 +1121,7 @@
 'hverhagen:dse.nl' => 'Harm Verhagen',
 'hvr:gnu.org' => 'Herbert V. Riedel',
 'hwahl:hwahl.de' => 'Hartmut Wahl',
+'hwelte:hmw-consulting.de' => 'Harald Welte',
 'hzhong:cisco.com' => 'Hua Zhong',
 'i.palsenberg:jdirmedia.nl' => 'Igmar Palsenberg', # lbdb
 'i:stingr.net' => 'Paul P. Komkoff Jr.',
@@ -1198,6 +1207,7 @@
 'jbm:joshisanerd.com' => 'Josh Myer',
 'jbourne:hardrock.org' => 'James Bourne',
 'jcdutton:users.sourceforge.net' => 'James Courtier-Dutton',
+'jchapman:katalix.com' => 'James Chapman',
 'jd:rightthere.net' => 'Jason Davis',
 'jdavid:farfalle.com' => 'David Ruggiero',
 'jdewand:redhat.com' => 'Julie DeWandel',
@@ -1433,6 +1443,7 @@
 'keith:tungstengraphics.com' => 'Keith Whitwell',
 'keithu:parl.clemson.edu' => 'Keith Underwood',
 'keithw:tungstengraphics.com' => 'Keith Withwell',
+'ken:mvista.com' => 'Kenneth Sumrall',
 'kenn:linux.ie' => 'Kenn Humborg',
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel-hacker:bennee.com' => 'Alex Bennee',
@@ -1461,6 +1472,7 @@
 'khawar.chaudhry:amd.com' => 'Khawar Chaudhry',
 'khc:pc.waw.pl' => 'Krzysztof Halasa',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
+'kianusch:sk-tech.net' => 'Kianusch Sayah Karadji',
 'kieran:mgpenguin.net' => 'Kieran Morrissey',
 'kihara.seiji:lab.ntt.co.jp' => 'Seiji Kihara',
 'kilgota:banach.math.auburn.edu' => 'Theodore Kilgore',
@@ -1559,6 +1571,7 @@
 'liam.girdwood:com.rmk.(none)' => 'Liam Girdwood',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
 'libor:topspin.com' => 'Libor Michalek',
+'liml:rtr.ca' => 'Mark Lord',
 'linas:austin.ibm.com' => 'Linas Vepstas',
 'linas:linas.org' => 'Linas Vepstas',
 'linas:us.ibm.com' => 'Linas Vepstas',
@@ -1722,6 +1735,7 @@
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
 'matthias.christian:tiscali.de' => 'Matthias-Christian Ott',
+'matthias.kunze:gmx-topmail.de' => 'Matthias Kunze',
 'matthias:net.rmk.(none)' => 'Matthias Burghardt',
 'mauelshagen:redhat.com' => 'Heinz J. Mauelshagen',
 'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
@@ -1736,6 +1750,7 @@
 'mbp:samba.org' => 'Martin Pool', # lbdb
 'mbp:sourcefrog.net' => 'Martin Pool',
 'mbp:vexed.ozlabs.hp.com' => 'Martin Pool',
+'mbrancaleoni:tiscali.it' => 'Matteo Brancaleoni',
 'mbroemme:plusserver.de' => 'Maik Broemme',
 'mbuesch:freenet.de' => 'Michael Buesch',
 'mcgrof:ruslug.rutgers.edu' => 'Luis R. Rodriguez',
@@ -1895,6 +1910,7 @@
 'naveenb:cisco.com' => 'Naveen Burmi', # lbdb
 'nboullis:debian.org' => 'Nicolas Boullis',
 'nbryant:optonline.net' => 'Nathan Bryant',
+'ncunningham:cyclades.com' => 'Nigel Cunningham',
 'ncunningham:linuxmail.org' => 'Nigel Cunningham',
 'ncunningham:users.sourceforge.net' => 'Nigel Cunningham',
 'neal:bakerst.org' => 'Neal Stephenson',
@@ -2061,6 +2077,7 @@
 'peter:christensen' => 'Peter Christensen',
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
 'peter:developers.dk' => 'Peter Christensen',
+'peter:p12n.org' => 'Peter Samuelson',
 'peter:pantasys.com' => 'Peter Buckingham',
 'peter:programming.kicks-ass.net' => 'Peter Zijlstra',
 'peter_pregler:email.com' => 'Peter Pregler',
@@ -2157,6 +2174,7 @@
 'r.e.wolff:harddisk-recovery.nl' => 'Rogier Wolff',
 'r.marek:sh.cvut.cz' => 'Rudolf Marek',
 'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
+'radford:golemgroup.com' => 'Jim Radford',
 'radford:indigita.com' => 'Jim Radford',
 'rafael.espindola:gmail.com' => 'Rafael Ávila de Espíndola',
 'raghavendra.koushik:s2io.com' => 'Raghavendra Koushik',
@@ -2198,6 +2216,7 @@
 'rene.herman:keyaccess.nl' => 'Rene Herman', # lbdb
 'rene.herman:nl.rmk.(none)' => 'Rene Herman',
 'rene.rebe:gmx.net' => 'Rene Rebe',
+'rene.scharfe:lsrfire.ath.cx' => 'Rene Scharfe',
 'rgcrettol:datacomm.ch' => 'Roger Crettol',
 'rgooch:atnf.csiro.au' => 'Richard Gooch',
 'rgooch:ras.ucalgary.ca' => 'Richard Gooch',
@@ -2339,6 +2358,7 @@
 'scholnik:radar.nrl.navy.mil' => 'Dan Scholnik',
 'schwab:suse.de' => 'Andreas Schwab',
 'schwidefsky:de.ibm.com' => 'Martin Schwidefsky',
+'scjody:modernduck.com' => 'Jody McIntyre',
 'scole:zianet.com' => 'Steven Cole', # lk, Alan Cox 20030904
 'scott.bailey:eds.com' => 'Scott Bailey',
 'scott.feldman:intel.com' => 'Scott Feldman',
@@ -2426,6 +2446,7 @@
 'smb:smbnet.de' => 'Stefan M. Brandl',
 'smurf:osdl.org' => 'Nathan Dabney',
 'smurf:play.smurf.noris.de' => 'Matthias Urlichs',
+'smurf:smurf.noris.de' => 'Matthias Urlichs',
 'snailtalk:linux-mandrake.com' => 'Geoffrey Lee', # by himself
 'sndirsch:suse.de' => 'Stefan Dirsch',
 'sneakums:zork.net' => 'Sean Neakums',
@@ -2587,6 +2608,7 @@
 'thunder:ngforever.de' => 'Thunder From The Hill',
 'tigran:aivazian.name' => 'Tigran Aivazian',
 'tigran:veritas.com' => 'Tigran Aivazian',
+'tim.bird:am.sony.com' => 'Tim Bird',
 'tim.chick:conexant.com' => 'Tim Chick',
 'tim:cambrant.com' => 'Tim Cambrant', # lbdb
 'tim:physik3.uni-rostock.de' => 'Tim Schmielau',
@@ -2676,6 +2698,7 @@
 'vadim:cs.washington.edu' => 'Vadim Lobanov',
 'valdis.kletnieks:vt.edu' => 'Valdis Kletnieks',
 'valko:linux.karinthy.hu' => 'Laszlo Valko',
+'vandrove:cz.rmk.(none)' => 'Petr Vandrovec',
 'vandrove:vc.cvut.cz' => 'Petr Vandrovec',
 'vanl:megsinet.net' => 'Martin H. VanLeeuwen',
 'varenet:parisc-linux.org' => 'Thibaut Varene',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIADnELkICA7VW227jNhB9jr6CwD6kxdYKdbNsAl5sLm03TdIGSdN9pinaYkSRBknFduCP
75DyJe4uCrTd2oZhkedoZs4ZjvwOXV+RE6fNC5WV/bjgat4JFTtDlW25ozHT7eaypmrOH7nb
pBin8E7SDA+L8SYdD4tiw1NeFCxP6LQclZyl0Tv0ZLkhJy11rhbUxlRVhnNY/6StIyfzdhVX
/vJBa7g8s53lZw03isuzixv4DPqLgdNa2giA99SxGr1wY8lJEmf7FbdecHLy8OPPT7fnD1E0
maB9rmgyib5xXZa2XH5sqZAxez1mFzjDZZLmZT7cDLMyT6IrlMTpKEG4OMPZGR4jXJKsIEny
HicEY3R0M/Q+QQMcXaBvnPFlxJCttXFSzwmiVYXSDCm+RAqi2+gGQa7ZKLo/yBYN/uErijDF
0YdD5rVu+V/S3qXQZ10kI1zmZTLaZEk5LjYzPqYzVuIxxbyi0+pYmiOyl3mMh1kOxSbFaJgG
z3eII8v/cxrR36cR3MbgNh4Px73b+fDY7ZwUxdfdBhf+L7u/YnKv1G9oYJYr/xmswPFdPf/C
8OsEKk2iUxpLSZUmnV1bSNenfIomH9DpuRXcoFu/CQdVUia0Pf0huk5H48BTlSBM23Vsp/OY
spi6Lc/PCWrRHQV+IIzzLQHWCVt0tqaGvwkUNtC5YV4oKTwnL0eeMzWCKtJ2ZlGv46rp8Rd+
Ed2FxYCFA9pjV2TOFcybWJt5j/3ElRENAsoKQRyYPVx5TolTz6nYdEkMr2rqDvlcwd0/CykF
bUPBJTjhsTNqlF2C4DVpX4Tt7d1RJEc/7fcDK8OBJSrBmhaqWNMaMnsbRXCJrvpdz0iSpPCU
esml46RulwOmle2kE2oOs3ZbETXQbOizxwQWdJVnPbOaLnychjoqxeoQ6RffQX44LHaB8iwE
arj6opIbrhR3NXrsWogje/gwCNCA7J1lNbHNwHFWxwDckrY76JFClegGUqyeg49JMQzmSNFK
YpyJGe0pd9Q06FabKqDKNLTI/lnTdOqVE3jEwNNjEQ7crvy7LQTdeEhPzkKvtFM4dgyM0EoQ
Jyz8FLFwBxrX0Ad7SKCOxqWnKtYpBSLXtCVszSStuD1I8quArkSXe0joadxrsuAOHpKLJFWH
nrv3ayBF23FpdVA8TYpwaECXGdRM5lrydm50t3hjk2jRQ78fKFtfDVc8Bm2pmXEirZkJODvU
1TFb9bwHAKDHHhCIWR4kt+xZV2vSauh6VXWseRMKNtAdu1ZubXpOngYNLRy1GQnfsdJG2C91
fzJSsLqfBEU/Cpxo46mAsmgbQ8HrQ6DfoaYLsS1o2J/pFz8I9Asn7DU2bRN/p7Ti3++lM+iP
LYABa/8ngdWcNbZrJ5hSWo44jv4EzBPE+vYIAAA=

