Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132677AbRC2FPk>; Thu, 29 Mar 2001 00:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132679AbRC2FPb>; Thu, 29 Mar 2001 00:15:31 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:33540 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132677AbRC2FPL>; Thu, 29 Mar 2001 00:15:11 -0500
Message-Id: <200103290514.f2T5Dos03632@aslan.scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jeffrey.hundstad@mnsu.edu (Jeffrey Hundstad),
   linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
Subject: Re: Linux-2.4.2-ac27 - read on /proc/bus/pci/devices never finishes after rmmod aic7xxx 
In-Reply-To: Your message of "Thu, 29 Mar 2001 05:21:37 +0100."
             <E14iTwJ-00075c-00@the-village.bc.nu> 
Date: Wed, 28 Mar 2001 22:13:50 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> What version of the aic7xxx driver is embedded in 2.4.2-ac27?  This
>> particular issue was fixed just after 6.1.5 was released.
>
>The last patch you sent to me + small other fixups for aicdb.h. I dont have
>time to chase after peoples drivers. If you want a newer aic7xxx in -ac just
>mail me a diff to update to it

I don't recall ever sending you diffs for the driver.  My guess is that
6.1.5 got integrated into -ac from Linus' tree.

Up to now, I haven't been tracking -ac kernels.  I started sending
diffs to Linus based on the pre series kernels.  No-one has requested
patch sets against -ac kernels, but if I need to support this branch,
I'll start generating them and passing them your way.

Chasing after all of the kernel versions can be time consuming for
driver developers too. ;-)

--
Justin
