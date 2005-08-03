Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261976AbVHCCNI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbVHCCNI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 22:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVHCCNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 22:13:08 -0400
Received: from xenotime.net ([66.160.160.81]:59534 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S261976AbVHCCNH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 22:13:07 -0400
Date: Tue, 2 Aug 2005 19:13:03 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Testing RC kernels [KORG]
Message-Id: <20050802191303.09e635c3.rdunlap@xenotime.net>
In-Reply-To: <200508022204.16204.gene.heskett@verizon.net>
References: <1123007589.24010.41.camel@jy.metro1.com>
	<1123008881.12562.16.camel@mindpipe>
	<1123010465.1590.34.camel@localhost.localdomain>
	<200508022204.16204.gene.heskett@verizon.net>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Aug 2005 22:04:16 -0400 Gene Heskett wrote:

> On Tuesday 02 August 2005 15:21, Steven Rostedt wrote:
> >On Tue, 2005-08-02 at 14:54 -0400, Lee Revell wrote:
> >> On Tue, 2005-08-02 at 11:36 -0700, Sean Bruno wrote:
> >> > On Tue, 2005-08-02 at 14:36 -0400, Lee Revell wrote:
> >> > > On Tue, 2005-08-02 at 11:33 -0700, Sean Bruno wrote:
> >> > > > <noob question>
> >> > > >
> >> > > > I have been trying to test the 2.6.13 and can't quite get
> >> > > > the patches applied cleanly.
> >> > > >
> >> > > > What kernel version (full kernel source tar ball) should I
> >> > > > be using to apply the patches(rc5) with?  Is it 2.6.12.3?
> >> > >
> >> > > No, 2.6.12.
> >> > >
> >> > > Lee
> >> >
> >> > Ah!  Thanks.
> >>
> >> Thanks for testing the RCs, we need more users to do that.
> >>
> >> If any of your hardware stops working, make sure to report it,
> >> don't assume that it will fix itself!  Assume you're the first to
> >> notice the bug.
> >
> >I've been complaining about this for some time. Kernel.org really
> > needs to show more information about the rc kernels and how to
> > create them. We want more testers, but I wonder how many people go
> > through the above steps and just give up when things don't work.
> > Luckly Sean was nice enough to email the LKML and ask.
> >
> >My main gripe is that there's no link to 2.6.12 which is what most
> > of the other patches go against.
> 
> Can someone with access to the html for kernel.org please fix that?  
> We've had several messages now complaining about this.

Was the request cc-ed to webmaster@kernel.org (along with
the [KORG] in the subject line)?
I can't tell from the email archives.

> FWIW, gftp users CAN find it, its sitting right in 
> the /pub/linux/kernel/2.6 directory in plain sight.

Sure, anyone can find it if they search enough subdirectories
and know what they are looking for.

---
~Randy
