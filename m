Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbUKLKKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbUKLKKy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 05:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262492AbUKLKKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 05:10:54 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:39867 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262491AbUKLKKS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 05:10:18 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Fri,_12_Nov_2004_10_10_12_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041112101012.75819D590F@merlin.emma.line.org>
Date: Fri, 12 Nov 2004 11:10:12 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.242, 2004-11-12 11:09:06+01:00, matthias.andree@gmx.de
  shortlog:
    Fix Mans Rullgard's name.

ChangeSet@1.241, 2004-11-12 11:07:40+01:00, matthias.andree@gmx.de
  Cset exclude: samel@mail.cz|ChangeSet|20041109143708|65282

ChangeSet@1.240, 2004-11-12 11:07:08+01:00, matthias.andree@gmx.de
  Automerge

ChangeSet@1.237.1.8, 2004-11-12 07:35:28+01:00, samel@mail.cz
  shortlog: 8 new addresses + fix tytso's name

ChangeSet@1.237.1.7, 2004-11-09 15:37:08+01:00, samel@mail.cz
  shortlog: fix Mans Rullgard's name

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

##### GNUPATCH #####
--- 1.209.1.7/shortlog	2004-11-09 15:35:55 +01:00
+++ 1.214/shortlog	2004-11-12 11:08:46 +01:00
@@ -444,6 +444,7 @@
 'braunu:de.ibm.com' => 'Ursula Braun-Krahl',
 'brazilnut:us.ibm.com' => 'Don Fry',
 'brett:bad-sports.com' => 'Brett Pemberton',
+'breuerr:mc.net' => 'Bob Breuer',
 'brewt-linux-kernel:brewt.org' => 'Adrian Yee',
 'brian.haley:hp.com' => 'Brian Haley',
 'brian:rentec.com' => 'Brian Childs',
@@ -482,6 +483,7 @@
 'cananian:lesser-magoo.lcs.mit.edu' => 'C. Scott Ananian',
 'cannam:all-day-breakfast.com' => 'Chris Cannam',
 'car.busse:gmx.de' => 'Carsten Busse',	# verified by Greg KH
+'carlo:linux.it' => 'Carlo Perassi',
 'castet.matthieu:free.fr' => 'Matthieu Castet',
 'castor:3pardata.com' => 'Castor Fu',
 'cat:zip.com.au' => 'CaT',
@@ -1482,6 +1484,7 @@
 'luca.risolia:studio.unibo.it' => 'Luca Risolia',
 'luca:libero.it' => 'Luca Risolia',
 'lucasvr:terra.com.br' => 'Lucas Correia Villa Real', # google
+'luming.yu:intel.com' => 'Luming Yu',
 'lunz:falooley.org' => 'Jason Lunz',
 'luto:myrealbox.com' => 'Andy Lutomirski',
 'lxie:us.ibm.com' => 'Linda Xie',
@@ -1651,6 +1654,7 @@
 'miquels:cistron.nl' => 'Miquel van Smoorenburg',
 'mirage:kaotik.org' => 'Tiago Sousa',
 'mita:yacht.ocn.ne.jp' => 'Akinobu Mita',
+'mitch.a.williams:intel.com' => 'Mitch Williams',
 'mitch:sfgoth.com' => 'Mitchell Blank Jr.',
 'miura:da-cha.org' => 'Hiroshi Miura',
 'miurahr:nttdata.co.jp' => 'Hiroshi Miura',
@@ -1695,8 +1699,8 @@
 'mporter:kernel.crashing.org' => 'Matt Porter',
 'mroos:linux.ee' => 'Meelis Roos',
 'mrr:nexthop.com' => 'Mathew Richardson',
-'mru:inprovide.com' => 'Mans Rullgard',
-'mru:kth.se' => 'Mans Rullgard',
+'mru:inprovide.com' => 'Måns Rullgård',
+'mru:kth.se' => 'Måns Rullgård',
 'msdemlei:cl.uni-heidelberg.de' => 'Markus Demleitner',
 'msw:redhat.com' => 'Matt Wilson',
 'mufasa:sis.com.tw' => 'Mufasa Yang', # sent by himself
@@ -2219,11 +2223,13 @@
 'sridhar:dyn9-47-18-140.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:dyn9-47-18-86.beaverton.ibm.com' => 'Sridhar Samudrala',
 'sridhar:x1-6-00-10-a4-8b-06-f6.attbi.com' => 'Sridhar Samudrala',
+'sripathik:in.ibm.com' => 'Sripathi Kodi',
 'srk:thekelleys.org.uk' => 'Simon Kelley',
 'srompf:isg.de' => 'Stefan Rompf',
 'sryoungs:au.rmk.(none)' => 'Steve Youngs', # guessed
 'sryoungs:bigpond.net.au' => 'Steve Youngs', # GnuPG key servers
 'stanley.wang:linux.co.intel.com' => 'Stanley Wang',
+'starvik:axis.com' => 'Mikael Starvik',
 'stefan.becker:nokia.com' => 'Stefan Becker',
 'stefan.eletzhofer:eletztrick.de' => 'Stefan Eletzhofer',
 'steiner:sgi.com' => 'Jack Steiner',
