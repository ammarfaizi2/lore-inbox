Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264637AbSKMXxz>; Wed, 13 Nov 2002 18:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbSKMXxz>; Wed, 13 Nov 2002 18:53:55 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:53245 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S264637AbSKMXxz>; Wed, 13 Nov 2002 18:53:55 -0500
Date: Wed, 13 Nov 2002 15:58:53 -0800
From: Chris Wright <chris@wirex.com>
To: Jirka Kosina <jikos@jikos.cz>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Leif Sawyer <lsawyer@gci.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FW: i386 Linux kernel DoS
Message-ID: <20021113155853.A12860@figure1.int.wirex.com>
Mail-Followup-To: Jirka Kosina <jikos@jikos.cz>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Christoph Hellwig <hch@infradead.org>,
	Leif Sawyer <lsawyer@gci.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <BF9651D8732ED311A61D00105A9CA3150B45FB3C@berkeley.gci.com> <20021112233150.A30484@infradead.org> <1037146219.10083.15.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.44-jikos1.0211140036240.26832-100000@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44-jikos1.0211140036240.26832-100000@twin.jikos.cz>; from jikos@jikos.cz on Thu, Nov 14, 2002 at 12:38:13AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jirka Kosina (jikos@jikos.cz) wrote:
> On 13 Nov 2002, Alan Cox wrote:
> 
> > > > This was posted on bugtraq today...
> > > A real segfaulting program?  wow :)
> > Looks like the TF handling bug which was fixed a while ago
> 
> This was posted today ;) (uff, the two-side forwarded conversation ;) )
> 

yeah, this has already been posted.  as has a patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=103722485108857&w=2

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
