Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270086AbTGNPBL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270647AbTGNO6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:58:24 -0400
Received: from web60003.mail.yahoo.com ([216.109.116.226]:3507 "HELO
	web60003.mail.yahoo.com") by vger.kernel.org with SMTP
	id S270667AbTGNO5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:57:21 -0400
Message-ID: <20030714151210.66629.qmail@web60003.mail.yahoo.com>
Date: Mon, 14 Jul 2003 16:12:10 +0100 (BST)
From: =?iso-8859-1?q?Mike=20Martin?= <redtuxxx@yahoo.co.uk>
Subject: Re: Kernel oops with 2.5.74 2.5.75
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0307141643040.484-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
wrote: > 
> Please send dmesg with oops
> (make sure you have CONFIG_KALLSYMS enabled).
> 

I will try when I get home - though I am not too confident about it,
because the oops happens before any partitions are mounted.

> --
> Bartlomiej
> 
> On Mon, 14 Jul 2003, [iso-8859-1] Mike Martin wrote:
> 
> > I am getting a kernel oops with both these kernels as soon as it
> the
> > kernel loads the ide drivers (hd*)
> >
> > I am using ALI1542 chipset, K6/2 500 cpu
> > I have tried progressively disabling various ide options (cramfs,
> > acls tcq etc) to no effect
> >
> > I run ext3 compiled in
> >
> > This is on a base of RH9 with updated modutils from rawhide.
> >
> > The kernel apparrently compiles fine (no errors)
> >
> > Anyone any ideas what could be the cause of this (2.5.66 worked
> on
> > this machine and runs 2.4.21 fine)
> >
> > If its not a simple fix I will bugzilla it
>  

__________________________________________________
Yahoo! Plus - For a better Internet experience
http://uk.promotions.yahoo.com/yplus/yoffer.html
