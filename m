Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUHYQKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUHYQKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268043AbUHYQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 12:10:41 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:48565 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S268042AbUHYQKb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 12:10:31 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Wed,_25_Aug_2004_16_10_27_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040825161027.EA906C9A9C@merlin.emma.line.org>
Date: Wed, 25 Aug 2004 18:10:27 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.218, 2004-08-25 18:10:11+02:00, matthias.andree@gmx.de
  vita: 12 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletion(-)

##### GNUPATCH #####
--- 1.190/shortlog	2004-08-24 20:23:03 +02:00
+++ 1.191/shortlog	2004-08-25 18:10:10 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.322 2004/08/24 06:33:07 vita Exp $
+# $Id: lk-changelog.pl,v 0.323 2004/08/25 12:58:06 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -261,6 +261,7 @@
 'amalysh:web.de' => 'Alexander Malysh',
 'ambx1:com.rmk.(none)' => 'Adam Belay',
 'ambx1:neo.rr.com' => 'Adam Belay',
+'amgta:yacht.ocn.ne.jp' => 'Akinobu Mita',
 'amir.noam:intel.com' => 'Amir Noam',
 'amitg:edu.rmk.(none)' => 'Amit Gurdasani',
 'amn3s1a:ono.com' => 'Miguel A. Fosas',
@@ -319,6 +320,7 @@
 'arzie:dds.nl' => 'Robert Zwerus',
 'aschultz:warp10.net' => 'Andreas Schultz',
 'asetlur:lucent.com' => 'Anand R. Setlur',
+'ash:tsi.lv' => 'Alexander Shatohin',
 'ashok.raj:intel.com' => 'Ashok Raj',
 'asit.k.mallick:intel.com' => 'Asit K. Mallick', # by Kristian Peters
 'askulysh:image.kiev.ua' => 'Andriy Skulysh',
@@ -365,6 +367,7 @@
 'bengen:hilluzination.de' => 'Hilko Bengen',
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
+'benjl:cse.unsw.edu.au' => 'Ben Leslie',
 'berentsen:sent5.uni-duisburg.de' => 'Martin Berentsen',
 'bergner:brule.rchland.ibm.com' => 'Peter Bergner',
 'bergner:cannon.rchland.ibm.com' => 'Peter Bergner',
@@ -390,6 +393,7 @@
 'bjorn:mork.no' => 'Bjørn Mork',
 'bjorn_helgaas:hp.com' => 'Bjorn Helgaas',
 'bk:suse.de' => 'Bernhard Kaindl',
+'blaisorblade_spam:yahoo.it' => 'Paolo \'Blaisorblade\' Giarrusso',
 'blaschke:blaschke3.austin.ibm.com' => 'Dave Blaschke',
 'blazara:nvidia.com' => 'Brian Lazara',
 'blueflux:koffein.net' => 'Oskar Andreasson',
@@ -417,6 +421,7 @@
 'bryan:staidm.org' => 'Bryan Rittmeyer',
 'bryder:paradise.net.nz' => 'Bill Ryder',
 'buffer:antifork.org' => 'Angelo Dell\'Aera',
+'bugfixer:list.ru' => 'Nick Orlov',
 'bunk:de.rmk.(none)' => 'Adrian Bunk', # guessed
 'bunk:fs.tum.de' => 'Adrian Bunk',
 'buytenh:gnu.org' => 'Lennert Buytenhek',
@@ -847,6 +852,7 @@
 'gsromero:alumnos.euitt.upm.es' => 'Guillermo S. Romero',
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gtw:cs.bu.edu' => 'Gary Wong',
+'guillaume.thouvenin:bull.net' => 'Guillaume Thouvenin',
 'guillaume:morinfr.org' => 'Guillaume Morin',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'gwurster:scs.carleton.ca' => 'Glenn Wurster',
@@ -992,6 +998,7 @@
 'jdavid:farfalle.com' => 'David Ruggiero',
 'jdewand:redhat.com' => 'Julie DeWandel',
 'jdgaston:snoqualmie.dp.intel.com' => 'Jason D Gaston',
+'jdike:addtoit.com' => 'Jeff Dike',
 'jdike:jdike.wstearns.org' => 'Jeff Dike',
 'jdike:karaya.com' => 'Jeff Dike',
 'jdike:uml.karaya.com' => 'Jeff Dike',
@@ -1181,6 +1188,7 @@
 'kenneth.w.chen:intel.com' => 'Kenneth W. Chen',
 'kernel-hacker:bennee.com' => 'Alex Bennee',
 'kernel:axion.demon.nl' => 'Monchi Abbad',
+'kernel:cornelia-huck.de' => 'Cornelia Huck',
 'kernel:jsl.com' => 'Jeffrey S. Laing',
 'kernel:kolivas.org' => 'Con Kolivas',
 'kernel:linuxace.com' => 'Phil Oester',
