Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135726AbRAJWHx>; Wed, 10 Jan 2001 17:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135670AbRAJWHe>; Wed, 10 Jan 2001 17:07:34 -0500
Received: from colorfullife.com ([216.156.138.34]:4624 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S135365AbRAJWH0>;
	Wed, 10 Jan 2001 17:07:26 -0500
Message-ID: <3A5CDD42.5E804B64@colorfullife.com>
Date: Wed, 10 Jan 2001 23:08:02 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jonathan Earle <jearle@nortelnetworks.com>,
        "'Linux Kernel List'" <linux-kernel@vger.kernel.org>,
        "'Linux Network List'" <linux-net@vger.kernel.org>
Subject: Re: Porting network driver to 2.4.0
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDC78@zcard00g.ca.nortel.com> <20010110220024.A6792@gruyere.muc.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> On Wed, Jan 10, 2001 at 03:40:50PM -0500, Jonathan Earle wrote:
> > Where do I go from here?  Is there info somewhere to help with this?  Is
> > this a bigger job than it looks on the surface?
> 
> Try http://www.firstfloor.org/~andi/softnet
> 

I would ask someone from znxz.

I downloaded their driver, and there are at least a few comments about
2.3 compatibility

(and I also found a 5000 line hardware abstraction layer, and only 9 out
of the 15 kernel files are GPL, the rest is "All rights reserved".
Obiously their Makefile allows to compile the driver statically into the
kernel.)

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
