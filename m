Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264788AbTB0LlI>; Thu, 27 Feb 2003 06:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264811AbTB0LkK>; Thu, 27 Feb 2003 06:40:10 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:29199 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S264790AbTB0LjF>; Thu, 27 Feb 2003 06:39:05 -0500
Date: Thu, 27 Feb 2003 12:49:17 +0100
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
To: Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [BK PATCH] BK-kernel-tools/shortlog update 5/5
Message-ID: <20030227114917.GA15277@merlin.emma.line.org>
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

This is patch 5 out of 5 total that adds new addresses to\nthe BK-kernel-tools/shortlog file.\nTo be applied in order.\n\nBy Vitezslav Samel and myself, Matthias Andree.
You can import this changeset into BK by piping this whole message to:
'| bk receive [path to repository]' or apply the patch as usual.

===================================================================


ChangeSet@1.35, 2003-02-27 12:43:11+01:00, matthias.andree@gmx.de
  Another set of addresses.


 shortlog |   41 ++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 40 insertions(+), 1 deletion(-)


diff -Nru a/shortlog b/shortlog
--- a/shortlog	Thu Feb 27 12:43:49 2003
+++ b/shortlog	Thu Feb 27 12:43:49 2003
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.73 2003/02/14 10:45:45 vita Exp $
+# $Id: lk-changelog.pl,v 0.77 2003/02/27 10:52:59 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -93,6 +93,7 @@
 'aia21@cam.ac.uk' => 'Anton Altaparmakov',
 'aia21@cantab.net' => 'Anton Altaparmakov',
 'aia21@cus.cam.ac.uk' => 'Anton Altaparmakov',
+'ajoshi@kernel.crashing.org' => 'Ani Joshi',
 'ajoshi@shell.unixbox.com' => 'Ani Joshi',
 'ak@muc.de' => 'Andi Kleen',
 'ak@suse.de' => 'Andi Kleen',
@@ -113,6 +114,7 @@
 'andersg@0x63.nu' => 'Anders Gustafsson',
 'andmike@us.ibm.com' => 'Mike Anderson', # lbdb
 'andrea@suse.de' => 'Andrea Arcangeli',
+'andrew.wood@ivarch.com' => 'Andrew Wood',
 'andries.brouwer@cwi.nl' => 'Andries E. Brouwer',
 'andros@citi.umich.edu' => 'Andy Adamson',
 'angus.sawyer@dsl.pipex.com' => 'Angus Sawyer',
@@ -162,6 +164,7 @@
 'brownfld@irridia.com' => 'Ken Brownfield',
 'bunk@fs.tum.de' => 'Adrian Bunk',
 'buytenh@gnu.org' => 'Lennert Buytenhek',
+'bwa@us.ibm.com' => 'Bruce Allan',
 'bzeeb-lists@lists.zabbadoz.net' => 'Björn A. Zeeb', # lbdb
 'c-d.hailfinger.kernel.2002-07@gmx.net' => 'Carl-Daniel Hailfinger',
 'c-d.hailfinger.kernel.2002-q4@gmx.net' => 'Carl-Daniel Hailfinger', # himself
@@ -171,6 +174,8 @@
 'celso@bulma.net' => 'Celso González', # google
 'ch@hpl.hp.com' => 'Christopher Hoover', # by Kristian Peters
 'charles.white@hp.com' => 'Charles White',
+'chas@cmf.nrl.navy.mil' => 'Chas Williams',
+'chas@locutus.cmf.nrl.navy.mil' => 'Chas Williams',
 'chessman@tux.org' => 'Samuel S. Chessman',
 'chris@qwirx.com' => 'Chris Wilson',
 'chris@wirex.com' => 'Chris Wright',
@@ -180,6 +185,7 @@
 'ckulesa@as.arizona.edu' => 'Craig Kulesa',
 'cloos@jhcloos.com' => 'James H. Cloos Jr.',
 'cminyard@mvista.com' => 'Corey Minyard',
+'cniehaus@handhelds.org' => 'Carsten Niehaus',
 'cobra@compuserve.com' => 'Kevin Brosius',
 'colin@gibbs.dhs.org' => 'Colin Gibbs',
 'colpatch@us.ibm.com' => 'Matthew Dobson',
@@ -191,6 +197,8 @@
 'cubic@miee.ru' => 'Ruslan U. Zakirov',
 'cw@f00f.org' => 'Chris Wedgwood',
 'cyeoh@samba.org' => 'Christopher Yeoh',
+'d.mueller@elsoft.ch' => 'David Müller',
+'d3august@dtek.chalmers.se' => 'Björn Augustsson',
 'da-x@gmx.net' => 'Dan Aloni',
 'daisy@teetime.dynamic.austin.ibm.com' => 'Daisy Chang', # from shortlog
 'dale.farnsworth@mvista.com' => 'Dale Farnsworth',
