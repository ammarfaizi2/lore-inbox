Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314409AbSDVScN>; Mon, 22 Apr 2002 14:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314411AbSDVScM>; Mon, 22 Apr 2002 14:32:12 -0400
Received: from pD952AA10.dip.t-dialin.net ([217.82.170.16]:19590 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S314409AbSDVScL>; Mon, 22 Apr 2002 14:32:11 -0400
Date: Mon, 22 Apr 2002 12:31:57 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@bonn-fries.net>
cc: lm@bitmover.com, <linux-kernel@vger.kernel.org>
Subject: Re: BK, deltas, snapshots and fate of -pre...
In-Reply-To: <5.1.0.14.2.20020422191715.03cf1e70@pop.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.44.0204221229440.3714-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could please someone have this patch applied instead of arguing all day
and all of the night?

Regards,
Thunder

--- bk-kernel-howto.txt~	Mon Apr 22 12:26:50 2002
+++ bk-kernel-howto.txt	Mon Apr 22 12:26:11 2002
@@ -15,6 +15,14 @@
 "bk help <command>" or in X "bk helptool <command>" for reference
 documentation.
 
+    Also, BitKeeper is not free software.  You may use it for free, subject
+    to the licensing rules (bk help bkl will display them), but it is
+    not open source.  If you feel strongly about 100% free software
+    tool chain, then don't use BitKeeper.  Linus has repeatedly stated
+    that he will continue to accept and produce traditional "diff -Nur"
+    style patches.  It is explicitly not a requirement that you use
+    BitKeeper to do kernel development, people may choose whatever tool
+    works best for them.
 
 BitKeeper Concepts
 ------------------

-- 
                                                  Thunder from the hill.
Not a citizen of any town.                   Not a citizen of any state.
Not a citizen of any country.               Not a citizen of any planet.
                         Citizen of our universe.

