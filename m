Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbRE1XL7>; Mon, 28 May 2001 19:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbRE1XLt>; Mon, 28 May 2001 19:11:49 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:15920
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S261550AbRE1XLi>; Mon, 28 May 2001 19:11:38 -0400
Date: Tue, 29 May 2001 00:11:34 -0700
From: Larry McVoy <lm@bitmover.com>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch]: ide dma timeout retry in pio
Message-ID: <20010529001134.C29504@work.bitmover.com>
Mail-Followup-To: Meelis Roos <mroos@linux.ee>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010528231809.A29504@work.bitmover.com> <E154VwD-0005CB-00@roos.tartu-labor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E154VwD-0005CB-00@roos.tartu-labor>; from mroos@linux.ee on Tue, May 29, 2001 at 12:56:37AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 12:56:37AM +0200, Meelis Roos wrote:
> LM> For what it is worth, in the recent postings I made about this topic, you
> LM> suggested that it was bad cabling, I swapped the cabling, same problem.
> LM> I swapped the mother board from Abit K7T to ASUS A7V and all cables worked
> LM> fine.
> 
> Similar info about KT7 - changing cables (both 30 and 80 wire) on Abit KT7 did
> not help, still CRC errors (with all disks tried). So it looks like some KT7
> boards have problems with IDE interface cabling or smth. like that.

I don't think it is a cabling problem, I think it is that motherboard.  I
suspect that the chipset on that motherboard is not well supported by
Linux.  

As an aside, I am less than impressed with the IDE support in Linux.
It's been a constant source of problems for the last couple of years
and it doesn't seem to get fixed.  We seem to get lots of chip sets 
almost working and then move on to the next one.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
