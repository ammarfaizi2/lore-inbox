Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261568AbVBDLkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbVBDLkB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261826AbVBDLj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:39:59 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:32897 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262620AbVBDLfY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:35:24 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri,_04_Feb_2005_11_35_12_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050204113512.C3DA477734@merlin.emma.line.org>
Date: Fri,  4 Feb 2005 12:35:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.269, 2005-02-04 06:42:31+01:00, samel@mail.cz
  shortlog: add 14 new addresses

ChangeSet@1.268, 2005-02-01 14:52:23+01:00, samel@mail.cz
  shortlog: add 7 new addresses

ChangeSet@1.267, 2005-01-25 07:24:16+01:00, samel@mail.cz
  shortlog: added 2 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+)

##### GNUPATCH #####
--- 1.235/shortlog	2005-01-22 03:03:26 +01:00
+++ 1.238/shortlog	2005-02-04 06:42:16 +01:00
@@ -243,6 +243,7 @@
 'albert.cahalan:ccur.com' => 'Albert Cahalan',
 'albert:users.sf.net' => 'Albert Cahalan',
 'albert:users.sourceforge.net' => 'Albert Cahalan',
+'albert_herranz:yahoo.es' => 'Albert Herranz',
 'albertcc:tw.ibm.com' => 'Albert Lee',
 'albertogli:telpin.com.ar' => 'Alberto Bertogli',
 'alborchers:steinerpoint.com' => 'Al Borchers',
@@ -397,6 +398,7 @@
 'bcasavan:sgi.com' => 'Brent Casavant',
 'bcollins:debian.org' => 'Ben Collins',
 'bcrl:bob.home.kvack.org' => 'Benjamin LaHaise',
+'bcrl:kvack.org' => 'Benjamin LaHaise',
 'bcrl:redhat.com' => 'Benjamin LaHaise',
 'bcrl:toomuch.toronto.redhat.com' => 'Benjamin LaHaise', # guessed
 'bde:bwlink.com' => 'Bruce D. Elliott',	# it's typo IMHO
@@ -452,6 +454,7 @@
 'bmatheny:purdue.edu' => 'Blake Matheny', # google
 'bo.henriksen:com.rmk.(none)' => 'Bo Henriksen',
 'bo.henriksen:nordicid.com' => 'Bo Henriksen',
+'bob.picco:hp.com' => 'Bob Picco',
 'bodo.stroesser:fujitsu-siemens.com' => 'Bodo Stroesser',
 'bogdan.costescu:iwr.uni-heidelberg.de' => 'Bogdan Costescu',
 'bombe:informatik.tu-muenchen.de' => 'Andreas Bombe',
@@ -725,6 +728,7 @@
 'dirk.behme:com.rmk.(none)' => 'Dirk Behme',
 'dirk.behme:de.bosch.com' => 'Dirk Behme',
 'dirk.uffmann:nokia.com' => 'Dirk Uffmann',
+'djwong:us.ibm.com' => 'Darrick Wong',
 'dkrivoschokov:dev.rtsoft.ru' => 'Dmitry Krivoschokov',
 'dkuhlen:fhm.edu' => 'Dominik Kuhlen',
 'dl8bcu:dl8bcu.de' => 'Thorsten Kranzkowski',
@@ -871,6 +875,7 @@
 'faikuygur:ttnet.net.tr' => 'Faik Uygur',
 'faith:redhat.com' => 'Rik Faith',
 'falk.hueffner:student.uni-tuebingen.de' => 'Falk Hüffner',
+'fanny.wakizaka:cyclades.com' => 'Fanny Wakizaka',
 'fb.arm:net.rmk.(none)' => 'Frank Becker',
 'fbecker:com.rmk.(none)' => 'Frank Becker',
 'fbl:conectiva.com.br' => 'Flávio Bruno Leitner', # google
@@ -1005,6 +1010,7 @@
 'guido.barzini:com.rmk.(none)' => 'Guido Barzini',
 'guillaume.thouvenin:bull.net' => 'Guillaume Thouvenin',
 'guillaume:morinfr.org' => 'Guillaume Morin',
