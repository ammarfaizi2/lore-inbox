Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129712AbRBMEPa>; Mon, 12 Feb 2001 23:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130169AbRBMEPL>; Mon, 12 Feb 2001 23:15:11 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:14095 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S129712AbRBMEPD>; Mon, 12 Feb 2001 23:15:03 -0500
Date: Tue, 13 Feb 2001 15:14:09 +1100
From: CaT <cat@zip.com.au>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 + 2.2.18 + laptop problems
Message-ID: <20010213151409.Q352@zip.com.au>
In-Reply-To: <20010211224033.G352@zip.com.au> <20010213092638.A11218@saw.sw.com.sg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010213092638.A11218@saw.sw.com.sg>; from saw@saw.sw.com.sg on Tue, Feb 13, 2001 at 09:26:38AM +0800
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 09:26:38AM +0800, Andrey Savochkin wrote:
> On Sun, Feb 11, 2001 at 10:40:33PM +1100, CaT wrote:
> [snip]
> > Feb 11 22:30:18 theirongiant kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
> 
> Please try the attached patch.
> Actually, it's designed to solve another problem, but may be your one has the
> same origin as that other.

Cool. Thanks. I recompiled the module and am trying it now. So far the
ethernet connection is fine but the above problem isn't reproducable with 
100% accuracy and so it'll take me a wee while before I decide 'oooo....
aaaaa... that rocks my boat. it's fixed.'. :)

As such I'll try to give you a holler either in a few weeks time (if nothing
happens) or as soon as it breaks again.

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