@@ -202,6 +210,7 @@
 'danc@mvista.com' => 'Dan Cox', # some CREDITS patch found by google
 'daniel.ritz@gmx.ch' => 'Daniel Ritz',
 'dave@qix.net' => 'Dave Maietta',
+'dave@thedillows.org' => 'David Dillow',
 'davej@codemonkey.or' => 'Dave Jones',
 'davej@codemonkey.org.u' => 'Dave Jones',
 'davej@codemonkey.org.uk' => 'Dave Jones',
@@ -270,6 +279,7 @@
 'erik_habbinga@hp.com' => 'Erik Habbinga',
 'eyal@eyal.emu.id.au' => 'Eyal Lebedinsky', # lbdb
 'falk.hueffner@student.uni-tuebingen.de' => 'Falk Hueffner',
+'faikuygur@ttnet.net.tr' => 'Faik Uygur',
 'fbl@conectiva.com.br' => 'Flávio Bruno Leitner', # google
 'fdavis@si.rr.com' => 'Frank Davis',
 'felipewd@terra.com.br' => 'Felipe Damasio', # by self (did not ask to include the W.)
@@ -313,6 +323,7 @@
 'gphat@cafes.net' => 'Cory Watson',
 'greearb@candelatech.com' => 'Ben Greear',
 'green@angband.namesys.com' => 'Oleg Drokin',
+'green@linuxhacker.ru' => 'Oleg Drokin',
 'green@namesys.com' => 'Oleg Drokin',
 'greg@kroah.com' => 'Greg Kroah-Hartman',
 'gronkin@nerdvana.com' => 'George Ronkin',
@@ -348,11 +359,13 @@
 'ionut@cs.columbia.edu' => 'Ion Badulescu',
 'ioshadij@hotmail.com' => 'Ishan O. Jayawardena',
 'irohlfs@irohlfs.de' => 'Ingo Rohlfs',
+'ishikawa@linux.or.jp' => 'Ishikawa Mutsumi',
 'ivangurdiev@linuxfreemail.com' => 'Ivan Gyurdiev',
 'jack@suse.cz' => 'Jan Kara',
 'jack_hammer@adaptec.com' => 'Jack Hammer',
 'jaharkes@cs.cmu.edu' => 'Jan Harkes',
 'jakob.kemi@telia.com' => 'Jakob Kemi',
+'jakub@redhat.com' => 'Jakub Jelínek',
 'jamagallon@able.es' => 'J. A. Magallon',
 'james.bottomley@steeleye.com' => 'James Bottomley',
 'james@cobaltmountain.com' => 'James Mayer',
@@ -375,6 +388,7 @@
 'jeb.j.cramer@intel.com' => 'Jeb J. Cramer',
 'jeff.wiedemeier@hp.com' => 'Jeff Wiedemeier',
 'jeffs@accelent.com' => 'Jeff Sutherland', # lbdb
+'jejb@malley.(none)' => 'James Bottomley',
 'jejb@mulgrave.(none)' => 'James Bottomley', # from shortlog
 'jejb@raven.il.steeleye.com' => 'James Bottomley',
 'jenna.s.hall@intel.com' => 'Jenna S. Hall', # google
@@ -390,6 +404,7 @@
 'jgrimm@jgrimm.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm@touki.austin.ibm.com' => 'Jon Grimm', # google
 'jgrimm@touki.qip.austin.ibm.com' => 'Jon Grimm', # google
+'jh@sgi.com' => 'John Hesterberg',
 'jhammer@us.ibm.com' => 'Jack Hammer',
 'jkt@helius.com' => 'Jack Thomasson',
 'jmorris@intercode.com.au' => 'James Morris',
@@ -398,6 +413,7 @@
 'jochen@scram.de' => 'Jochen Friedrich',
 'joe@fib011235813.fsnet.co.uk' => 'Joe Thornber',
 'joe@wavicle.org' => 'Joe Burks',
+'joel.buckley@sun.com' => 'Joel Buckley',
 'joergprante@netcologne.de' => 'Jörg Prante',
 'johann.deneux@it.uu.se' => 'Johann Deneux',
 'johannes@erdfelt.com' => 'Johannes Erdfelt',
@@ -433,6 +449,7 @@
 'kanojsarcar@yahoo.com' => 'Kanoj Sarcar',
 'kaos@ocs.com.au' => 'Keith Owens',
 'kaos@sgi.com' => 'Keith Owens', # sent by himself
+'kare.sars@lmf.ericsson.se' => 'Kåre Särs',
 'kasperd@daimi.au.dk' => 'Kasper Dupont',
 'keithu@parl.clemson.edu' => 'Keith Underwood',
 'kenneth.w.chen@intel.com' => 'Kenneth W. Chen',