+'guninski:guninski.com' => 'Georgi Guninski',
 'gunther.mayer:gmx.net' => 'Gunther Mayer',
 'gwehrman:sgi.com' => 'Geoffrey Wehrman',
 'gwurster:scs.carleton.ca' => 'Glenn Wurster',
@@ -1016,6 +1022,7 @@
 'hadi:shell.cyberus.ca' => 'Jamal Hadi Salim',
 'hadi:znyx.com' => 'Jamal Hadi Salim', # typo
 'hadi:zynx.com' => 'Jamal Hadi Salim',
+'hager:cs.umu.se' => 'Peter Hagervall',
 'hall:vdata.com' => 'Jeff Hall',
 'hallyn:cs.wm.edu' => 'Serge Hallyn',
 'halr:voltaire.com' => 'Hal Rosenstock',
@@ -1067,6 +1074,7 @@
 'hj.oertel:surfeu.de' => 'Heinz-Juergen Oertel',
 'hjl:lucon.org' => 'H. J. Lu',
 'hjm:redhat.com' => 'Heinz Mauelshagen', # lbdb
+'hkneissel:gmx.de' => 'Hermann Kneissel',
 'hkneissel:t-online.de' => 'Hermann Kneissel',
 'hno:marasystems.com' => 'Henrik Nordstrom',
 'hoho:binbash.net' => 'Colin Slater',
@@ -1135,6 +1143,7 @@
 'jamagallon:able.es' => 'J. A. Magallon',
 'james.bottomley:steeleye.com' => 'James Bottomley',
 'james.smart:emulex.com' => 'James Smart',
+'james4765:cwazy.co.uk' => 'James Nelson',
 'james4765:gmail.com' => 'James Nelson',
 'james4765:verizon.net' => 'James Nelson',
 'james:cobaltmountain.com' => 'James Mayer',
@@ -1467,6 +1476,7 @@
 'kpc-usbdev:gelato.uiuc.edu' => 'Kevin Cernekee',
 'kpfleming:cox.net' => 'Kevin P. Fleming',
 'kpreslan:redhat.com' => 'Ken Preslan',
+'krautz:gmail.com' => 'Mikkel Krautz',
 'kravetz:us.ibm.com' => 'Mike Kravetz',
 'kraxel:bytesex.org' => 'Gerd Knorr',
 'kraxel:suse.de' => 'Gerd Knorr',
@@ -1475,6 +1485,7 @@
 'krkumar:us.ibm.com' => 'Krishna Kumar',
 'kronos:kronoz.cjb.net' => 'Luca Tettamanti',
 'kronos:people.it' => 'Luca Tettamanti',
+'krzysztof.h1:wp.pl' => 'Krzysztof Helt',
 'ksakamot:linux-m32r.org' => 'Kei Sakamoto',
 'kszysiu:iceberg.elsat.net.pl' => 'Krzysztof Rusocki',
 'kuba:mareimbrium.org' => 'Kuba Ober',
@@ -1529,6 +1540,7 @@
 'lfo:polyad.org' => 'Luis F. Ortiz',
 'liam.girdwood:com.rmk.(none)' => 'Liam Girdwood',
 'liam.girdwood:wolfsonmicro.com' => 'Liam Girdwood',
+'libor:topspin.com' => 'Libor Michalek',
 'linas:austin.ibm.com' => 'Linas Vepstas',
 'linas:linas.org' => 'Linas Vepstas',
 'linas:us.ibm.com' => 'Linas Vepstas',
@@ -1646,12 +1658,14 @@
 'marekm:amelek.gda.pl' => 'Marek Michalkiewicz',
 'margitsw:t-online.de' => 'Margit Schubert-While',
 'marijnk:gmx.co.uk' => 'Marijn Kruisselbrink',
+'marineam:gentoo.org' => 'Michael Marineau',
 'marius:citi.umich.edu' => 'Marius Aamodt Eriksen',
 'mark.fasheh:oracle.com' => 'Mark Fasheh',
 'mark:alpha.dyndns.org' => 'Mark W. McClelland',
 'mark:hal9000.dyndns.org' => 'Mark W. McClelland',
 'mark:mtfhpc.demon.co.uk' => 'Mark Fortescue',
 'mark:net.rmk.(none)' => 'Mark Hindley',
