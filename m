Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263171AbTCYRdo>; Tue, 25 Mar 2003 12:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263156AbTCYRbv>; Tue, 25 Mar 2003 12:31:51 -0500
Received: from scaup.mail.pas.earthlink.net ([207.217.120.49]:55717 "EHLO
	scaup.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S263125AbTCYRai>; Tue, 25 Mar 2003 12:30:38 -0500
Date: Tue, 25 Mar 2003 10:32:11 -0800 (PST)
From: James Simmons <jsimmons@infradead.org>
X-X-Sender: <jsimmons@maxwell.earthlink.net>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BK FBDEV] A few more updates.
Message-ID: <Pine.LNX.4.33.0303251031180.4272-100000@maxwell.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull http://fbdev.bkbits.net/fbdev-2.5

This will update the following files:

 drivers/video/aty/aty128fb.c  |   16 +++++++---------
 drivers/video/console/fbcon.c |    4 ++--
 drivers/video/controlfb.c     |   18 +++---------------
 drivers/video/platinumfb.c    |   28 ++++++++--------------------
 drivers/video/radeonfb.c      |   10 ++++++++++
 drivers/video/softcursor.c    |    2 +-
 6 files changed, 31 insertions(+), 47 deletions(-)

through these ChangeSets:

<jsimmons@maxwell.earthlink.net> (03/03/25 1.981)
   [FBCON] Could be called outside of a process context. This fixes that.

<jsimmons@maxwell.earthlink.net> (03/03/25 1.979)
   [RAGE 128/CONTROL/PLATNIUM FBDEV] PPC updates.

   [RADEON FBDEV] PLL fix for specific type of card.


