Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVC2KRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVC2KRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 05:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVC2KRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 05:17:00 -0500
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:26296 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262324AbVC2KQY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 05:16:24 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: bktools::shortlog update
CC: matthias.andree@gmx.de, samel@mail.cz, linux-kernel@vger.kernel.org
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Tue,_29_Mar_2005_10_16_16_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20050329101616.EC5C378C87@merlin.emma.line.org>
Date: Tue, 29 Mar 2005 12:16:16 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK parent: http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.294, 2005-03-29 11:00:13+02:00, samel@mail.cz
  shortlog: add 15 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |   15 +++++++++++++++
 1 files changed, 15 insertions(+)

##### GNUPATCH #####
--- 1.259/shortlog	2005-03-25 06:37:16 +01:00
+++ 1.260/shortlog	2005-03-29 10:59:57 +02:00
@@ -193,6 +193,7 @@
 'aeb:cwi.nl' => 'Andries E. Brouwer',
 'aebr:win.tue.nl' => 'Andries E. Brouwer',
 'afleming:freescale.com' => 'Andy Fleming',
+'afong:org.rmk.(none)' => 'Amy Fong',
 'agk:redhat.com' => 'Alasdair G. Kergon',
 'agl:us.ibm.com' => 'Adam Litke',
 'agoddard:purdue.edu' => 'Alex Goddard',
@@ -498,6 +499,7 @@
 'brugolsky:telemetry-investments.com' => 'Bill Rugolsky',
 'bryan:staidm.org' => 'Bryan Rittmeyer',
 'bryder:paradise.net.nz' => 'Bill Ryder',
+'bstroesser:fijitsu-siemens.com' => 'Bodo Stroesser', # typo
 'bstroesser:fujitsu-siemens.com' => 'Bodo Stroesser',
 'buffer:antifork.org' => 'Angelo Dell\'Aera',
 'bugfixer:list.ru' => 'Nick Orlov',
@@ -744,9 +746,11 @@
 'dhowells:cambridge.redhat.com' => 'David Howells',
 'dhowells:redhat.com' => 'David Howells',
 'dhylands:com.rmk.(none)' => 'Dave Hylands',
+'dick:com.rmk.(none)' => 'Dick Hollenbeck',
 'didickman:yahoo.com' => 'Daniel Dickman',
 'diegocg:teleline.es' => 'Diego Calleja García',
 'dignome:gmail.com' => 'Lonnie Mendez',
+'dilinger:debian.org' => 'Andres Salomon',
 'dilinger:mp3revolution.net' => 'Andres Salomon',
 'dilinger:voxel.net' => 'Andres Salomon',
 'dimitry.andric:tomtom.com' => 'Dimitry Andric',
@@ -1043,6 +1047,7 @@
 'gtj.member:com.rmk.(none)' => 'George T. Joseph',
 'gtoumi:laposte.net' => 'Ghozlane Toumi',
 'gtw:cs.bu.edu' => 'Gary Wong',
+'gud:eth.net' => 'Amit Gud',
 'guido.barzini:com.rmk.(none)' => 'Guido Barzini',
 'guillaume.thouvenin:bull.net' => 'Guillaume Thouvenin',
 'guillaume:morinfr.org' => 'Guillaume Morin',
@@ -1124,6 +1129,7 @@
 'holt:sgi.com' => 'Robin Holt',
 'holzheu:de.ibm.com' => 'Michael Holzheu',
 'home:mdiehl.de' => 'Martin Diehl',
+'hong.liu:intel.com' => 'Hong Liu',
 'horms:verge.net.au' => 'Simon Horman',
 'horst.hummel:de.ibm.com' => 'Horst Hummel',
 'hpa:transmeta.com' => 'H. Peter Anvin',
@@ -1209,6 +1215,7 @@
 'jarkko.lavinen:nokia.com' => 'Jarkko Lavinen',
 'jason.d.gaston:intel.com' => 'Jason Gaston',
 'jason.davis:unisys.com' => 'Jason Davis',
+'jason:rightthere.net' => 'Jason Davis',
 'jasonuhl:sgi.com' => 'Jason Uhlenkott',
 'jasper:vs19.net' => 'Jasper Spaans',
 'javaman:katamail.com' => 'Paulo Ornati',
@@ -1871,6 +1878,7 @@
 'mkp:mkp.net' => 'Martin K. Petersen', # lbdb
 'mkrikis:yahoo.com' => 'Martins Krikis',
 'mlachwani:mvista.com' => 'Manish Lachwani',
+'mlafon:arkoon.net' => 'Mathieu Lafon',
 'mlang:delysid.org' => 'Mario Lang', # google
 'mlev:despammed.com' => 'Lev Makhlis',
 'mlindner:syskonnect.de' => 'Mirko Lindner',
@@ -2041,6 +2049,7 @@
 'patmans:ibm.com' => 'Patrick Mansfield',
 'patmans:us.ibm.com' => 'Patrick Mansfield',
 'patrick.boettcher:desy.de' => 'Patrick Boettcher',
+'patrick:bitwizard.nl' => 'Patrick van de Lageweg',
 'patrick:dreker.de' => 'Patrick Dreker', # lbdb
 'patrick:tykepenguin.com' => 'Patrick Caulfield',
 'patrick:wildi.com' => 'Patrick Wildi',
@@ -2093,6 +2102,7 @@
 'pepinto:student.dei.uc.pt' => 'Pedro Emanuel M. D. Pinto',
 'per.winkvist:telia.com' => 'Per Winkvist',
 'per.winkvist:uk.com' => 'Per Winkvist',
