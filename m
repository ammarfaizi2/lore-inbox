Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbULWKwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbULWKwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 05:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbULWKwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 05:52:44 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:65163 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261202AbULWKw1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 05:52:27 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Thu,_23_Dec_2004_10_52_22_+0000_0@merlin.emma.line.org>
Content-type: text/plain; charset=iso-8859-1
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 8BIT
Message-Id: <20041223105223.2226378B19@merlin.emma.line.org>
Date: Thu, 23 Dec 2004 11:52:23 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.254, 2004-12-23 09:09:25+01:00, samel@mail.cz
  shortlog: added 2 new addresses

ChangeSet@1.253, 2004-12-20 07:13:44+01:00, samel@mail.cz
  shortlog: added 2 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    4 ++++
 1 files changed, 4 insertions(+)

##### GNUPATCH #####
--- 1.224/shortlog	2004-12-16 07:22:04 +01:00
+++ 1.226/shortlog	2004-12-23 09:09:10 +01:00
@@ -734,6 +734,7 @@
 'drow:nevyn.them.org' => 'Daniel Jacobowitz',
 'drzeus-list:cx.rmk.(none)' => 'Pierre Ossman',
 'drzeus-list:drzeus.cx' => 'Pierre Ossman',
+'drzeus:cx.rmk.(none)' => 'Pierre Ossman',
 'ds-fraser:comcast.net' => 'Douglas Fraser',
 'dsaxena:com.rmk' => 'Deepak Saxena',
 'dsaxena:com.rmk.(none)' => 'Deepak Saxena',
@@ -1878,6 +1879,7 @@
 'paul:kungfoocoder.org' => 'Paul Wagland', # lbdb
 'paul:serice.net' => 'Paul Serice',
 'paul:wagland.net' => 'Paul Wagland', # lbdb
+'pauld:egenera.com' => 'Philip R. Auld',
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
 'paulmck:us.ibm.com' => 'Paul E. McKenney',
@@ -2062,6 +2064,7 @@
 'riel:redhat.com' => 'Rik van Riel',
 'riel:surriel.com' => 'Rik van Riel',
 'rjweryk:uwo.ca' => 'Rob Weryk',
+'rkagan:mail.ru' => 'Roman Kagan',
 'rl:hellgate.ch' => 'Roger Luethi',
 'rlievin:free.fr' => 'Romain Liévin',
 'rlrevell:joe-job.com' => 'Lee Revell',
@@ -2107,6 +2110,7 @@
 'rostedt:goodmis.org' => 'Steven Rostedt',
 'rover:tob.ru' => 'Sergei Golod',
 'rpjday:mindspring.com' => 'Robert P. J. Day',
+'rpurdie:net.rmk.(none)' => 'Richard Purdie',
 'rread:clusterfs.com' => 'Robert Read',
 'rsa:us.ibm.com' => 'Ryan S. Arnold',
 'rscott:attbi.com' => 'Rob Scott',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIAGajykECA9WVa2vbMBSGP0e/QtAP2ejiHMlXCVJ6G1vpoCGjP0CxTmMTX4LktFnxj58v
S0uyG90y6GxhdDlHvHofHXxEry7loCrNvcq0PV1hsVinhVMZVdgcK+XEZV5fJKpY4Gesag7A
m5dxFwJf1FwEvl8jR9+PPabmYRRizMkRvbVo5CBXVZWkyjqq0Aaxmf9Y2koOFvnG0e1wVpbN
cHyvzHieVkvEFZrx+fVoiabAbFSVZWZJEzdVVZzQezRWDpjjPs1UX1YoB7P3H24/nc0ImUzo
k1Q6mZADH8uqHLPTXKWZEz/uZnuMswACzpmoA59HjFxS5nDfpeCNGR9zoBBK5krPOwYmAejO
ZvSY0RGQc3pgxRckpjYpTZWVC0mV1qgppwU+tH2D1qIl17QXPH32joxe+BACCsjJs/ykzHFP
+1ZHL91nEYReyKLaZaHw6zsU6i4OQShAreZ615+d5Mbr5hswl7MaBAhBfkOmj/a8HTLelkyD
SMimcf9Vkgmj/4uMCxEIBjXzPZ91JbmN2KnIv5ZBfimjL0bwamBC8B459/eLkbMfI+f/DPnP
QHfX+IaOzMOmbaNNA317pD9gfsWiCCgjw5VaZ1riAgs0neohnZzQ4TRJs3RFZw49a9aH78gV
ZyDaBLNaG52iLLByTL503hRlgW/7rFkaJ8poOu1CmizykiLtGQT7ZcfgtTDob+wBIYRu0Fqq
zSOurYw33xk6TdEYpDfW5qroKDTaOwpLtVCF7Mww62/ul00QvW4XWuu3v8A4wXhp1/lEz8GF
eO6Sr6cayRrTBwAA

