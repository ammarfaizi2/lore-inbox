Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130536AbRCDWXj>; Sun, 4 Mar 2001 17:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130537AbRCDWXa>; Sun, 4 Mar 2001 17:23:30 -0500
Received: from theirongiant.weebeastie.net ([203.62.148.50]:1797 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S130536AbRCDWXZ>; Sun, 4 Mar 2001 17:23:25 -0500
Date: Mon, 5 Mar 2001 09:23:09 +1100
From: CaT <cat@zip.com.au>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 + 2.2.18 + laptop problems
Message-ID: <20010305092309.D576@zip.com.au>
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

> Index: eepro100.c

Patch appears to have worked. After 2 weeks of actually using the right
module (*sheepish grin*) I've not had the card popup the above error
message. woo.

So thanks for that. :) Majorly happy about things now. :)

And now... to put ext3 on my laptop.

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

