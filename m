Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264777AbTB0Lje>; Thu, 27 Feb 2003 06:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264799AbTB0Lje>; Thu, 27 Feb 2003 06:39:34 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:28431 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S264777AbTB0LjF>; Thu, 27 Feb 2003 06:39:05 -0500
Date: Thu, 27 Feb 2003 12:49:17 +0100
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] BK-kernel-tools/shortlog update 3/5
Message-ID: <20030227114917.GA15245@merlin.emma.line.org>
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

This is patch 3 out of 5 total that adds new addresses to\nthe BK-kernel-tools/shortlog file.\nTo be applied in order.\n\nBy Vitezslav Samel and myself, Matthias Andree.
You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.33, 2003-01-18 13:46:34+01:00, matthias.andree@gmx.de
  Add more addresses dug out by Vietzslav Samel.


 shortlog |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletion(-)


diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Feb 27 12:43:49 2003
+++ b/shortlog	Thu Feb 27 12:43:49 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.65 2003/01/13 14:12:09 emma Exp $
+# $Id: lk-changelog.pl,v 0.66 2003/01/18 12:44:33 emma Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -102,6 +102,7 @@
 'alan@irongate.swansea.linux.org.uk' => 'Alan Cox',
 'alan@lxorguk.ukuu.org.uk' => 'Alan Cox',
 'alan@redhat.com' => 'Alan Cox',
+'alex@ssi.bg' => 'Alexander Atanasov',
 'alex_williamson@attbi.com' => 'Alex Williamson', # lbdb
 'alex_williamson@hp.com' => 'Alex Williamson', # google
 'alexander.riesen@synopsys.com' => 'Alexander Riesen',
@@ -175,6 +176,9 @@
 'christopher.leech@intel.com' => 'Christopher Leech',
 'cip307@cip.physik.uni-wuerzburg.de' => 'Jochen Karrer', # from shortlog
 'ckulesa@as.arizona.edu' => 'Craig Kulesa',
+'cloos@jhcloos.com' => 'James H. Cloos Jr.',
+'cminyard@mvista.com' => 'Corey Minyard',
+'cobra@compuserve.com' => 'Kevin Brosius',
 'colin@gibbs.dhs.org' => 'Colin Gibbs',
 'colpatch@us.ibm.com' => 'Matthew Dobson',
 'cort@fsmlabs.com' => 'Cort Dougan',
@@ -182,9 +186,11 @@
 'cr@sap.com' => 'Christoph Rohland',
 'cruault@724.com' => 'Charles-Edouard Ruault',
 'ctindel@cup.hp.com' => 'Chad N. Tindel',
+'cubic@miee.ru' => 'Ruslan U. Zakirov',
 'cyeoh@samba.org' => 'Christopher Yeoh',
 'da-x@gmx.net' => 'Dan Aloni',
 'daisy@teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
+'dale.farnsworth@mvista.com' => 'Dale Farnsworth',
 'dalecki@evision-ventures.com' => 'Martin Dalecki',
 'dalecki@evision.ag' => 'Martin Dalecki',
 'dan.zink@hp.com' => 'Dan Zink',
@@ -234,6 +240,7 @@
 'dmccr@us.ibm.com' => 'Dave McCracken',
 'dok@directfb.org' => 'Denis Oliver Kropp',
 'dougg@torque.net' => 'Douglas Gilbert',
+'drepper@redhat.com' => 'Ulrich Drepper',
 'driver@huey.jpl.nasa.gov' => 'Bryan B. Whitehead', # google
 'drow@false.org' => 'Daniel Jacobowitz',
 'drow@nevyn.them.org' => 'Daniel Jacobowitz',
@@ -357,6 +364,7 @@
 'jdr@farfalle.com' => 'David Ruggiero',
 'jdthood@yahoo.co.uk' => 'Thomas Hood',
 'jeb.j.cramer@intel.com' => 'Jeb J. Cramer',
+'jeff.wiedemeier@hp.com' => 'Jeff Wiedemeier',
 'jeffs@accelent.com' => 'Jeff Sutherland', # lbdb
 'jejb@mulgrave.(none)' => 'James Bottomley', # from shortlog
 'jejb@raven.il.steeleye.com' => 'James Bottomley',
@@ -378,6 +386,7 @@
 'jmorris@intercode.com.au' => 'James Morris',
 'jo-lkml@suckfuell.net' => 'Jochen Suckfuell',
 'jochen@jochen.org' => 'Jochen Hein',
+'jochen@scram.de' => 'Jochen Friedrich',
 'joe@fib011235813.fsnet.co.uk' => 'Joe Thornber',
 'joe@wavicle.org' => 'Joe Burks',
 'joergprante@netcologne.de' => 'Jörg Prante',
