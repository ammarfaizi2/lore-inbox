Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbUHWLCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbUHWLCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 07:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263733AbUHWLBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 07:01:54 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:5776 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S267662AbUHWKnL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 06:43:11 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon,_23_Aug_2004_10_43_04_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040823104304.D65E1CF0A0@merlin.emma.line.org>
Date: Mon, 23 Aug 2004 12:43:04 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.212, 2004-08-23 12:42:43+02:00, matthias.andree@gmx.de
  vita: 13 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletion(-)

##### GNUPATCH #####
--- 1.184/shortlog	2004-08-16 13:17:49 +02:00
+++ 1.185/shortlog	2004-08-23 12:42:43 +02:00
@@ -8,7 +8,7 @@
 #			Tomas Szepe <szepe@pinerecords.com>
 #			Vitezslav Samel <samel@mail.cz>
 #
-# $Id: lk-changelog.pl,v 0.320 2004/08/16 11:05:26 vita Exp $
+# $Id: lk-changelog.pl,v 0.321 2004/08/23 10:37:29 vita Exp $
 # ----------------------------------------------------------------------
 # Distribution of this script is permitted under the terms of the
 # GNU General Public License (GNU GPL) v2.
@@ -185,6 +185,7 @@
 'adwol:polsl.gliwice.pl' => 'Adam Osuchowski',
 'aeb:cwi.nl' => 'Andries E. Brouwer',
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
+'afleming:freescale.com' => 'Andy Fleming',
 'agk:redhat.com' => 'Alasdair G. Kergon',
 'agl:us.ibm.com' => 'Adam Litke',
 'agoddard:purdue.edu' => 'Alex Goddard',
@@ -500,6 +501,7 @@
 'cotte:de.ibm.com' => 'Carsten Otte',
 'coughlan:redhat.com' => 'Tom Coughlan',
 'coywolf:greatcn.org' => 'Coywolf Qi Hunt',
+'cp:absolutedigital.net' => 'Cal Peake',
 'cpg:aladdin.de' => 'Christian Groessler',
 'cpg:puchol.com' => 'Carlos Puchol',
 'cph:zurich.ai.mit.edu' => 'Chris Hanson',
@@ -562,6 +564,7 @@
 'david-b:pacbell.net' => 'David Brownell',
 'david-b:packbell.net' => 'David Brownell',
 'david.goodenough:btconnect.com' => 'David Goodenough',
+'david.martinez:rediris.es' => 'David Martínez Moreno',
 'david.nelson:pobox.com' => 'David Nelson',
 'david:csse.uwa.edu.au' => 'David Glance',
 'david:gibson.dropbear.id.au' => 'David Gibson',
@@ -583,6 +586,7 @@
 'ddstreet:us.ibm.com' => 'Dan Streetman',
 'dean:arctic.org' => 'Dean Gaudet',
 'debian:abeckmann.de' => 'Andreas Beckmann',
+'debian:sternwelten.at' => 'Maximilian Attems',
 'deepfire:sic-elvis.zel.ru' => 'Samium Gromoff',
 'defouwj:purdue.edu' => 'Jeff DeFouw',
 'delaunay:lix.polytechnique.fr' => 'Eric Delaunay',
@@ -737,6 +741,7 @@
 'filip.sneppe:cronos.be' => 'Filip Sneppe',
 'fischer:linux-buechse.de' => 'Jürgen E. Fischer',
 'fishor:gmx.net' => 'Alexey Fisher',
+'fl:fl.priv.at' => 'Friedrich Lobenstock',
 'flavien:lebarbe.net' => 'Flavien Lebarbé',
 'fletch:aracnet.com' => 'Martin J. Bligh',
 'flo:rfc822.org' => 'Florian Lohoff',
@@ -873,6 +878,7 @@
 'herbert:13thfloor.at' => 'Herbert Pötzl', # lbdb
 'herbert:gondor.apana.org.au' => 'Herbert Xu',
 'herbet:gondor.apana.org.au' => 'Herbert Xu',
+'hermes:gibson.dropbear.id' => 'David Gibson',
 'hermes:gibson.dropbear.id.au' => 'David Gibson',
 'hero:persua.de' => 'Heiko Ronsdorf',
 'hirofumi:mail.parknet.co.jp' => 'Hirofumi Ogawa', # corrected by himself
@@ -1112,6 +1118,7 @@
 'junkio:cox.net' => 'Junio C. Hamano',
 'jurgen:botz.org' => 'Jürgen Botz',
 'jwboyer:charter.net' => 'Josh Boyer',
+'jwboyer:infradead.org' => 'Josh Boyer',
 'jwoithe:physics.adelaide.edu.au' => 'Jonathan Woithe',
 'k-suganuma:mvj.biglobe.ne.jp' => 'Kimio Suganuma',
 'k.kasprzak:box43.pl' => 'Karol Kasprzak', # by Kristian Peters
@@ -1127,6 +1134,7 @@
 'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
 'kaie:kuix.de' => 'Kai Engert',
 'kala:pinerecords.com' => 'Tomas Szepe',
+'kalev:smartlink.ee' => 'Kalev Lember',
 'kalin:thinrope.net' => 'Kalin Rumenov Kozhuharov',
 'kambo77:hotmail.com' => 'Kambo Lohan',
 'kaneshige.kenji:jp.fujitsu.com' => 'Kenji Kaneshige', # lbdb