@@ -1245,6 +1253,7 @@
 'kurt.robideau:comtrol.com' => 'Kurt Robideau',	# wild guess
 'kyle:debian.org' => 'Kyle McMartin',
 'kyle:engsoc.carleton.ca' => 'Kyle McMartin',
+'l.rossato:tiscali.it' => 'Luca Rossato',
 'l.s.r:web.de' => 'René Scharfe',
 'ladis:linux-mips.org' => 'Ladislav Michl',
 'ladis:psi.cz' => 'Ladislav Michl',
@@ -1304,6 +1313,7 @@
 'livio:ime.usp.br' => 'Livio Baldini Soares',
 'liyang:nerv.cx' => 'Liyang Hu',
 'lkml001:vrfy.org' => 'Kay Sievers',
+'lkml:felipe-alfaro.com' => 'Felipe Alfaro Solana',
 'lkml:lievin.net' => 'Romain Liévin',
 'lkml:mathfillsmewithgreatjoy.com' => 'Michael Plump',
 'lkml:shemesh.biz' => 'Shachar Shemesh',
@@ -1590,6 +1600,7 @@
 'numlock:freesurf.ch' => 'Joël Bourquard',
 'nuno:itsari.org' => 'Nuno Monteiro',
 'obelix123:toughguy.net' => 'Raj',		# Hmm..
+'obi:saftware.de' => 'Andreas Oberritter',
 'od:suse.de' => 'Olaf Dabrunz',
 'ogasawara:osdl.org' => 'Leann Ogasawara',
 'okir:suse.de' => 'Olaf Kirch', # lbdb
@@ -2267,6 +2278,7 @@
 'ysauyuki.kozakai:toshiba.co.jp' => 'Yasuyuki Kozakai', # typo
 'yuasa:hh.iij4u.or.jp' => 'Yoichi Yuasa',
 'yuri:acronis.com' => 'Yuri Per', # lbdb
+'zach:vmware.com' => 'Zachary Amsden',
 'zaitcev:redhat.com' => 'Pete Zaitcev',
 'zap:homelink.ru' => 'Andrew Zabolotny',
 'zap:ru.rmk.(none)' => 'Andrew Zabolotny',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAPO5LEECA71VXW/bNhR9tn7FBVLAD61pkpJsiYCL5qNLvWZLkKwvQ4GBlmiLMSUaJOU4
g3/8KCp2lgzFsK2YJFjg1TmXh4fH0gnML9jAabPlqrQfNqJZtbJBzvDG1sJxVOh6f17xZiXu
hNtTjKk/CY3xJM33NJ+k6V5QkaZFQvhimk1FQaMT+GKFYYOaO1dJbhFvSiOEr3/S1rHBqt6h
shveau2HY9taMV4L0wg1Pvvsr1E/GDmtlY088Ia7ooKtMJYNCIqPFfe4EWxw+/Hyy9XpbRTN
ZnDUCrNZ9J3X9dxuU+RTjLQtFdJm9bJRgjOakMy3iveYxARHF0AQJRngZIyzMU2BZIxgRshb
TBnG8MqnD70/8JbACEdn8J1XcR4VsJWOMyAUGvEAvPSzWits9NmXSBbdPLsYjf7hEUWY4+j9
s+hK1+KVYltp45Re9YJTkuFpMiXZPibTPN0vRc6XxRTnHIuSL8pv2POiS+d5SiYEE7xPs3ya
hCwcEC+i8J/1fDsGrxUdUkBiTJKQApKTv6QA/10KYhiR/zkGvYfXMDIPu+4a7XwoDsv7F5m4
IARINA+/J/BmXjJQ61ERJPuOaKPebQGjmMbQeXcwiLI0Y3gSdMLH3QbeRHM6iX2TIa9XXvsj
LyqHdNGgRqD7zRBm72F4upaNXrTwk2cN30XzmJLAsBVzViK1fYIpsfNWCwN3FXe6kk0AT6Yd
eCGae8UKK1Db2AckyhbxtuediQauhFVSBHxOA15xabXxt1L8Zje89tIqrZF0PemGa6Xh6/Ds
T7ivQ7iU3JjWWt21SkgeWrWrpdz596eS1iHzNOvPsljDtVF620GzJEB9DJTibRfoSrdb0ciG
LVqlvBtP814eEPDLAdHx8zzp+PelXAvmN95p6boU9aQfxXIJF/5RByUkC4b3r2RW6O4m+ahq
i7XPZ884f6rCJ18NLJoEHxUy2lpvL3PSFlzJoyNXbcH9ByA8DAyf1sBY14otfbONGHG15EY/
C/shlOE0lOFOK96EHSZpvwt6IZnlS/fAjThqO+3+TtzC9UIYI50TpqNQOgkW/u4TxLZ1YBzn
+dUXuXmE09qWojPs+MEpKlGsbVvPJnFBl0SU0R9Jg1F+QgcAAA==

