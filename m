Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbSLNBgg>; Fri, 13 Dec 2002 20:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267494AbSLNBgg>; Fri, 13 Dec 2002 20:36:36 -0500
Received: from waste.org ([209.173.204.2]:28303 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S267493AbSLNBgf>;
	Fri, 13 Dec 2002 20:36:35 -0500
Date: Fri, 13 Dec 2002 19:43:46 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: pci-skeleton duplex check
Message-ID: <20021214014346.GA6029@waste.org>
References: <Pine.LNX.4.44.0212121539110.10674-100000@beohost.scyld.com> <200212140019.gBE0JmDs006744@sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212140019.gBE0JmDs006744@sandelman.ottawa.on.ca>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 13, 2002 at 07:19:47PM -0500, Michael Richardson wrote:
> 
> 
> >>>>> "Donald" == Donald Becker <becker@scyld.com> writes:
>     Donald> The drivers in the kernel are now heavily modified and have significantly
>     Donald> diverged from my version.  Sure, you are fine with having someone else
>     Donald> do the difficult and unrewarding debugging and maintainence work, while
>     Donald> you work on just the latest cool hardware, change the interfaces and are
>     Donald> concerned only with the current kernel version.
> 
>   I agree strongly with Donald.
> 
>   Interfaces should NEVER change in patch level versions.
>   Just *DO NOT DO IT*.
> 
>   Go wild in odd-numbered.. get the interfaces right there.
>   But leave them alone afterward.

Umm, if I recall correctly, they're rehashing a flame war about stuff
that occurred in 2.3. It doesn't need any additional kindling.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