@@ -2393,9 +2399,10 @@
 'tvrtko:net4u.hr' => 'Tvrtko A. Ursulin',
 'twaugh:redhat.com' => 'Tim Waugh',
 'typhoon.adm:hostme.bitkeeper.com' => 'Dave Dillow', # himself on lk
-'tytso:mit.edu' => "Theodore Y. T'so", # web.mit.edu/tytso/www/home.html
-'tytso:snap.thunk.org' => "Theodore Y. T'so",
-'tytso:think.thunk.org' => "Theodore Y. T'so", # guessed
+'tytso:mit.edu' => "Theodore Y. Ts'o", # web.mit.edu/tytso/www/home.html
+'tytso:snap.thunk.org' => "Theodore Y. Ts'o",
+'tytso:think.thunk.org' => "Theodore Y. Ts'o", # guessed
+'tytso:thunk.org' => "Theodore Ts'o",
 'u233:shaw.ca' => 'Trent Whaley',
 'uaca:alumni.uv.es' => 'Ulisses Alonso Camaró',
 'umka:namesys.com' => 'Yury Umanets',
@@ -2465,6 +2472,7 @@
 'wein:de.ibm.com' => 'Stefan Weinhuber',
 'wellnhofer:aevum.de' => 'Nick Wellnhofer',
 'wensong:linux-vs.org' => 'Wensong Zhang',
+'wenxiong:us.ibm.com' => 'Wen Xiong',
 'werner:almesberger.net' => 'Werner Almesberger',
 'wes:infosink.com' => 'Wes Schreiner',
 'wesolows:foobazco.org' => 'Keith M. Wesolowski',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAASMlEECA9VYXXPaOhB9jn6FpnngIUVIsvw5QydN0tubSTM3k7TT9lHYCnjwByPZgdzh
7/Z/XMk2EEhI4jZMboAZg7Urds/ZXR3Yh6cnwV6RyxueROpwIrJhGWeokDxTqSg4CvN0fjzi
2VBciWJOMab6SaiFHdufU9+x7bmgwrZDRvjA9VwRUrAPvykhg72UF8Uo5grxLJJC6Pt/56oI
9obpDEXm42We64+9Gy57g7gYCzERsnd01h0LmYmkW+R5ooC2u+BFOII3QqpgjyBreae4nYhg
7/LT529fPl4C0O/DZaiw3wcvnNZGOod1GuvbMEKwjz1GsT3H2GEuOIEEUctFBLkQsx4hPexD
YgeWG2DvAJMAY6h4KpLDlMcJCv+FBwR2MTiCLxz+MQihGuWySPJhAK/jGTzX28HLMkmGXEYd
BTMdBjiDjk09Ci5WWIJuywcAmGPwYZXBKE/FRviLUOrobeJhl7nEm1vE9e35tfD5dehin2MR
8UG0DtGacwU5YZatk2aUYQrAuvF9grS1i715neiKIK8hiFCI3cCyA/qKBHkwE1PII11qSgkF
DyrKittC5etU4TdFFaHYsZjtzLGlKQN3enQS+i5GuYoSlMvhQ6zZlm+5uq1ch9WsMbxijGii
7rTUw826S+o+loWGTg4FiGGrAnzKvIJMW85rtjXr1AXn7Zz+ZyWyZZTeqxWiydY4NbXyzAG8
csMGqbpSyGalMPxqlXKs9PkkZmFSRiJoVyuGfG+NzVm7Dd4Y+Qxr8h3qtyTfuGGDVE0+XSff
D7DzauQvJ7x+D+FfW45hZJi2nDfctx4zM953rEqXLSzWZNkfxwOeF89SkTFq+05dE9i/r8js
wLa3HvhkN+XwiA6rxcw/sCunM/PqznQ5LFL7jWo4IY7vQQJOm2snlWUQZxOZ38SRMBl0YP8D
7KyH835TTj2uvVbgbqgpFtjOFnA1utZu0H2WiKoOl5eD+ZQxx6A7kKIUUgZpiDJR1NAe5QN4
VN3XuJ4yjxnDkMskD5I4K2cobgyPzT14ISRXKja2pDFOyjTOhujWMFeIZMXal2oB/iwra8e2
KoZj/TMJcTSNkyTmqdp0Ojfr8HuzajwppcR4KhlPuO6tsXZB8SBd+Vw1K/Asj+LGpUpYFVze
aAc+i9XdrxhzkcCrelHbn1A9FaCl/Sxdhgx0KjoCHSoSUVk5vfs6EnmUSwF/IvhVdfJ37+E+
nIoBaqx6lU9vOp32qiEyKtJksZHK+AQVozIbGx25bb+FtU5EGz5prr9+WJoailaOD7s0259S
5rgGlanIZnGeDYNSreP4XWTwh1kxLbZVBt/vNqOCnbujjNDWKhjvVAXDSgZH94Tt45MjbvXD
oWnb81ZOL9fk4LcUbE2X1VqK7o6uT7UKNXAalbUNoFkrJncM51IT1nCydTi9gD0l7ijs0t3A
+Zicq7TQS57mLqaQ6lnvYktft57mvxbh/KpO88puXIyQEg8bLP9dC0ciHKsy7VN3YA2oI8B/
Ci2P+i4UAAA=

