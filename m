Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbRCGFsz>; Wed, 7 Mar 2001 00:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130264AbRCGFsq>; Wed, 7 Mar 2001 00:48:46 -0500
Received: from falcon.prod.itd.earthlink.net ([207.217.120.74]:63943 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S130216AbRCGFsb>; Wed, 7 Mar 2001 00:48:31 -0500
Date: Tue, 6 Mar 2001 13:48:59 -0800 (PST)
From: James Simmons <jsimmons@linux-fbdev.org>
X-X-Sender: <jsimmons@linux.local>
To: John R Lenton <john@grulic.org.ar>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        FrameBuffer List <linux-fbdev@vuser.vu.union.edu>
Subject: Re:IMS Twin Turbo 128 framebuffer
Message-ID: <Pine.LNX.4.31.0103061346370.1197-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Is there any particular reason why imsttfb isn't available in the
>i386 arch?
>
>It doesn't work in X either in spite of being "supported", but
>that's not for this list.

I had this card while working at suse and I did try to get it to work on
ix86. The problem is the card is initialzed by its firmware which is forth
since this is a Apple card. As for getting the detail specs to get it to
work on ix86 (making it firmware independent) good luck. You will have to
suck the info from the deeps pits of apple.

MS: (n) 1. A debilitating and surprisingly widespread affliction that
renders the sufferer barely able to perform the simplest task. 2. A disease.

James Simmons  [jsimmons@linux-fbdev.org]               ____/|
fbdev/console/gfx developer                             \ o.O|
http://www.linux-fbdev.org                               =(_)=
http://linuxgfx.sourceforge.net                            U
http://linuxconsole.sourceforge.net

