Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTB0Lni>; Thu, 27 Feb 2003 06:43:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbTB0Ljs>; Thu, 27 Feb 2003 06:39:48 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:28687 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S264788AbTB0LjF>; Thu, 27 Feb 2003 06:39:05 -0500
Date: Thu, 27 Feb 2003 12:49:16 +0100
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] BK-kernel-tools/shortlog update 2/5
Message-ID: <20030227114916.GA15229@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@transmeta.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 2 out of 5 total that adds new addresses to\nthe BK-kernel-tools/shortlog file.\nTo be applied in order.\n\nBy Vitezslav Samel and myself, Matthias Andree.
You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.32, 2003-01-13 15:14:33+01:00, matthias.andree@gmx.de
  Another 14 addresses have been dug out by Vitezslav Samel.


 shortlog |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)


diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Feb 27 12:43:48 2003
+++ b/shortlog	Thu Feb 27 12:43:48 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.64 2003/01/08 14:48:50 emma Exp $
+# $Id: lk-changelog.pl,v 0.65 2003/01/13 14:12:09 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -149,6 +149,7 @@
 'bjorn.andersson@erc.ericsson.se' => 'Björn Andersson', # google, guessed ö
 'bjorn.wesen@axis.com' => 'Bjorn Wesen',
 'bjorn_helgaas@hp.com' => 'Bjorn Helgaas',
+'blueflux@koffein.net' => 'Oskar Andreasson',
 'bmatheny@purdue.edu' => 'Blake Matheny', # google
 'borisitk@fortunet.com' => 'Boris Itkis', # by Kristian Peters
 'braam@clusterfs.com' => 'Peter Braam',
@@ -192,6 +193,8 @@
 'danc@mvista.com' => 'Dan Cox', # some CREDITS patch found by google
 'daniel.ritz@gmx.ch' => 'Daniel Ritz',
 'dave@qix.net' => 'Dave Maietta',
+'davej@codemonkey.or' => 'Dave Jones',
+'davej@codemonkey.org.u' => 'Dave Jones',
 'davej@codemonkey.org.uk' => 'Dave Jones',
 'davej@suse.de' => 'Dave Jones',
 'davej@tetrachloride.(none)' => 'Dave Jones',
@@ -235,6 +238,7 @@
 'drow@false.org' => 'Daniel Jacobowitz',
 'drow@nevyn.them.org' => 'Daniel Jacobowitz',
 'dsaxena@mvista.com' => 'Deepak Saxena',
+'duncan.sands@math.u-psud.fr' => 'Duncan Sands',
 'dwmw2@infradead.org' => 'David Woodhouse',
 'dwmw2@redhat.com' => 'David Woodhouse',
 'dz@cs.unitn.it' => 'Massimo Dal Zotto',
@@ -258,6 +262,7 @@
 'felipewd@terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
 'fenghua.yu@intel.com' => 'Fenghua Yu', # google
 'fero@sztalker.hu' => 'Bakonyi Ferenc',
+'filip.sneppe@cronos.be' => 'Filip Sneppe',
 'fischer@linux-buechse.de' => 'Jürgen E. Fischer',
 'fletch@aracnet.com' => 'Martin J. Bligh',
 'flo@rfc822.org' => 'Florian Lohoff',
@@ -272,6 +277,7 @@
 'fw@deneb.enyo.de' => 'Florian Weimer', # lbdb
 'fzago@austin.rr.com' => 'Frank Zago', # google
 'ganadist@nakyup.mizi.com' => 'Cha Young-Ho',
+'gandalf@wlug.westbo.se' => 'Martin Josefsson',
 'ganesh@tuxtop.vxindia.veritas.com' => 'Ganesh Varadarajan',
 'ganesh@veritas.com' => 'Ganesh Varadarajan',
 'ganesh@vxindia.veritas.com' => 'Ganesh Varadarajan',
@@ -398,6 +404,7 @@
 'k-suganuma@mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak@box43.pl' => 'Karol Kasprzak', # by Kristian Peters
 'kaber@trash.net' => 'Patrick McHardy',
+'kadlec@blackhole.kfki.hu' => 'Jozsef Kadlecsik',
 'kai-germaschewski@uiowa.edu' => 'Kai Germaschewski',
 'kai.makisara@kolumbus.fi' => 'Kai Makisara',
 'kai.reichert@udo.edu' => 'Kai Reichert',
@@ -463,6 +470,7 @@
 'marcelo@conectiva.com.br' => 'Marcelo Tosatti',
 'marcelo@freak.distro.conectiva' => 'Marcelo Tosatti', # guessed
 'marcelo@plucky.distro.conectiva' => 'Marcelo Tosatti',
+'marcus@ingate.com' => 'Marcus Sundberg',
 'marekm@amelek.gda.pl' => 'Marek Michalkiewicz',
 'mark@alpha.dyndns.org' => 'Mark W. McClelland',
 'mark@hal9000.dyndns.org' => 'Mark W. McClelland',
@@ -510,6 +518,7 @@
 'msw@redhat.com' => 'Matt Wilson',
 'mufasa@sis.com.tw' => 'Mufasa Yang', # sent by himself
 'mulix@actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
+'mulix@mulix.org' => 'Muli Ben-Yehuda',
 'mw@microdata-pos.de' => 'Michael Westermann',
 'mzyngier@freesurf.fr' => 'Marc Zyngier',
 'n0ano@n0ano.com' => 'Don Dugger',
