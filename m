Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277529AbRJERhk>; Fri, 5 Oct 2001 13:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277424AbRJERha>; Fri, 5 Oct 2001 13:37:30 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:33285 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S277380AbRJERhS>; Fri, 5 Oct 2001 13:37:18 -0400
Date: Fri, 5 Oct 2001 11:39:57 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: rugolsky@ead.dsa.com, linux-kernel@vger.kernel.org, lm@bitmover.com,
        jgiglio@smythco.com
Subject: Re: 3ware discontinuing the Escalade Series
Message-ID: <20011005113957.A3029@vger.timpanogas.org>
In-Reply-To: <20011005125259.B1221@ead45> <E15pYQ1-00071M-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E15pYQ1-00071M-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 05, 2001 at 06:05:49PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 06:05:49PM +0100, Alan Cox wrote:
> > I really like my 7800.  At this point I guess I'm going to convert from
> > hard to soft RAID, on the theory that (unfixed) bugs in the firmware are less
> > likely to botch JBOD. 
> 
> Except for RAID5 the softraid is also likely to outperform a hardware raid
> controller. With RAID5 its a CPU usage tradeoff


There's the promise RAID adapter, which we are switching to for our 
projects based on the distressing news that 3Ware is pulling the best
RAID controller off the market.

Jeff

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
