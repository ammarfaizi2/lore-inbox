Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293509AbSCAAwW>; Thu, 28 Feb 2002 19:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310175AbSCAAue>; Thu, 28 Feb 2002 19:50:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39440 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292332AbSCAAso>; Thu, 28 Feb 2002 19:48:44 -0500
Subject: Re: Linux 2.4.x, ThinkPad T23 and HW?!
To: arnvid@karstad.org (Arnvid Karstad)
Date: Fri, 1 Mar 2002 01:03:09 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <20020228233954.7840.qmail@nextgeneration.speedroad.net> from "Arnvid Karstad" at Mar 01, 2002 12:39:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gbS1-0001r9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> /proc/pci or lspci. I also noticed that the IBM Wireless adapter, which is 
> actually a prism2 (?) card, are mysteriously detected as an device created 
> by "Harris Semiconductor" and it won't even try to let me access the card. I 

Well guess what - it is

> think I've tried every driver in the Kernel 2.4.18 now. Altho the kernel 
> does state that the card in question is supported, it does seem that either 
> the pci/device-id has changed (or something) so the driver doesn't notice 
> any cards??? 

Or IBM did something weird.

Everything in that box looks fine with 2.4.18
