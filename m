Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131702AbRCQQnq>; Sat, 17 Mar 2001 11:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131707AbRCQQni>; Sat, 17 Mar 2001 11:43:38 -0500
Received: from uucp.nl.uu.net ([193.79.237.146]:4086 "EHLO uucp.nl.uu.net")
	by vger.kernel.org with ESMTP id <S131702AbRCQQnX>;
	Sat, 17 Mar 2001 11:43:23 -0500
Date: Sat, 17 Mar 2001 17:29:35 +0100 (CET)
From: kees <kees@schoen.nl>
To: linux-kernel@vger.kernel.org
Subject: [OT] how to catch HW fault
Message-ID: <Pine.LNX.4.21.0103171727490.4060-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm getting mad because of random freezes of my system. Linux-2.2.19pre7
on MSI 694D dual PIII(677MHz) 128 MB, no OC. I tried to isolate the
problem with replacing cards (S3 video, 3com 59X, ES1373 and
AIC7xxx) didn't solve anything. Even in initlevel 1 with only a videocard
the freeze happens. It is a total lockup, no SYSRQ , no ping from network,
nothing in the logs. A freeze may happen 4 times in a hour or once in 2
weeks. I have the same mobo and PIII's at home without the slightest
problems. Who knows of a suitable diagnostics to track this down?
regards
Kees



