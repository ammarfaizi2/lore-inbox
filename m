Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268662AbUIXKJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268662AbUIXKJt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 06:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268660AbUIXKJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 06:09:49 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:21443 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S268662AbUIXKJV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 06:09:21 -0400
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri,_24_Sep_2004_10_09_16_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20040924100916.5236EC0C21@merlin.emma.line.org>
Date: Fri, 24 Sep 2004 12:09:16 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.223, 2004-09-24 11:00:40+02:00, samel@mail.cz
  shortlog: 3 new addresses

ChangeSet@1.222, 2004-09-23 11:22:03+02:00, samel@mail.cz
  shortlog: 6 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    9 +++++++++
 1 files changed, 9 insertions(+)

##### GNUPATCH #####
--- 1.193/shortlog	2004-09-21 10:57:08 +02:00
+++ 1.195/shortlog	2004-09-24 11:00:18 +02:00
@@ -373,6 +373,7 @@
 'bellucda:tiscali.it' => 'Daniele Bellucci',
 'ben-linux:org.rmk.(none)' => 'Ben Dooks',
 'bengen:hilluzination.de' => 'Hilko Bengen',
+'benh:kenrel.crashing.org' => 'Benjamin Herrenschmidt', # typo
 'benh:kernel.crashing.org' => 'Benjamin Herrenschmidt',
 'benh:zion.wanadoo.fr' => 'Benjamin Herrenschmidt',
 'benjl:cse.unsw.edu.au' => 'Ben Leslie',
@@ -443,6 +444,7 @@
 'bwindle:fint.org' => 'Burton N. Windle',
 'bzeeb-lists:lists.zabbadoz.net' => 'Björn A. Zeeb', # lbdb
 'bzolnier:elka.pw.edu.pl' => 'Bartlomiej Zolnierkiewicz',
+'bzolnier:trik.(none)' => 'Bartlomiej Zolnierkiewicz',
 'bzzz:gerasimov.net' => 'Alex Tomas',
 'bzzz:tmi.comex.ru' => 'Alex Tomas',
 'c-d.hailfinger.kernel.2002-07:gmx.net' => 'Carl-Daniel Hailfinger',
@@ -1193,6 +1195,7 @@
 'kai:vaio.(none)' => 'Kai Germaschewski',
 'kai:zephyr.physics.uiowa.edu' => 'Kai Germaschewski',
 'kaie:kuix.de' => 'Kai Engert',
+'kaigai:ak.jp.nec.com' => 'KaiGai Kohei',
 'kala:pinerecords.com' => 'Tomas Szepe',
 'kalev:smartlink.ee' => 'Kalev Lember',
 'kalin:thinrope.net' => 'Kalin Rumenov Kozhuharov',
@@ -1245,6 +1248,7 @@
 'khc:pc.waw.pl' => 'Krzysztof Halasa',
 'khc:pm.waw.pl' => 'Krzysztof Halasa',
 'kieran:mgpenguin.net' => 'Kieran Morrissey',
+'kihara.seiji:lab.ntt.co.jp' => 'Seiji Kihara',
 'killekulla:rdrz.de' => 'Raphael Zimmerer',
 'kingsley:aurema.com' => 'Cheung Kingsley',
 'kiran:in.ibm.com' => 'Ravikiran G. Thirumalai',
@@ -1456,6 +1460,7 @@
 'matthewc:cse.unsw.edu.au' => 'Matthew Chapman',
 'matthewn:snapgear.com' => 'Matthew Natalier',
 'matthias.andree:gmx.de' => 'Matthias Andree', # added by himself
+'mauelshagen:redhat.com' => 'Heinz J. Mauelshagen',
 'mauelshagen:sistina.com' => 'Heinz J. Mauelshagen',
 'maverick:eskuel.net' => 'Mathieu Lesniak',
 'maxim:de.ibm.com' => 'Maxim Shchetynin',
@@ -1637,6 +1642,7 @@
 'normalperson:yhbt.net' => 'Eric Wong',
 'not:just.any.name' => 'John Fremlin',
 'notting:redhat.com' => 'Bill Nottingham',
+'nreilly:magma.ca' => 'Nicholas Reilly',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
 'ntl:pobox.com' => 'Nathan T. Lynch',
