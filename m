Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129795AbRCATPL>; Thu, 1 Mar 2001 14:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129813AbRCATOf>; Thu, 1 Mar 2001 14:14:35 -0500
Received: from [209.102.105.34] ([209.102.105.34]:46605 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S129823AbRCATNO>;
	Thu, 1 Mar 2001 14:13:14 -0500
Date: Thu, 1 Mar 2001 11:13:02 -0800
From: Tim Wright <timw@splhi.com>
To: Tor Arntsen <tor@spacetec.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Will Mosix go into the standard kernel?
Message-ID: <20010301111302.A1476@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Tor Arntsen <tor@spacetec.no>,
	linux-kernel@vger.kernel.org
In-Reply-To: <fa.o4k0c0v.smgv2v@ifi.uio.no> <fa.m9jgfcv.17n8s2n@ifi.uio.no> <200103011502.QAA25429@pallas.spacetec.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103011502.QAA25429@pallas.spacetec.no>; from tor@spacetec.no on Thu, Mar 01, 2001 at 04:02:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 04:02:11PM +0100, Tor Arntsen wrote:
> Daniel Ridge <newt@scyld.com> writes:
> [...]
> >Compare this total volume to the thousands of lines of patches that
> >RedHat or VA add to their kernel RPMS before shipping. I just don't see 
> [...]
> 
> What's good about that?  The first thing I do is to rip out the RedHat
> kernel and compile and install a pure kernel from ftp.kernel.org. 

What's good is the added value that their customers gain. If you don't feel
there is any, then you're probably running the wrong distribution. The nice
thing with Linux is that you are free to go and grab your own kernel if you
wish to do so.

> It's *bad* that those vendors deliver hacked kernels.  It's not
> something that should be recommended as a *goal*!

No it isn't. You seem to assume that your requirements match everybody elses.
This is highly unlikely. A particular vendor will have a number of requirements
for their distribution (hopefully driven by customer demand). At the time that
they create a distribution, it's quite possible that no current pure kernel
meets those requirements. It's perfectly reasonable for a vendor to make
changes to meet those requirements, provided they abide by the licensing
demands. For instance, one major change in Red Hat 7.0 is that the kernel
supports USB. At the time, 2.4 wasn't ready and 2.2 didn't have support. What
do you suggest they should have done ?
The source code to the kernel that Red Hat ships is readily available, so I
fail to see why shipping a modified kernel is such a big issue.

> When I need a new kernel version I can't sit back and hope with 
> crossed fingers that RedHat (or whatever vendor) comes out with a 
> new, hacked version of Linus' latest.
> 

Commercial customers rarely "require a new kernel version". They may encounter
problems that require fixing the kernel, but otherwise, they frequently couldn't
care less about the kernel. In such cases, they need some form of support.
There's nothing to suggest that a vendor-modified kernel is inherently harder
to support, provided that it doesn't diverge too radically.

Most people buy computers to run applications, not
an operating system. Those of us who do work on OS's are in the distinct
minority. Given that Linus works on the development kernel, wanting to run
on "Linus' latest" implies you're not using Linux in production or that you're
very brave :-)

Regards,

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
