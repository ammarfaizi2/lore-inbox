Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261472AbULTJxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261472AbULTJxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 04:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbULTJxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 04:53:54 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:27837 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261472AbULTJxu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 04:53:50 -0500
MIME-Version: 1.0
To: torvalds@osdl.org
Subject: BK-kernel-tools/shortlog update
Cc: linux-kernel@vger.kernel.org, matthias.andree@gmx.de, samel@mail.cz
From: Matthias Andree <matthias.andree@gmx.de>
Content-ID: <Mon,_20_Dec_2004_09_53_46_+0000_0@merlin.emma.line.org>
Content-Type: text/plain; charset=US-ASCII
Content-Description: An object packed by metasend
Content-Transfer-Encoding: 7BIT
Message-Id: <20041220095346.4D7F477914@merlin.emma.line.org>
Date: Mon, 20 Dec 2004 10:53:46 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

you can either use "bk receive" to patch with this mail,
or you can
Pull from: bk://krusty.dt.e-technik.uni-dortmund.de/BK-kernel-tools
or in cases of dire need, you can apply the patch below.

BK: Parent repository is http://bktools.bkbits.net/bktools

Patch description:
ChangeSet@1.253, 2004-12-20 07:13:44+01:00, samel@mail.cz
  shortlog: added 2 new addresses

Matthias

------------------------------------------------------------------------

##### DIFFSTAT #####
 shortlog |    2 ++
 1 files changed, 2 insertions(+)

##### GNUPATCH #####
--- 1.224/shortlog	2004-12-16 07:22:04 +01:00
+++ 1.225/shortlog	2004-12-20 07:13:21 +01:00
@@ -1878,6 +1878,7 @@
 'paul:kungfoocoder.org' => 'Paul Wagland', # lbdb
 'paul:serice.net' => 'Paul Serice',
 'paul:wagland.net' => 'Paul Wagland', # lbdb
+'pauld:egenera.com' => 'Philip R. Auld',
 'paulkf:microgate.com' => 'Paul Fulghum',
 'paulm:routefree.com' => 'Paul Mielke',
 'paulmck:us.ibm.com' => 'Paul E. McKenney',
@@ -2107,6 +2108,7 @@
 'rostedt:goodmis.org' => 'Steven Rostedt',
 'rover:tob.ru' => 'Sergei Golod',
 'rpjday:mindspring.com' => 'Robert P. J. Day',
+'rpurdie:net.rmk.(none)' => 'Richard Purdie',
 'rread:clusterfs.com' => 'Robert Read',
 'rsa:us.ibm.com' => 'Ryan S. Arnold',
 'rscott:attbi.com' => 'Rob Scott',



##### BKPATCH #####

## Wrapped with gzip_b64 ##
H4sIACqhxkECA7WT7WrbMBSGf0dXcaA/stHZkeRPGVz6NbbQwUJGL0CxTmMT2zKSkqbDFz8n
oSkp22BbZxsjyecVj86Dz2B6m42cNhtZK3vZYbtcV63vjGxtg076hW76m1K2S/yGrueU8uFm
PKBxJHou4ijqkWMUFSGTiyRNsODkDO4tmmzUSOfKSlpftsogDuuftXXZaNlsfbWbzrUeppON
NJNF5VaIHZrJ9Z23QtNi7Tmta0uGupl0RQkbNDYbMT84rrinDrPR/OOn+y9Xc0LyHI6okOfk
jY9lZYP1ZSOr2i++n6ZDxllMY86Z6OOIp4zcAvN5FAANJ4xPOAWaZCzIwvCcsoxSONkMzhl4
lFzDGxPfkAJsqY2r9TIDqRQq4NDi425s0Fq05A4OwLOX3hHvDy9CqKTk4gW/1A2+Yn/mOKBH
LKVJmLC0D1giov4BhXwoEiokRSUX6rQ/J+Gh18M7ZgFnPRVUiL3454oT7/+MQX6LcVBOw54y
IfhBOY9eK+fs58r5f1P+K9H7Zn0Fzzxud4+3HaQ/H+kvnE9ZmlJgZNzJda0yXGKLZk89hvwC
xrOyqqsO5j5cDd/HH8iUMyp2AdOtjaowa9H5pln571rd4vtDal4VpTQKZvuSIXX824sSi5Vd
N7kMgoAvCiQ/AGa+lSu+BAAA

