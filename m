Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVAJS13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVAJS13 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 13:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbVAJSZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 13:25:51 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:36068 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262428AbVAJSWz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 13:22:55 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon,_10_Jan_2005_18_22_48_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050110182248.C02E678D9A@merlin.emma.line.org>
Date: Mon, 10 Jan 2005 19:22:48 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.259.1.1, 2005-01-10 13:35:36+01:00, samel@mail.cz
  shortlog: added 9 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    9 +++++++++
 1 files changed, 9 insertions(+)

##### GNUPATCH #####
--- 1.229/shortlog	2005-01-07 16:09:03 +01:00
+++ 1.230/shortlog	2005-01-10 13:35:16 +01:00
@@ -415,6 +415,7 @@
 'bergner:brule.rchland.ibm.com' => 'Peter Bergner',
 'bergner:cannon.rchland.ibm.com' => 'Peter Bergner',
 'bergner:vnet.ibm.com' => 'Peter Bergner',
+'bernard:blackham.com.au' => 'Bernard Blackham',
 'bernhard.kaindl:gmx.de' => 'Bernhard Kaindl',
 'bernie:develer.com' => 'Bernardo Innocenti',
 'berny.f:aon.at' => 'Bernhard Fischer',
@@ -618,6 +619,7 @@
 'dale:farnsworth.org' => 'Dale Farnsworth',
 'dalecki:evision-ventures.com' => 'Martin Dalecki',
 'dalecki:evision.ag' => 'Martin Dalecki',
+'dalto:austin.ibm.com' => 'Dave Altobelli',
 'damien.morange:hp.com' => 'Damien Morange',
 'dan.zink:hp.com' => 'Dan Zink',
 'dan:debian.org' => 'Daniel Jacobowitz',
@@ -1159,6 +1161,7 @@
 'jdike:karaya.com' => 'Jeff Dike',
 'jdike:uml.karaya.com' => 'Jeff Dike',
 'jdittmer:ppp0.net' => 'Jan Dittmer',
+'jdittmer:sfhq.hn.org' => 'Jan Dittmer',
 'jdmason:us.ibm.com' => 'Jon Mason',
 'jdow:earthlink.net' => 'Joanne Dow',
 'jdr:farfalle.com' => 'David Ruggiero',
@@ -1228,6 +1231,7 @@
 'jim.houston:ccur.com' => 'Jim Houston',
 'jim.houston:comcast.net' => 'Jim Houston',
 'jim:hamachi.net' => 'Jim Collette',
+'jim:jtan.com' => 'Jim Paris',
 'jk:ozlabs.org' => 'Jeremy Kerr',
 'jkenisto:us.ibm.com' => 'James Keniston',
 'jkluebs:com.rmk.(none)' => 'John K. Luebs',
@@ -1351,6 +1355,7 @@
 'kalev:smartlink.ee' => 'Kalev Lember',
 'kalin:thinrope.net' => 'Kalin Rumenov Kozhuharov',
 'kambo77:hotmail.com' => 'Kambo Lohan',
+'kamezawa.hiroyu:jp.fujitsu.com' => 'Kamezawa Hiroyuki',
 'kaneshige.kenji:jp.fujitsu.com' => 'Kenji Kaneshige', # lbdb
 'kanoj:vger.kernel.org' => 'Kanoj Sarcar', # sent by Arnaldo Carvalho de Melo
 'kanojsarcar:yahoo.com' => 'Kanoj Sarcar',
@@ -1972,6 +1977,7 @@
 'peter:chubb.wattle.id.au' => 'Peter Chubb',
 'peter:developers.dk' => 'Peter Christensen',
 'peter:pantasys.com' => 'Peter Buckingham',
+'peter:programming.kicks-ass.net' => 'Peter Zijlstra',
 'peter_pregler:email.com' => 'Peter Pregler',
 'peterc:au.rmk.(none)' => 'Peter Chubb',
 'peterc:chubb.wattle.id.au' => 'Peter Chubb',
