Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132699AbRAYSGV>; Thu, 25 Jan 2001 13:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132985AbRAYSGB>; Thu, 25 Jan 2001 13:06:01 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:48140 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S132699AbRAYSF7>; Thu, 25 Jan 2001 13:05:59 -0500
Date: Thu, 25 Jan 2001 18:05:55 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: Chris Mason <mason@suse.com>
cc: Ondrej Sury <ondrej@globe.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre10 slowdown at boot.
In-Reply-To: <20130000.980445836@tiny>
Message-ID: <Pine.LNX.4.30.0101251801480.2090-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or, perhaps DMA is now off on your IDE drive, making everything slower.

Are you using a VIA ide chipset? because a much slower version of the
driver has been put in recently

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

An NT server can be run by an idiot, and usually is.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
