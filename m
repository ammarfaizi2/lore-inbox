Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314859AbSDVWb1>; Mon, 22 Apr 2002 18:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314876AbSDVWb0>; Mon, 22 Apr 2002 18:31:26 -0400
Received: from pD952AA44.dip.t-dialin.net ([217.82.170.68]:7821 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314859AbSDVWbX>; Mon, 22 Apr 2002 18:31:23 -0400
Date: Mon, 22 Apr 2002 16:31:15 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Jeff Garzik <garzik@havoc.gtf.org>
cc: Larry McVoy <lm@bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: Remove Bitkeeper documentation from Linux tree
In-Reply-To: <20020422155223.B20999@havoc.gtf.org>
Message-ID: <Pine.LNX.4.44.0204221624300.3714-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry, I haven't checked email for a while. Putting this into an
external readme file might still leave some people complaining,
but if you wish I could do that either.
The last version was more or less a cut and paste from Larry, this one is 
a little edited...

Regards,
Thunder

diff -u bk-kernel-howto.txt~ bk-kernel-howto.txt
--- bk-kernel-howto.txt~	Mon Apr 22 16:11:37 2002
+++ bk-kernel-howto.txt	Mon Apr 22 16:15:35 2002
@@ -15,6 +15,15 @@
 "bk help <command>" or in X "bk helptool <command>" for reference
 documentation.
 
+    Also notice that BitKeeper  is not free software. You may use it
+    for free, subject  to the licensing rules  you can download from
+    <URL:http://www.bitkeeper.com/manpages/bk-blk-1.html>, but it is
+    not open source.  If you feel  strongly about 100% free software
+    tool chain, then don't use BitKeeper.  Linus has made very clear
+    that he will continue to accept and produce traditional "diff -Nur"
+    style patches.  It is explicitly not a  requirement that you use
+    BitKeeper to do  kernel development,  people may choose whatever
+    tool works best for them.
 
 BitKeeper Concepts
 ------------------

-- 
                                                  Thunder from the hill.
Not a citizen of any town.                   Not a citizen of any state.
Not a citizen of any country.               Not a citizen of any planet.
                         Citizen of our universe.