@@ -1935,6 +1941,7 @@
 'ruby.joker:op.pl' => 'Ruby Joker',
 'rui.sousa:laposte.net' => 'Rui Sousa',
 'runet:innovsys.com' => 'Rune Torgersen',
+'russb:emc.com' => 'Brett Russ',
 'russell_d_cagle:mindspring.com' => 'Russell Cagle', # google
 'rusty:au1.ibm.com' => 'Rusty Russell',
 'rusty:linux.co.intel.com' => 'Rusty Lynch',
@@ -1946,6 +1953,7 @@
 'rwhron:earthlink.net' => 'Randy Hron',
 'rwhron:net.rmk.(none)' => 'Randy Hron',
 'ryan:michonline.com' => 'Ryan Anderson',
+'ryan:spitfire.gotdns.org' => 'Ryan Cumming',
 'rz:linux-m68k.org' => 'Richard Zidlicky',
 's.doyon:videotron.ca' => 'Stéphane Doyon',
 'sabala:students.uiuc.edu' => 'Michal Sabala', # google
@@ -2056,6 +2064,7 @@
 'sparker:sun.com' => 'Steven Parker', # by Duncan Laurie
 'sparse:chrisli.org' => 'Christopher Li',
 'spitalnik:penguin.cz' => 'Jan Spitalnik',
+'spock:gentoo.org' => 'Michal Januszewski',
 'sprite:sprite.fr.eu.org' => 'Jeremie Koenig',
 'spse:secret.org.uk' => 'Simon Evans', # by Kristian Peters
 'spstarr:sh0n.net' => 'Shawn Starr',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAEzyU0ECA9VW247bNhB9Nr+CwD64RWKZutC6AA7S3RTZjZsmcJCXvo2lWYkriTRIei+G
Pr6UFMd1skiRdoOiugES54zO8JyhdEavXmUTq/QtNIV5uUVZ7oT0rAZpWrTg5artLiqQJX5A
2wWMBW73g5AteNoF6YLzDgPkPI982MRJjHlAzuhHgzqbtGBtJcB4IAuN6J5fKmOzSdnee0V/
u1bK3c5vQc83wtaIW9Tz89WsRi2xmVmlGkNc3HuweUVvUZts4nvh5yf2YYvZZP3r64+//bIm
ZLmkn6nS5ZI8cVkGWmxetiAaL9+foiOWBj5LeMJ4t+BBmpJX1PeCIKAsmrN0HoTU97MgyFj4
jLkroyfJ6DOfzhg5p0/M+ILk1FRK20aVGV1QiXcUCqeFMWjIijqqCSfvj7NGZt+5EcKAkRdH
4pVq8QvWBwYjae4nLI5iP+lCP055d40pXOcxS4FhAZvidGZOwP0sh/1MB7wLQxaH5O806aMD
FnZjoaMm4UGTqNeEsSxi/50m4aOapP8vTdzJmANHEYv50IaHiJMu/Nc0yLdp9A0Ys6RjcRqF
g9h+Gp02oDv442IvfpjYX7fd6N13dKbv7vtjdu/0PlTzD+S+CmNOfTLdoKyyGqVGV5MGUwlZ
ekqXU7p8QafnKG+gFZJeotYoTV61orDT5/SsX0cVufL9dEhTgyhBZFB7N1tPYt5XPqZYgXgN
gq5UhWL63CGCKB4QogINnkFxI7IGNp601qEcfsR96AfoaogacBFPelwLO2xMBSXKTGNRgT2+
6xKF3NM3Hn17DBqwaTRg9QPIzGyFvRYavVLZQppjsWs3Si92rau37FHOXAPKbFVeZy6V+7Yc
o9+KvIKGvgG5M3u8M3VfHfmehWh0G/9yafGTx90W/jC3fb2gjF35hG6LosXgtr1qpHDfeatF
7f0klcSfPzkN+tytwBv6xxhTC7wT+X7QbxGFPdy5VDTNQ9ZC2bpyYYT+7pRQDRi6HkY/Ce4P
gu+M2WTY/sWP5xqtpWs30Ot1+CvIK8xrs2uX8fWGL6I0JH8CKq9O/eYIAAA=