@@ -475,6 +492,7 @@
 'liyang@nerv.cx' => 'Liyang Hu',
 'lm@bitmover.com' => 'Larry McVoy',
 'lord@sgi.com' => 'Stephen Lord',
+'louis.zhuang@linux.co.intel.com' => 'Louis Zhuang',
 'lowekamp@cs.wm.edu' => 'Bruce B. Lowekamp', # lbdb
 'luben@splentec.com' => 'Luben Tuikov',
 'luc.vanoostenryck@easynet.be' => 'Luc Van Oostenryck', # lbdb
@@ -514,13 +532,16 @@
 'mdharm-usb@one-eyed-alien.net' => 'Matthew Dharm',
 'mdharm@one-eyed-alien.net' => 'Matthew Dharm',
 'mec@shout.net' => 'Michael Elizabeth Chastain',
+'meissner@suse.de' => 'Marcus Meissner',
 'mgreer@mvista.com' => 'Mark A. Greer', # lbdb
 'michaelw@foldr.org' => 'Michael Weber', # google
 'michal@harddata.com' => 'Michal Jaegermann',
 'mikal@stillhq.com' => 'Michael Still',
 'mikael.starvik@axis.com' => 'Mikael Starvik',
+'mike@aiinc.ca' => 'Michael Hayes',
 'mikep@linuxtr.net' => 'Mike Phillips',
 'mikpe@csd.uu.se' => 'Mikael Pettersson',
+'mikpe@user.it.uu.se' => 'Mikael Pettersson',
 'mikulas@artax.karlin.mff.cuni.cz' => 'Mikulas Patocka',
 'miles@lsi.nec.co.jp' => 'Miles Bader',
 'miles@megapathdsl.net' => 'Miles Lane',
@@ -529,6 +550,7 @@
 'mingo@elte.hu' => 'Ingo Molnar',
 'mingo@redhat.com' => 'Ingo Molnar',
 'mj@ucw.cz' => 'Martin Mares',
+'mk@linux-ipv6.org' => 'Mitsuru Kanda',
 'mkp@mkp.net' => 'Martin K. Petersen', # lbdb
 'mlang@delysid.org' => 'Mario Lang', # google
 'mlindner@syskonnect.de' => 'Mirko Lindner',
@@ -574,9 +596,11 @@
 'os@emlix.com' => 'Oskar Schirmer', # sent by himself
 'osst@riede.org' => 'Willem Riede',
 'otaylor@redhat.com' => 'Owen Taylor',
+'overby@sgi.com' => 'Glen Overby',
 'p.guehring@futureware.at' => 'Philipp Gühring',
 'p2@ace.ulyssis.sutdent.kuleuven.ac.be' => 'Peter De Shrijver',
 'p_gortmaker@yahoo.com' => 'Paul Gortmaker',
+'pam.delaney@lsil.com' => 'Pamela Delaney',
 'pasky@ucw.cz' => 'Petr Baudis',
 'patmans@us.ibm.com' => 'Patrick Mansfield',
 'paubert@iram.es' => 'Gabriel Paubert',
@@ -597,6 +621,7 @@
 'perex@perex.cz' => 'Jaroslav Kysela',
 'perex@pnote.perex-int.cz' => 'Jaroslav Kysela',
 'perex@suse.cz' => 'Jaroslav Kysela',
+'peter@bergner.org' => 'Peter Bergner',
 'peter@cadcamlab.org' => 'Peter Samuelson',
 'peter@chubb.wattle.id.au' => 'Peter Chubb',
 'peterc@gelato.unsw.edu.au' => 'Peter Chubb',
@@ -696,6 +721,7 @@
 'shaggy@kleikamp.austin.ibm.com' => 'Dave Kleikamp',
 'shaggy@shaggy.austin.ibm.com' => 'Dave Kleikamp', # lbdb
 'shemminger@osdl.org' => 'Stephen Hemminger',
+'shields@msrl.com' => 'Michael Shields',
 'shingchuang@via.com.tw' => 'Shing Chuang',
 'silicon@falcon.sch.bme.hu' => 'Szilárd Pásztor', # google
 'simonb@lipsyncpost.co.uk' => 'Simon Burley',
@@ -734,6 +760,7 @@
 't-kouchi@mvf.biglobe.ne.jp' => 'Takayoshi Kouchi',
 'tai@imasy.or.jp' => 'Taisuke Yamada',
 'taka@valinux.co.jp' => 'Hirokazu Takahashi',
+'tinglett@vnet.ibm.com' => 'Todd Inglett',
 'tao@acc.umu.se' => 'David Weinehall', # by himself
 'tao@kernel.org' => 'David Weinehall', # by himself
 'tcallawa@redhat.com' => 'Tom Callaway',
