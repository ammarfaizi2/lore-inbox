Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbREZRiO>; Sat, 26 May 2001 13:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbREZRiE>; Sat, 26 May 2001 13:38:04 -0400
Received: from cx197852-b.mrdn1.ct.home.com ([24.18.134.249]:37641 "EHLO
	ezri.cyrion.net") by vger.kernel.org with ESMTP id <S261819AbREZRhw>;
	Sat, 26 May 2001 13:37:52 -0400
Date: Sat, 26 May 2001 13:37:52 -0400 (EDT)
From: Peter DiCostanzo Jr <peter.dicostanzo@broadband.att.com>
X-X-Sender: <neuonyx@moebius.cyrion.net>
To: <linux-kernel@vger.kernel.org>
Subject: cb_enabler.o / 2.4.5 kernel
Message-ID: <Pine.GSO.4.33.0105261332490.12683-100000@moebius.cyrion.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a xircom cardbus card, that is not working unless i put it in
promisc mode.. i got a patch to fix it but it seems its already in
there... i did notice however, that using the same kernelconfig as my
2.4.4 kernel that cb_enabler.o is not being installed.  A BROKEN symlink
exists in /lib/modules/2.4.5/pcmcia/cb_enabler.o ->
../kernel/drivers/pcmcia/cb_enabler.o  Anyone know why its not being
installed?  (Its under a RH 7.1 box.. the 2.4.4 kernel was fine.)

thanks!
-pete