+'mark_salyzyn:adaptec.com' => 'Mark Salyzyn',
 'markb:wetlettuce.com' => 'Mark Broadbent',
 'markgw:sgi.com' => 'Mark Goodwin',
 'markh:osdl.org' => 'Mark Haverkamp',
@@ -1789,6 +1803,8 @@
 'mjc:redhat.com' => 'Mark J. Cox',
 'mk:linux-ipv6.org' => 'Mitsuru Kanda',
 'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
+'mkrikis:yahoo.com' => 'Martins Krikis',
+'mlachwani:mvista.com' => 'Manish Lachwani',
 'mlang:delysid.org' => 'Mario Lang', # google
 'mlev:despammed.com' => 'Lev Makhlis',
 'mlindner:syskonnect.de' => 'Mirko Lindner',
@@ -1893,6 +1909,7 @@
 'normalperson:yhbt.net' => 'Eric Wong',
 'not:just.any.name' => 'John Fremlin',
 'notting:redhat.com' => 'Bill Nottingham',
+'npollitt:mvista.com' => 'Nick Pollitt',
 'nreilly:magma.ca' => 'Nicholas Reilly',
 'nstraz:sgi.com' => 'Nathan Straz',
 'ntfs:flatcap.org' => 'Richard Russon', # lbdb
@@ -1927,6 +1944,7 @@
 'ornati:fastwebnet.it' => 'Paolo Ornati',
 'ortylp:3miasto.net' => 'Paul Ortyl',
 'os:emlix.com' => 'Oskar Schirmer', # sent by himself
+'oskar.senft:gmx.de' => 'Oskar Senft',
 'ossi:kde.org' => 'Oswald Buddenhagen',
 'osst:riede.org' => 'Willem Riede',
 'otaylor:redhat.com' => 'Owen Taylor',
@@ -1981,6 +1999,7 @@
 'pavel:janik.cz' => 'Pavel Janík',
 'pavel:suse.cz' => 'Pavel Machek',
 'pavel:ucw.cz' => 'Pavel Machek',
+'pavenis:latnet.lv' => 'Andris Pavenis',
 'pavlas:nextra.cz' => 'Zdenek Pavlas',
 'pavlic:de.ibm.com' => 'Frank Pavlic',
 'pavlin:icir.org' => 'Pavlin Radoslavov',
@@ -2107,6 +2126,7 @@
 'quintela:mandrakesoft.com' => 'Juan Quintela',
 'r.a.mercer:blueyonder.co.uk' => 'Adam Mercer',
 'r.e.wolff:bitwizard.nl' => 'Rogier Wolff', # lbdb
+'r.e.wolff:harddisk-recovery.nl' => 'Rogier Wolff',
 'r.marek:sh.cvut.cz' => 'Rudolf Marek',
 'r.s.bultje:students.uu.nl' => 'Ronald S. Bultje',
 'radford:indigita.com' => 'Jim Radford',
@@ -2304,6 +2324,7 @@
 'sdake:mvista.com' => 'Steven Dake',
 'sds:epoch.ncsc.mil' => 'Stephen D. Smalley',
 'sds:tislabs.com' => 'Stephen D. Smalley',
+'sds:tycho.nsa.gov' => 'Stephen D. Smalley',
 'se.witt:gmx.net' => 'Sebastian Witt',
 'sean.hefty:intel.com' => 'Sean Hefty',
 'sean.mcgoogan:superh.com' => 'Sean McGoogan',
@@ -2446,6 +2467,7 @@
 'stewartsmith:mac.com' => 'Stewart Smith',
 'stkn:gentoo.org' => 'Stefan Knoblich',
 'stoffel:lucent.com' => 'John Stoffel',
+'stone_wang:sohu.com' => 'Stone Wang',
 'strosake:us.ibm.com' => 'Michael Strosaker',
 'stsp:aknet.ru' => 'Stas Sergeev',
 'stuart_hayes:dell.com' => 'Stuart Hayes',
@@ -2647,6 +2669,7 @@
 'vnuorval:tcs.hut.fi' => 'Ville Nuorvala',
 'vojta:math.berkeley.edu' => 'Paul Vojta',
 'vojtech:kernel.bkbits.net' => 'Vojtech Pavlik',
