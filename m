Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263171AbRE1WSg>; Mon, 28 May 2001 18:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263172AbRE1WS0>; Mon, 28 May 2001 18:18:26 -0400
Received: from sdsl-208-184-147-195.dsl.sjc.megapath.net ([208.184.147.195]:38955
	"EHLO bitmover.com") by vger.kernel.org with ESMTP
	id <S263171AbRE1WSO>; Mon, 28 May 2001 18:18:14 -0400
Date: Mon, 28 May 2001 23:18:09 -0700
From: Larry McVoy <lm@bitmover.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mark Hahn <hahn@coffee.psychology.mcmaster.ca>, Jens Axboe <axboe@suse.de>,
        andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: Re: [patch]: ide dma timeout retry in pio
Message-ID: <20010528231809.A29504@work.bitmover.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Mark Hahn <hahn@coffee.psychology.mcmaster.ca>,
	Jens Axboe <axboe@suse.de>, andre@linux-ide.org,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10105281533400.25183-100000@coffee.psychology.mcmaster.ca> <E154UJT-0003XV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E154UJT-0003XV-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, May 28, 2001 at 10:12:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2001 at 10:12:31PM +0100, Alan Cox wrote:
> > really?  do we know the nature of the DMA engine problem well enough?
> 3.	Bad cabling

For what it is worth, in the recent postings I made about this topic, you
suggested that it was bad cabling, I swapped the cabling, same problem.
I swapped the mother board from Abit K7T to ASUS A7V and all cables worked
fine.

I really think there is a software problem in there with certain chipsets,
those from VIA seem to be problematic.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
