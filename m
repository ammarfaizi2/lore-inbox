Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130938AbRAYSZl>; Thu, 25 Jan 2001 13:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135654AbRAYSZb>; Thu, 25 Jan 2001 13:25:31 -0500
Received: from pine.parrswood.manchester.sch.uk ([213.205.138.155]:52236 "EHLO
	parrswood.manchester.sch.uk") by vger.kernel.org with ESMTP
	id <S135662AbRAYSZT>; Thu, 25 Jan 2001 13:25:19 -0500
Date: Thu, 25 Jan 2001 18:25:16 +0000 (GMT)
From: Tim Fletcher <tim@parrswood.manchester.sch.uk>
To: Ondrej Sury <ondrej@globe.cz>
cc: Chris Mason <mason@suse.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.1-pre10 slowdown at boot.
In-Reply-To: <87puhbwl5v.fsf@ondrej.office.globe.cz>
Message-ID: <Pine.LNX.4.30.0101251821260.5984-100000@pine.parrswood.manchester.sch.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Are you using a VIA ide chipset? because a much slower version of the
> > driver has been put in recently
>
> Yes, I am.  Is it THAT slow?  That could be it, I will try to be more
> patient on next boot.

I think that it is a temporey "safe but slow" driver until Vojtech Pavlik
gets the driver to a state he and Andre Hendrick are happy with. iirc the
driver has dma disabled for all VIA chipsets

-- 
   Tim Fletcher - Network manager   .~.
                                    /V\      L   I   N   U   X
     nightshade@solanum.net        // \\  >Don't fear the penguin<
tim@parrswood.manchester.sch.uk   /(   )\
 irc: Night-Shade on quakenet      ^^-^^

To err is human, to purchase NT is bovine!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
