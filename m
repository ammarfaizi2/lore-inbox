Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbTIZSQi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTIZSQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:16:38 -0400
Received: from xs.heimsnet.is ([193.4.194.50]:21917 "EHLO cg.c.is")
	by vger.kernel.org with ESMTP id S261447AbTIZSQg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:16:36 -0400
From: =?iso-8859-1?q?B=F6rkur=20Ingi=20J=F3nsson?= <bugsy@isl.is>
Reply-To: bugsy@isl.is
Subject: Fwd: Re: khubd is a Succubus!
Date: Fri, 26 Sep 2003 18:28:58 +0000
User-Agent: KMail/1.5.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200309261828.58253.bugsy@isl.is>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



----------  Forwarded Message  ----------

Subject: Re: khubd is a Succubus!
Date: Friday 26 September 2003 18:27
From: Börkur Ingi Jónsson <bugsy@isl.is>
To: Greg KH <greg@kroah.com>

 Friday 26 September 2003 18:03, you wrote:
> On Fri, Sep 26, 2003 at 05:24:56PM +0000, Börkur Ingi Jónsson wrote:
> > Ps. in english this means that. On my computer khubd is using 100% of my
> > cpu... any fix on this?
>
> As I asked for in your bugzilla.kernel.org filing, what does the kernel
> log showing?  Is there lots of USB activity?  Are there any USB devices
> plugged into the system?  Does this also happen for 2.4?  Are you using
> ACPI?  (I can go on, but that's a good start.  You need to provide a
> much better bug report than this...)
>
> greg k-h

Ok Hi,

I sent an earlier email (
http://www.ussg.iu.edu/hypermail/linux/kernel/0309.3/0409.html )
asking what kind of info dev's wanted for a report and where I could get it.

1. Where can I find the kernel log?
If it's in /var/log/kernel/ my current file hold's this
Sep 26 16:56:55 [kernel] Linux version 2.6.0-test5 (root@localhost) (gcc
versio$
Sep 26 16:57:30 [kernel] nvidia: no version magic, tainting kernel.
Sep 26 16:57:30 [kernel] nvidia: module license 'NVIDIA' taints kernel.
Sep 26 16:57:30 [kernel] 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel
Mo$
Sep 26 16:57:33 [kernel] 0: NVRM: AGPGART: unable to retrieve symbol table
Sep 26 18:11:02 [kernel] 0: NVRM: AGPGART: unable to retrieve symbol table
Sep 26 18:12:16 [kernel] Linux version 2.4.20-gentoo-r5 (root@localhost) (gcc
v$
Sep 26 18:12:16 [kernel] blk: queue c016a344, I/O limit 4095Mb (mask
0xffffffff)
Sep 26 18:12:19 [kernel] 0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel
Mo$

Looks like nothing usb related to me.

2. I have a usb keyboard plugged in It's packard Bell model number 9201

3. This did not happen with 2.4

4. ACPI is for laptops correct? I'm using a desktop and I've never installed
anything ACPI related..

I'm sorry for a bad bug report It's just that it was my first :) Hope this
helps

-------------------------------------------------------

