Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTFXSEO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 14:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTFXSEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 14:04:14 -0400
Received: from mail.webmaster.com ([216.152.64.131]:59130 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP id S262385AbTFXSEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 14:04:09 -0400
From: "David Schwartz" <davids@webmaster.com>
To: <vanstadentenbrink@ahcfaust.nl>, <linux-kernel@vger.kernel.org>
Subject: RE: GPL violations by wireless manufacturers
Date: Tue, 24 Jun 2003 11:18:15 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKGEGBDOAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <3EF85024.4477.78EB14@localhost>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In response to DS:

> > So is a Linux distribution "a whole which is a work based on the" Linux
> > kernel? Would you argue that RedHat can't include proprietary
> > software on
> > the same CD as the Linux kernel? All the software on the CD,
> > assuming it's
> > Linux software, likewise extends the kernel through a
> > well-defined boundary.

> No, definitely not. If that were the case, SuSE and Lindows etc. etc.
> would not be able to distribute proprietary software together with
> GPL'ed software. The GPL calls this 'mere aggregation':

> "In addition, mere aggregation of another work not based on the
> Program with the Program (or with a work based on the Program) on a
> volume of a storage or distribution medium does not bring the other
> work under the scope of this License."

	But they're not just on the same CD. The additional work extends the Linux
kernel and is useless without it (or without something that emulates it).

> These wireless products are different. The user doesn't have a choice
> to use or not to use the non-gpl'ed kernel module.

	So any software a Linux distribution installs by default has to be GPL?

> He can not prevent
> the module from loading, he can not remove it from the running kernel
> and the device doesn't operate without the module.

	That the device doesn't operate without the module says nothing about the
relationship between the linux kernel and the module. That they provide no
interface to unload the module doesn't change the fact that there's a
boundary between the kernel and the module that keeps them separate works.

> The module and the
> embedded Linux OS on the device are so interconnected that they can
> not be considered 'seperate works' under the GPL. Therefore the
> kernel module actually is GPL software itself.

	Obviously, I don't agree. The linux kernel is totally usable without the
module. The module only extends the kernel through a standardized interface.
This is sufficient, in my book, to make them separate works. That they are
shipped on the same medium and that the user can't separate them is
irrelevent -- you can't separate them if they're shipped on the same CD
anyway without a scalpel.

	The GPL can't declare a legal fiction and thereby make it into a fact. I
would think it's quite probable that a court would interpret the GPL's "work
based on" concept to be equivalent to the legal concept of a derived work.
Otherwise, the GPL can't restrict its distribution (a copyright holder has
the right to control the distribution of derived works but not works that
aren't derived, even if they meet the license's definition of 'based on').

> Buffalo Technology's response indicates that they agree with me (or
> perhaps they just don't want any trouble).

	Perhaps they just prefer to release the module under the GPL.

	DS