+'vojtech:silver.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:suse.cz' => 'Vojtech Pavlik',
 'vojtech:twilight.ucw.cz' => 'Vojtech Pavlik',
 'vojtech:ucw.cz' => 'Vojtech Pavlik', # added by himself



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAPBdA0ICA9VXTW/bOBA9R7+CQA85dK2QlChZBFL0I7tNN00bJOjmWNASbbGiREGk7drw
j19+2DGcJii6m6Jo4oPFeY8azpt5lp6Bd2f0yKhhwWSlX/a8m81FF5uBdbrlhsWlajdvatbN
+A03Gwwhtv8IJzAjxQYXGSEbjjkhZYrYJB/nvMTRM/BJ84EetcyYWjAds64aOLfr50obejRr
v8aVu7xWyl6e6LnmJw0fOi5PXl/YzyhcjIxSUkcWeMVMWYMFHzQ9QnFyt2JWPadH13++/fT+
1XUUnZ6Cu1zB6Wn0xOfab9eXRQ5jpSsZq2F2uBGx27jNEpxvMpLAJDoDKMZZDiA5gegEEwBz
ilOKsucQUQiBZi2XL1smZFyuwXMERjB6DZ44+TdRCXStBiPVjAJWVbwCGHR86b4PXGuuowuQ
pbgooqt9GaPRD/5FEWQwerFPv1Ytv5f7Lo+QOkFjmKc5Gm8SlBdkM+UFm5Y5LBjkFZtUh/U5
ILtaE5jhhOANQnafKDoEf6OMQ6co24SDBmXGXhlsxQEopQRTnPxSZUD+oC7j30kXe2pkVYFk
k2QoQ9/RZYvGySYcNOhS7HRJAcxoimmCfq0uKH1AmASS30uYFJIU2xHAOCeJN80d4sAz/3ca
j/vl/REOdpltYDomWRA/yQ7tMrFz+bD4+KeJ/5hJBqf5CEbD8qv7jL7aBtid6T/o/y4lKUDR
8URN4l6UpaJ175I+BqcvwPFrNQFXbvX4j+gdSvPcQZthvdJro6Zxjeiyj3sZwBe7dXDOpbGM
6EfMM1Q+v2+HkDxc+fxnVv4BEwxO8oR1T4rC170cJG0WrGxcd26rzrsvrBUdeM/OmdDcFx8l
Y4e3Aa7TPCO0XLL1yp4ynjeB9rcLgQ9catV5SkYyR2nZ0HzWTK7Wq46yivWGl3uJL20U3ISo
Z+VF4lnNIBqh6YrVSh3Ajeg0uPBRTxgXvi26XkkpjKHtQuhQ/0D5IMoGXIWgI+CUQEfQRnX8
89IqRLWq53vCjQuAWxvw8IwgB1+oLzbxmmoh7cNYPC+XthEC4Z8Qsg9mCyma73Xe/Z+H0Hnj
+4b/6CNS+lNb7wGfD2b5hL1nFXAVZXLCB/O55oPNfL1VmutQ01c+aEfZB50QOfYdW31ZKivZ
XMdi0u5FO2PD4IS+VUG2ce7vMWVdt4qXrBFr1jBarkrJKq73vL8cwIodAL6hIPQ3ms0722mN
oLsve9JbbodFgLfbQGBh31U1m9nn/1LH83Ye29nx+Ctu+ADOXchqJgM+921VNx0XttCShleD
QLDHbm1i4GIb3PofDv7H5mZt4b4j7gZDNA2Xdi5c0MNJ4isgxUQN1Khe97ZJ7vDv3TK4FGXN
JG+284q38yo6zlo64519C9n7ggfbe1wGwHw7rn76WsnK2s6S+Gb8Lu2irq2XhLgnFYl3BqUb
NtgidVNzcPqPbh3cuPUAL3xpe7bgdi8qmem4ieVi2yn2DUtoN3wu6kcWIb//EPN4qeR0Sms2
VJXQzWjgpbLju4q77a/GtZoJq82tg3lugrz/6EpTsyprFXeaxTO12HkD72vegbMY3LRWSr5y
4757JytrXjZ63p7mE27fftgk+hf1m/elZQ4AAA==