@@ -515,6 +524,7 @@
 'mochel@osdl.org' => 'Patrick Mochel',
 'mochel@segfault.osdl.org' => 'Patrick Mochel',
 'mostrows@speakeasy.net' => 'Michal Ostrowski',
+'mporter@cox.net' => 'Matt Porter',
 'msw@redhat.com' => 'Matt Wilson',
 'mufasa@sis.com.tw' => 'Mufasa Yang', # sent by himself
 'mulix@actcom.co.il' => 'Muli Ben-Yehuda', # sent by himself
@@ -620,6 +630,7 @@
 'rob@osinvestor.com' => 'Rob Radez',
 'robert.olsson@data.slu.se' => 'Robert Olsson',
 'rohit.seth@intel.com' => 'Rohit Seth',
+'rol@as2917.net' => 'Paul Rolland',
 'roland@redhat.com' => 'Roland McGrath',
 'roland@topspin.com' => 'Roland Dreier',
 'romieu@cogenit.fr' => 'François Romieu',
@@ -630,11 +641,13 @@
 'rth@are.twiddle.net' => 'Richard Henderson',
 'rth@dorothy.sfbay.redhat.com' => 'Richard Henderson',
 'rth@dot.sfbay.redhat.com' => 'Richard Henderson',
+'rth@kanga.twiddle.net' => 'Richard Henderson',
 'rth@splat.sfbay.redhat.com' => 'Richard Henderson',
 'rth@twiddle.net' => 'Richard Henderson',
 'rth@vsop.sfbay.redhat.com' => 'Richard Henderson',
 'rui.sousa@laposte.net' => 'Rui Sousa',
 'rusty@rustcorp.com.au' => 'Rusty Russell',
+'rvinson@mvista.com' => 'Randy Vinson',
 'rwhron@earthlink.net' => 'Randy Hron',
 'rz@linux-m68k.org' => 'Richard Zidlicky',
 'sabala@students.uiuc.edu' => 'Michal Sabala', # google
@@ -1294,6 +1307,9 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.66  2003/01/18 12:44:33  emma
+# New addresses found out by Vita.
+#
 # Revision 0.65  2003/01/13 14:12:09  emma
 # New addresses dug out by Vita.
 #

===================================================================


This BitKeeper patch contains the following changesets:
1.33

# User:	matthias.andree
# Host:	gmx.de
# Root:	/suse/kernel/BK/BK-kernel-tools

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
matthias.andree@gmx.de|ChangeSet|20030113141433|45221
D 1.33 03/01/18 13:46:34+01:00 matthias.andree@gmx.de +1 -0
B torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
C
c Add more addresses dug out by Vietzslav Samel.
K 45233
P ChangeSet
------------------------------------------------

0a0
> torvalds@home.transmeta.com|shortlog|20020518074718|31795|fe9afc709a0edabd matthias.andree@gmx.de|shortlog|20030118124633|54880

== shortlog ==
torvalds@home.transmeta.com|shortlog|20020518074718|31795|fe9afc709a0edabd
matthias.andree@gmx.de|shortlog|20030113141432|02884
D 1.13 03/01/18 13:46:33+01:00 matthias.andree@gmx.de +17 -1
B torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
C
c Add more addresses dug out by Vietzslav Samel.
K 54880
O -rwxrwxr-x
P shortlog
------------------------------------------------

D11 1
I11 1
# $Id: lk-changelog.pl,v 0.66 2003/01/18 12:44:33 emma Exp $
I104 1
'alex@ssi.bg' => 'Alexander Atanasov',
I177 3
'cloos@jhcloos.com' => 'James H. Cloos Jr.',
'cminyard@mvista.com' => 'Corey Minyard',
'cobra@compuserve.com' => 'Kevin Brosius',
I184 1
'cubic@miee.ru' => 'Ruslan U. Zakirov',
I187 1
'dale.farnsworth@mvista.com' => 'Dale Farnsworth',
I236 1
'drepper@redhat.com' => 'Ulrich Drepper',
I359 1
'jeff.wiedemeier@hp.com' => 'Jeff Wiedemeier',
I380 1
'jochen@scram.de' => 'Jochen Friedrich',
I517 1
'mporter@cox.net' => 'Matt Porter',
I622 1
'rol@as2917.net' => 'Paul Rolland',
I632 1
'rth@kanga.twiddle.net' => 'Richard Henderson',
I637 1
'rvinson@mvista.com' => 'Randy Vinson',
I1296 3
# Revision 0.66  2003/01/18 12:44:33  emma
# New addresses found out by Vita.
#

# Patch checksum=18ff1955