@@ -517,6 +526,7 @@
 'nathans@sgi.com' => 'Nathan Scott',
 'neilb@cse.unsw.edu.au' => 'Neil Brown',
 'nemosoft@smcc.demon.nl' => 'Nemosoft Unv.',
+'netfilter@interlinx.bc.ca' => 'Brian J. Murrell',
 'nico@cam.org' => 'Nicolas Pitre',
 'nicolas.aspert@epfl.ch' => 'Nicolas Aspert',
 'nicolas.mailhot@laposte.net' => 'Nicolas Mailhot',
@@ -541,6 +551,7 @@
 'p_gortmaker@yahoo.com' => 'Paul Gortmaker',
 'pasky@ucw.cz' => 'Petr Baudis',
 'patmans@us.ibm.com' => 'Patrick Mansfield',
+'paubert@iram.es' => 'Gabriel Paubert',
 'paul.mundt@timesys.com' => 'Paul Mundt', # google
 'paulkf@microgate.com' => 'Paul Fulghum',
 'paulus@au1.ibm.com' => 'Paul Mackerras',
@@ -609,6 +620,7 @@
 'rob@osinvestor.com' => 'Rob Radez',
 'robert.olsson@data.slu.se' => 'Robert Olsson',
 'rohit.seth@intel.com' => 'Rohit Seth',
+'roland@redhat.com' => 'Roland McGrath',
 'roland@topspin.com' => 'Roland Dreier',
 'romieu@cogenit.fr' => 'François Romieu',
 'romieu@fr.zoreil.com' => 'François Romieu',
@@ -642,7 +654,8 @@
 'scott_anderson@mvista.com' => 'Scott Anderson',
 'scottm@somanetworks.com' => 'Scott Murray',
 'sct@redhat.com' => 'Stephen C. Tweedie',
-'sds@tislabs.com' => 'Stephen Smalley',
+'sds@epoch.ncsc.mil' => 'Stephen D. Smalley',
+'sds@tislabs.com' => 'Stephen D. Smalley',
 'sebastian.droege@gmx.de' => 'Sebastian Dröge',
 'sfbest@us.ibm.com' => 'Steve Best',
 'sfr@canb.auug.org.au' => 'Stephen Rothwell',
@@ -719,6 +732,7 @@
 'uzi@uzix.org' => 'Joshua Uziel',
 'valko@linux.karinthy.hu' => 'Laszlo Valko',
 'vandrove@vc.cvut.cz' => 'Petr Vandrovec',
+'vanl@megsinet.net' => 'Martin H. VanLeeuwen',
 'varenet@parisc-linux.org' => 'Thibaut Varene',
 'vberon@mecano.gme.usherb.ca' => 'Vincent Béron',
 'venkatesh.pallipadi@intel.com' => 'Venkatesh Pallipadi',
@@ -1280,6 +1294,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.65  2003/01/13 14:12:09  emma
+# New addresses dug out by Vita.
+#
 # Revision 0.64  2003/01/08 14:48:50  emma
 # New addresses by Vita.
 #

===================================================================


This BitKeeper patch contains the following changesets:
1.32

# User:	matthias.andree
# Host:	gmx.de
# Root:	/suse/kernel/BK/BK-kernel-tools

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
matthias.andree@gmx.de|ChangeSet|20030109034005|45222
D 1.32 03/01/13 15:14:33+01:00 matthias.andree@gmx.de +1 -0
B torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
C
c Another 14 addresses have been dug out by Vitezslav Samel.
K 45221
P ChangeSet
------------------------------------------------

0a0
> torvalds@home.transmeta.com|shortlog|20020518074718|31795|fe9afc709a0edabd matthias.andree@gmx.de|shortlog|20030113141432|02884

== shortlog ==
torvalds@home.transmeta.com|shortlog|20020518074718|31795|fe9afc709a0edabd
matthias.andree@gmx.de|shortlog|20030109034004|09841
D 1.12 03/01/13 15:14:32+01:00 matthias.andree@gmx.de +19 -2
B torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
C
c Another 14 addresses have been dug out by Vitezslav Samel.
K 2884
O -rwxrwxr-x
P shortlog
------------------------------------------------

D11 1
I11 1
# $Id: lk-changelog.pl,v 0.65 2003/01/13 14:12:09 emma Exp $
I151 1
'blueflux@koffein.net' => 'Oskar Andreasson',
I194 2
'davej@codemonkey.or' => 'Dave Jones',
'davej@codemonkey.org.u' => 'Dave Jones',
I237 1
'duncan.sands@math.u-psud.fr' => 'Duncan Sands',
I260 1
'filip.sneppe@cronos.be' => 'Filip Sneppe',
I274 1
'gandalf@wlug.westbo.se' => 'Martin Josefsson',
I400 1
'kadlec@blackhole.kfki.hu' => 'Jozsef Kadlecsik',
I465 1
'marcus@ingate.com' => 'Marcus Sundberg',
I512 1
'mulix@mulix.org' => 'Muli Ben-Yehuda',
I519 1
'netfilter@interlinx.bc.ca' => 'Brian J. Murrell',
I543 1
'paubert@iram.es' => 'Gabriel Paubert',
I611 1
'roland@redhat.com' => 'Roland McGrath',
D645 1
I645 2
'sds@epoch.ncsc.mil' => 'Stephen D. Smalley',
'sds@tislabs.com' => 'Stephen D. Smalley',
I721 1
'vanl@megsinet.net' => 'Martin H. VanLeeuwen',
I1282 3
# Revision 0.65  2003/01/13 14:12:09  emma
# New addresses dug out by Vita.
#

# Patch checksum=c9c64b9c