@@ -1338,6 +1365,18 @@
 __END__
 # --------------------------------------------------------------------
 # $Log: lk-changelog.pl,v $
+# Revision 0.77  2003/02/27 10:52:59  vita
+# Added 7 new names for addresses from both current BK trees.
+#
+# Revision 0.76  2003/02/24 20:04:23  vita
+# Added 7 new names for addresses from current linux-2.5 BK tree.
+#
+# Revision 0.75  2003/02/21 12:41:18  vita
+# Added 5 new names for addresses from current linux-2.4 BK tree.
+#
+# Revision 0.74  2003/02/19 11:15:14  vita
+# Added 7 new addresses found by Google.
+#
 # Revision 0.73  2003/02/14 10:45:45  vita
 # Added 5 new addresses found by Google.
 #

===================================================================


This BitKeeper patch contains the following changesets:
1.35

# User:	matthias.andree
# Host:	gmx.de
# Root:	/suse/kernel/BK/BK-kernel-tools

# Patch vers:	1.3
# Patch type:	REGULAR

== ChangeSet ==
torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
matthias.andree@gmx.de|ChangeSet|20030214194042|45219
D 1.35 03/02/27 12:43:11+01:00 matthias.andree@gmx.de +1 -0
B torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
C
c Another set of addresses.
K 45216
P ChangeSet
------------------------------------------------

0a0
> torvalds@home.transmeta.com|shortlog|20020518074718|31795|fe9afc709a0edabd matthias.andree@gmx.de|shortlog|20030227114310|20707

== shortlog ==
torvalds@home.transmeta.com|shortlog|20020518074718|31795|fe9afc709a0edabd
matthias.andree@gmx.de|shortlog|20030214194041|22901
D 1.15 03/02/27 12:43:10+01:00 matthias.andree@gmx.de +40 -1
B torvalds@penguin.transmeta.com|ChangeSet|20020201230659|29655|e2e55c41ab787ec2
C
c Another set of addresses.
K 20707
O -rwxrwxr-x
P shortlog
------------------------------------------------

D11 1
I11 1
# $Id: lk-changelog.pl,v 0.77 2003/02/27 10:52:59 vita Exp $
I95 1
'ajoshi@kernel.crashing.org' => 'Ani Joshi',
I115 1
'andrew.wood@ivarch.com' => 'Andrew Wood',
I164 1
'bwa@us.ibm.com' => 'Bruce Allan',
I173 2
'chas@cmf.nrl.navy.mil' => 'Chas Williams',
'chas@locutus.cmf.nrl.navy.mil' => 'Chas Williams',
I182 1
'cniehaus@handhelds.org' => 'Carsten Niehaus',
I193 2
'd.mueller@elsoft.ch' => 'David Müller',
'd3august@dtek.chalmers.se' => 'Björn Augustsson',
I204 1
'dave@thedillows.org' => 'David Dillow',
I272 1
'faikuygur@ttnet.net.tr' => 'Faik Uygur',
I315 1
'green@linuxhacker.ru' => 'Oleg Drokin',
I350 1
'ishikawa@linux.or.jp' => 'Ishikawa Mutsumi',
I355 1
'jakub@redhat.com' => 'Jakub Jelínek',
I377 1
'jejb@malley.(none)' => 'James Bottomley',
I392 1
'jh@sgi.com' => 'John Hesterberg',
I400 1
'joel.buckley@sun.com' => 'Joel Buckley',
I435 1
'kare.sars@lmf.ericsson.se' => 'Kåre Särs',
I477 1
'louis.zhuang@linux.co.intel.com' => 'Louis Zhuang',
I516 1
'meissner@suse.de' => 'Marcus Meissner',
I521 1
'mike@aiinc.ca' => 'Michael Hayes',
I523 1
'mikpe@user.it.uu.se' => 'Mikael Pettersson',
I531 1
'mk@linux-ipv6.org' => 'Mitsuru Kanda',
I576 1
'overby@sgi.com' => 'Glen Overby',
I579 1
'pam.delaney@lsil.com' => 'Pamela Delaney',
I599 1
'peter@bergner.org' => 'Peter Bergner',
I698 1
'shields@msrl.com' => 'Michael Shields',
I736 1
'tinglett@vnet.ibm.com' => 'Todd Inglett',
I1340 12
# Revision 0.77  2003/02/27 10:52:59  vita
# Added 7 new names for addresses from both current BK trees.
#
# Revision 0.76  2003/02/24 20:04:23  vita
# Added 7 new names for addresses from current linux-2.5 BK tree.
#
# Revision 0.75  2003/02/21 12:41:18  vita
# Added 5 new names for addresses from current linux-2.4 BK tree.
#
# Revision 0.74  2003/02/19 11:15:14  vita
# Added 7 new addresses found by Google.
#

# Patch checksum=7ec24844