@@ -1412,6 +1420,7 @@
 'michael.ni:hp.com' => 'Michael Ni',
 'michael.veeck:gmx.net' => 'Michael Veeck',
 'michael.waychison:sun.com' => 'Mike Waychison',
+'michael:com.rmk.(none)' => 'Michael Opdenacker',
 'michael:metaparadigm.com' => 'Michael Clark',
 'michael_e_brown:dell.com' => 'Michael E. Brown', # lbdb
 'michael_pruznick:mvista.com' => 'Michael Pruznick',
@@ -1718,6 +1727,7 @@
 'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdb
 'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
 'radford:indigita.com' => 'Jim Radford',
+'rainer.weikusat:sncag.com' => 'Rainer Weikusat',
 'ralf:dea.linux-mips.net' => 'Ralf Bächle',
 'ralf:linux-mips.org' => 'Ralf Bächle',
 'ralphs:org.rmk.(none)' => 'Ralph Siemsen',
@@ -1848,6 +1858,7 @@
 'santiago:newphoenix.net' => 'Santiago A. Nullo', # sent by self
 'santil:us.ibm.com' => 'Santiago Leon',
 'sarolaht:cs.helsinki.fi' => 'Pasi Sarolahti',
+'sascha:de.rmk.(none)' => 'Sascha Hauer',
 'sawa:yamamoto.gr.jp' => 'sawa',
 'scameron:quandary.cca.cpqcorp.net' => 'Steve Cameron',
 'scd:broked.org' => 'Steven Dake',
@@ -1881,6 +1892,7 @@
 'set:pobox.com' => 'Paul Thompson',
 'seto.hidetoshi:jp.fujitsu.com' => 'Hidetoshi Seto',
 'sezero:superonline.com' => 'Özkan Sezer',
+'sezeroz:ttnet.net.tr' => 'Özkan Sezer',
 'sfbest:us.ibm.com' => 'Steve Best',
 'sfr:au1.ibm.com' => 'Stephen Rothwell',
 'sfr:canb.auug.org.au' => 'Stephen Rothwell',
@@ -2036,6 +2048,7 @@
 'thomas:stewarts.org.uk' => 'Thomas Stewart',
 'thomas:winischhofer.net' => 'Thomas Winischhofer', # whois
 'thomr9am:ss1000.ms.mff.cuni.cz' => 'Rudo Thomas',
+'thor:math.tu-berlin.de' => 'Thomas Richter',
 'thornber:redhat.com' => 'Joe Thornber',
 'thornber:sistina.com' => 'Joe Thornber',
 'thunder7:xs4all.nl' => 'Jurriaan Kalkman',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIADjKKUECA71V7W7bNhT9HT0FgRTIitY0SUmRTMBF89GPNAkaOCv2m5aubU0SaZD0RwI/
595i79BLyUmWbgPWrZhNGCDPPZfnHl7Sh+TiXB54Y9eqKd3bJej5qtLUW6VdC17RwrS7s4XS
c7gFvxOMCfxyEbPjdLQTo+M03YGANC0SrqZZnkEhokPyxYGVB63yflEpR5UuLQCufzTOy4N5
u6VlmE6MwenQrRwMa7AamuHpJY5BPxl4YxoXYeCN8sWCrME6ecBp/Lji75YgDybvPny5OplE
0XhMHrWS8Tj6wXV9U8/bvo7naRKW82POeZayHeYTaXROOBVcEJYMWT4UMeFCJjjiV0xIxshf
ZyWvOBmw6JT84BrOooKsK68k4THRsCGqxF2dAxddojLOopsnD6PBd36iiCkWvXkSvTAtfKPY
LYz1jZn3glOesyzJeL6LeTZKdzMYqVmRsZFiUKpp+Tf2PMuCnouYs0Qk8Y6LLB51nfAQ8awR
/rOe6J/p6XsgwWPIRizveoDn6ff3QEIG/H9vguDgZzKwm20Ygy22xEN5/6IjzjknPLrofg/J
i4tSkqYeFJ1kzEiXzes1YTQWnATvHgxiMs6kGHU6ybvtkrzAHHmGSY7UrIG20nM5Q69coRoI
LhyR8RtydKLLO/K+x49eRxcpE4FSLKWaOtOsPJTVHFM2VIPvKWeqITegaujij5MQX6p1VdJW
WV9puJcWWbZyFFxPOQ8wuUb4d4TJtbGgTUfHQw50mFZKS+fxHdtA40FTtd/tWm2rtmoQJife
Q+sCDR0PtFkjZw1d2mr9GP7eVlDaCt+6KzMF7bwp6sDIs26jBdgWnJxXWJympTXLKShLq/KP
Oj90aGBhU3bl/bqZmjt8ois9s6oEVVJj5z3lk3ELchrQniA6ZTWavJYuGNJUuqYAffRlWCdX
0E738Um/QYuKFTQSz4XatqY/aaPh5d6BHiOflyVoVdR7ZiZYYFqFjlu6gapeOeWl04WaP53v
pIPJL3u4Y+Zpx3TKYWJZwp92vO0Q8lGt9nvledwx4B6suZfeYzOEhsB71TN+u6/xgG4DHgiC
xXkgeLwGEi/rgvrVAEtGL/Ce9pSf8W1RjkywOt+xHv+ligUUtVu14wIgYfEsjr4C3oFHm3cH
AAA=

