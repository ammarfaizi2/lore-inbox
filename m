Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270918AbRHNWt2>; Tue, 14 Aug 2001 18:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270917AbRHNWtR>; Tue, 14 Aug 2001 18:49:17 -0400
Received: from maile.telia.com ([194.22.190.16]:31960 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S270907AbRHNWtE> convert rfc822-to-8bit;
	Tue, 14 Aug 2001 18:49:04 -0400
Subject: Re: Hardlock with all kernel >= 2.4.7-pre5 - softirq related ?
From: Thomas Svedberg <thsv@bigfoot.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20010814214641.B27499@athlon.random>
In-Reply-To: <997803113.1423.22.camel@athlon1.hemma.se> 
	<20010814214641.B27499@athlon.random>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 15 Aug 2001 00:48:57 +0200
Message-Id: <997829352.7554.56.camel@athlon1.hemma.se>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Den 14 Aug 2001 21:46:41 +0200 skrev Andrea Arcangeli:
> On Tue, Aug 14, 2001 at 05:29:54PM +0200, Thomas Svedberg wrote:
> > I have experienced hardlocks (everything freezes with small white square
> 
> exact kernel version? Please make sure you can reproduce on 2.4.9-pre3,
> thanks.

I have had crashes with 2.4.7, 2.4.8, and all -pre i tried from
2.4.7-pre5 and onward as well as with the few recent -ac I tried.

The diff I included earlier was the part of the difference from
2.4.7-pre4 to -pre5 that I narrowed down the lockup to.

I will try 2.4.9-pre tomorrow and see what happens (but recent kernels
have taken longer (about 24h) to lock up than older (<1h), so a positive
success will take some time.


/ Thomas
.......................................................................
 Thomas Svedberg
 Department of Mathematics
 Chalmers University of Technology

 Address: S-412 96 Göteborg, SWEDEN
 E-mail : thsv@bigfoot.com, thsv@math.chalmers.se
 Phone  : +46 31 772 5368
 Fax    : +46 31 772 3595
.......................................................................

