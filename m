Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262354AbRERPrX>; Fri, 18 May 2001 11:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262356AbRERPrP>; Fri, 18 May 2001 11:47:15 -0400
Received: from sal.qcc.sk.ca ([198.169.27.3]:1551 "HELO sal.qcc.sk.ca")
	by vger.kernel.org with SMTP id <S262354AbRERPrD>;
	Fri, 18 May 2001 11:47:03 -0400
Date: Fri, 18 May 2001 09:47:02 -0600
From: Charles Cazabon <linux-kernel@discworld.dyndns.org>
To: linux-kernel@vger.kernel.org
Subject: Re: CML2 design philosophy heads-up
Message-ID: <20010518094702.A21217@qcc.sk.ca>
In-Reply-To: <20010518093414.A21164@qcc.sk.ca> <Pine.LNX.4.33.0105180727270.17872-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.33.0105180727270.17872-100000@dlang.diginsite.com>; from david.lang@digitalinsight.com on Fri, May 18, 2001 at 07:30:07AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang <david.lang@digitalinsight.com> wrote:

> > Whether this is desirable or not is debatable.  The big question is:  why
> > on earth would Aunt Tillie _want_ to compile a kernel at all, let alone
> > re-configure one?  If she's using Linux, she's installing her
> > distribution's pre-compiled kernel, and has no need for anything else.

> why is it that so many people seem to think that it's a good thing to only
> use precompiled kernels from the distro?  a kernel tuned for a particular
> machine can boot faster and run faster then a 'stock' kernel.

I'm not saying it's a good thing.  I'm saying that the 5% performance increase
that results is not something that the average "I just want to use the system"
will even notice, let alone care about.

> unless you want to replace the kernel compile config options with a
> similar sized menu to select between precompiled kernels with the correct
> options (never mind what that will do to the size of the distros to ship
> so many kernels)

They don't need to ship a mass of kernels.  Modern distributions probably
don't need to worry about shipping three or four modular kernels.  Any user
who cares about the minor performance benefits of a custom-configured kernel
is going to reconfigure and recompile regardless of how dumbed-down the
interface is.

Charles
-- 
-----------------------------------------------------------------------
Charles Cazabon                            <linux@discworld.dyndns.org>
GPL'ed software available at:  http://www.qcc.sk.ca/~charlesc/software/
Any opinions expressed are just that -- my opinions.
-----------------------------------------------------------------------
