Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbRE1QZ6>; Mon, 28 May 2001 12:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263093AbRE1QZs>; Mon, 28 May 2001 12:25:48 -0400
Received: from cosmos.ccrs.nrcan.gc.ca ([132.156.47.32]:35061 "EHLO
	cosmos.CCRS.NRCan.gc.ca") by vger.kernel.org with ESMTP
	id <S263091AbRE1QZj>; Mon, 28 May 2001 12:25:39 -0400
Message-ID: <2951561DB3DDD0118FEC00805FFE98050435E451@s5-ccr-r1>
From: "Desjardins, Kristian" <Kristian.Desjardins@CCRS.NRCan.gc.ca>
To: "'kdesjard@cosmos1.ccrs.nrcan.gc.ca'" 
	<kdesjard@cosmos1.ccrs.nrcan.gc.ca>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: FW: Linux 2.4.5-ac2
Date: Mon, 28 May 2001 12:25:31 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Monday, May 28, 2001 12:20 PM
To: tim.leeuwvander@nl.unisys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac2


> But the claim was that 2.4.5-ac2 is faster than 2.4.5 plain, so which
> changes are in 2.4.5-ac2 that would make it faster than 2.4.5 plain? Also,
I
> don't know if 2.4.5-ac1 is as fast as 2.4.5-ac2 for Fabio. If not, then
it's
> a change in the 2.4.5-ac2 changelog. If it is as fast, it is one of the
> changes in the 2.4.5-ac1 changelog.

ac1 to ac2 backs out some of the bits of old VM cruft. ac2 doesnt really add
much that is VM relevant but it might be the user has a VIA chipset box in
which case -ac will be faster for other reasons
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