+'perchrh:pvv.org' => 'Per Christian Henden',
 'perex:perex.cz' => 'Jaroslav Kysela',
 'perex:petra.perex-int.cz' => 'Jaroslav Kysela', # guessed
 'perex:pnote.perex-int.cz' => 'Jaroslav Kysela',
@@ -2258,6 +2268,7 @@
 'richard.brunner:amd.com' => 'Richard Brunner',
 'richard.curnow:superh.com' => 'Richard Curnow',
 'richm:oldelvet.org.uk' => 'Richard Mortimer',
+'richtera:us.ibm.com' => 'Andy Richter',
 'ricklind:us.ibm.com' => 'Rick Lindsley',
 'riel:conectiva.com.br' => 'Rik van Riel',
 'riel:imladris.surriel.com' => 'Rik van Riel',
@@ -2460,6 +2471,7 @@
 'simon:thekelleys.org.uk' => 'Simon Kelley',
 'simonb:lipsyncpost.co.uk' => 'Simon Burley',
 'sivanich:sgi.com' => 'Dimitri Sivanich',
+'sj-netfilter:cookinglinux.org' => 'Samuel Jean',
 'sjackman:gmail.com' => 'Shaun Jackman',
 'sjean:cookinglinux.org' => 'Samuel Jean',
 'sjhill:realitydiluted.com' => 'Steven J. Hill',
@@ -2549,6 +2561,7 @@
 'stevef:steveft21.austin.ibm.com' => 'Steve French',
 'stevef:steveft21.ltcsamba' => 'Steve French',
 'stevel:mvista.com' => 'Steve Longerbeam',
+'steven:brudenell.name' => 'Steven Brudenell',
 'stewart:inverse.wetlogic.net' => 'Paul Stewart',
 'stewart:linux.org.au' => 'Stewart Smith',
 'stewart:wetlogic.net' => 'Paul Stewart',
@@ -2755,6 +2768,7 @@
 'vinay.nallamothu:gsecone.com' => 'Vinay K. Nallamothu',
 'vince:arm.linux.org.uk' => 'Vincent Sanders',
 'vince:kyllikki.org' => 'Vincent Sanders',
+'vince:org.rmk.(none)' => 'Vincent Sanders',
 'vinsci:floss.(none)' => 'Leonard Norrgard',
 'viro:math.psu.edu' => 'Alexander Viro',
 'viro:parcelfarce.linux.org.uk' => 'Alexander Viro',
@@ -2798,6 +2812,7 @@
 'weihs:linux1394.org' => 'Manfred Weihs',
 'wein:de.ibm.com' => 'Stefan Weinhuber',
 'wellnhofer:aevum.de' => 'Nick Wellnhofer',
+'wendyx:us.ibm.com' => 'Wen Xiong',
 'wensong:linux-vs.org' => 'Wensong Zhang',
 'wenxiong:us.ibm.com' => 'Wen Xiong',
 'werner:almesberger.net' => 'Werner Almesberger',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAPAqSUICA7VVYW/bNhD9bP0KAvngDa1lUjYli4CLNs3WpM2wIEG3faWls8VYIg2Ssp3C
P35HqY7ndR2wrbMFQ+Ld471770RfkJsrMfDGbmVdutcb0KtW6dhbqV0DXsaFaQ5vK6lX8AD+
kFCa4JclE5ry/JDkKecHSIDzYsrkIptlUCTRBfnowIpBI72vlHSx1KUFwPVr47wYrJp9XIbH
e2PwcexaB+M1WA31+PIDXqP+YeSNqV2EiXfSFxXZgnViwOLJ84p/2oAY3P/w7uPtm/soms/J
M1cyn0ffuC8nG6hfN1LVcfHpHM3pJOGUT7JJdkjDb3RFWJzkU0L5mE7GSU4YE5QKNnlBE7wh
Z5uRF4yMaHRJvjHjt1FBXGWsr81KEFmWhHGiYRduLTgHLvpAkO80je5O0kWjf/iJIipp9OrE
vjIN/In6kUbPnLMZzaYZmx0mLMv5YQm5XBYZzSWFUi7Kc3nOwEHqnM54zrMD4zyZdr4fM85s
/880or+n0TnO0kOSovq94yn9g+NU8Fzw7CuO8//N8q8Y3av1MxnZ3T5coz26fuzpX5h+w3JO
WDSUS6NXwthVbJt1/J02Gr4fkvkrMnzTPJEfMTh8Gd1wlACTF85bExhZsVSPyrt25BQ0oF1o
t4ddmtKQh2Pe8CW5CG+6iW5wUMMepSrWArO/qHeFATxk6hr0Aop1KJtN8x5SK9TRihIWSuoY
2X6mGM4mRx5kbRqjA4LRadfWqi0F+CrW4I/dKE/etWWXxJKOSoXdxbVqhdIe6lML17hOblXb
5SaMhdxH6YwWVq0qPBfBwmnn9yFCruRWuQ4wyyYB0NRBWiHt2hh9yv5J4rEKLbkN0ZCf0GmX
v5HeBmkWyu/UJ2nLWNc95K6PkK3UpARErmAHqx7bm7gBW1S2Epvt9iTOHVg8FqxyHjUj16BL
6AuGOUcQ7ll5sFK0LlaL5tQ+qvpE7vtoB5imSQC4xxG2sVQ1rqODZo2moDHt/lTzQTYt1OQ9
yL4U5514zsMWtFjYFjlAXccaX6fPiC5ELo+hDpbxLMC2Shfwl7P5S4hoj85jV7bTPZn1M7rD
Rp/2XzT1Kxb5TfXj/PwXVFQ4aK5t5imks2VKk+h3JK1tA1QHAAA=