@@ -2038,6 +2044,7 @@
 'pragnesh.sampat:timesys.com' => 'Pragnesh Sampat',
 'praka:pobox.com' => 'Andrew Vasquez',
 'praka:users.sourceforge.net' => 'Andrew Vasquez',
+'prarit:sgi.com' => 'Prarit Bhargava',
 'prasanna:in.ibm.com' => 'Prasanna S. Panchamukhi', # lbdb
 'pratik.solanki:timesys.com' => 'Pratik Solanki',
 'prof.bj:freemail.hu' => 'Prof. BJ',
@@ -2047,6 +2054,7 @@
 'proski:org.rmk.(none)' => 'Pavel Roskin',
 'psimmons:flash.net' => 'Patrick Simmons',
 'ptiedem:de.ibm.com' => 'Peter Tiedemann',
+'ptushnik:gmail.com' => 'Vasia Pupkin',
 'purna:jcom.home.ne.jp' => 'Yusuf Wilajati Purna',
 'pwaechtler:mac.com' => 'Peter Wächtler',
 'pwil3058:bigpond.net.au' => 'Peter Williams',
@@ -2301,6 +2309,7 @@
 'simon:thekelleys.org.uk' => 'Simon Kelley',
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'sivanich:sgi.com' => 'Dimitri Sivanich',
+'sjackman:gmail.com' => 'Shaun Jackman',
 'skewer:terra.com.br' => 'Marcelo Abreu',
 'skip.ford:verizon.net' => 'Skip Ford',
 'skolodynski:com.rmk.(none)' => 'Slawomir Kolodynski',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAPjH4kECA7VVXW/TMBR9rn+FJR72MOra+Wwsddq6IdgGohqCB95uEy9xm49iO/tA+fE4
8brSIZDGIMlD7HuOe+4996av8PkZH5lG3UCZ6eONqPNW1sQoqHUlDJC0qbrTAupcfBKm8yj1
7M08n0Zh0nlJFIad8EQYpgGDZTyNReqhV/izFoqPKjCmkKAJ1JkSwu6/a7Tho7y6I1m/vGoa
u5zoVovJWqhalJP5pX3GbjE2TVNqZIELMGmBb4TSfMSI/7hj7jeCj67evP38/uQKodkMP2rF
sxn6x3lpqER5XIEsSfp9nx1SRmMW0oQlXRR4iY/OMCNemBBGGKbhhLIJo5j53A+5Hx1SxinF
ewfiQ4bHFM3xP1Z9ilKsi0aZssk5hiwTGU5wLW77dyW0Fhpd4ijwKUOLXf3Q+JkXQhQoOtrJ
L5pKPNG+1eGkh2xK4yBm085ncRJ21yKB6zSmCVCRwTLbr88e2dab9YmHLOr8YDoN0U9mb9Ik
pqTRWUkalf9q1NSjfuRHXZ+z54yKfjYp4WzKPf/BpCddfOy6Fx/S/+bWSWts6VQukMR/7jlX
g4dUmLORUfThebSXud5P3daavaF7sf/oj/67eaN+Z1+TwNno06ezxn4za8l/c+93E+ba9CMe
q9u7/hnf2cJvc/qLup8HLMYMHSzttxJUxpclpOsCql44gfYAz47wwdwF8fwhePAanUce7XkZ
lKbh0Gpj05bLgedIZ3Aj8ImNLkVZyp7CmB0Qy1ll0hjbmlxfF99IUffz5TgXUOMzFxwIvRU9
QVZ8ZaDeHX4hK/vxVlIPMNuFPWxtzfkOt0AKqZr7lq825LpdSaPbHfHyAYPfDZi1E5bEQX/A
RhiraqOaXEFVyTona5mu9Ri0JrUw7oRFD8Jf5arU1uae7tFgkLlRVpHhOpe731sMe3hegMrh
ZgtPBrhpdVHLNc9dP20pX0BLwIt2s5b1gPfpkJ5e2epXUD/FfyqgrfGFC1rC4/9aWgirvq1m
WegBnQqKfgBencT8qQcAAA==

