Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbTFUHg1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 03:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbTFUHg1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 03:36:27 -0400
Received: from mail.hometree.net ([212.34.181.120]:15273 "EHLO
	mail.hometree.net") by vger.kernel.org with ESMTP id S265086AbTFUHgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 03:36:25 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: "Henning P. Schmiedehausen" <hps@intermeta.de>
Newsgroups: hometree.linux.kernel
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Date: Sat, 21 Jun 2003 07:50:27 +0000 (UTC)
Organization: INTERMETA - Gesellschaft fuer Mehrwertdienste mbH
Message-ID: <bd12o3$5t5$2@tangens.hometree.net>
References: <063301c32c47$ddc792d0$3f00a8c0@witbe> <1056027789.3ef1b48d3ea2e@support.tuxbox.dk> <03061908145500.25179@tabby> <20030619141443.GR29247@fs.tum.de> <bcsolt$37m$2@news.cistron.nl> <20030619165916.GA14404@work.bitmover.com> <20030620001217.G6248@almesberger.net> <20030620120910.3f2cb001.skraw@ithnet.com> <20030620142436.GB14404@work.bitmover.com> <20030620162719.GA4368@hh.idb.hist.no>
Reply-To: hps@intermeta.de
NNTP-Posting-Host: forge.intermeta.de
X-Trace: tangens.hometree.net 1056181827 6053 212.34.181.4 (21 Jun 2003 07:50:27 GMT)
X-Complaints-To: news@intermeta.de
NNTP-Posting-Date: Sat, 21 Jun 2003 07:50:27 +0000 (UTC)
X-Copyright: (C) 1996-2003 Henning Schmiedehausen
X-No-Archive: yes
User-Agent: nn/6.6.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting <helgehaf@aitel.hist.no> writes:

>So Sun spends more on Solaris than all open source together, and
>still can't match linux wich only is a part of open source.
>Dreaming up stuff isn't enough - some of the novelty lies in
>a working good implemetation, not merely in the original abstract idea.
>Ideas tend to lack in practical detail.

Give me a well working multipath FC implementation. Go Gigabit
Ethernet. Go USB. Go IEEE1394. Go DRM. Go "any new technology that's
beyond the level of a printer port".
Compare Linux vs. Solaris. Rinse. Repeat.

Most of the stuff in the Linux kernel (and Userland) is marked as
"Version 0.1. 0.7beta. alpha-release. 0.2.1testing. 1.2-pre". And so
on. You won't find many OpenSource developers that call their product
"Version 3.1" Because they're afraid to bite the bullet a do a
release.  With a commercial OS, you get a release version on which you
can build. Sure it has bugs. Sure, some of the code _is_ alpha
quality. But that's what a vendor is for.

>I don't think open source is so parasitic.  Commercial software
>have a head start, open software is still catching up in many fields.

No it does not. It simply has no political or ideological reasons not
to talk to other companies, sign NDAs and spend money.  If Sun wants a
"state of the art" driver for nVidia chips, they call nVidia, draft up
an agreement, get access to the nVidia docs and build such a
driver. The main problem of the "open-source" movement is that
"beggars" attitute. If it costs money, we won't use it.

Look how long it took Linux to get a really decent driver for the
eepro100 chips, which are commodities parts these days. And only after
Intel finally decided that there is no more interesting IP in the docs
and released them for free.

Check the level of support of _current_ graphics chips in Linux. You
get a halfway decent ATI support, "bad, bad, bad closed source" but
performance-wise very good nVidia support and Matrox is a bad joke
(judging from my experience of trying to get a G550 with DVI running).

	Regards
		Henning

-- 
Dipl.-Inf. (Univ.) Henning P. Schmiedehausen          INTERMETA GmbH
hps@intermeta.de        +49 9131 50 654 0   http://www.intermeta.de/

Java, perl, Solaris, Linux, xSP Consulting, Web Services 
freelance consultant -- Jakarta Turbine Development  -- hero for hire

--- Quote of the week: "Never argue with an idiot. They drag you down
to their level, then beat you with experience." ---

