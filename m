Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269942AbTGPAzj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 20:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269963AbTGPAzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 20:55:39 -0400
Received: from web60002.mail.yahoo.com ([216.109.116.225]:27801 "HELO
	web60002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S269942AbTGPAzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 20:55:38 -0400
Message-ID: <20030716011029.1697.qmail@web60002.mail.yahoo.com>
Date: Wed, 16 Jul 2003 02:10:29 +0100 (BST)
From: =?iso-8859-1?q?Mike=20Martin?= <redtuxxx@yahoo.co.uk>
Subject: Re: Kernel oops with 2.5.74 2.5.75
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Mike Martin <redtuxxx@yahoo.co.uk> wrote: >  --- Bartlomiej
Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
> wrote: > 
> > Please send dmesg with oops
> > (make sure you have CONFIG_KALLSYMS enabled).
> > 
> 
> just updated to 2.6-test1 with the same result
> I attach the output on the screen (written down and copied, so may
> be
> errors)
> 
> this occurs after loading ide1
> > --
> > Bartlomiej
> > 
> > On Mon, 14 Jul 2003, [iso-8859-1] Mike Martin wrote:
> > 
> > > I am getting a kernel oops with both these kernels as soon as
> it
> > the
> > > kernel loads the ide drivers (hd*)
> > >
> > > I am using ALI1542 chipset, K6/2 500 cpu
> > > I have tried progressively disabling various ide options
> (cramfs,
> > > acls tcq etc) to no effect
> > >
> > > I run ext3 compiled in
> > >
> > > This is on a base of RH9 with updated modutils from rawhide.
> > >
> > > The kernel apparrently compiles fine (no errors)
> > >
> > > Anyone any ideas what could be the cause of this (2.5.66 worked
> > on
> > > this machine and runs 2.4.21 fine)
> > >
> > > If its not a simple fix I will bugzilla it
> >  
> 

now bugzilla'd as 938

> __________________________________________________
> Yahoo! Plus - For a better Internet experience
> http://uk.promotions.yahoo.com/yplus/yoffer.html

> ATTACHMENT part 2 application/octet-stream name=kern_oops
 

__________________________________________________
Yahoo! Plus - For a better Internet experience
http://uk.promotions.yahoo.com/yplus/yoffer.html
