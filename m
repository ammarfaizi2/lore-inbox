Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTH0EtO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 00:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTH0EtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 00:49:14 -0400
Received: from mail.vtc.edu.hk ([202.75.80.229]:17482 "EHLO pandora.vtc.edu.hk")
	by vger.kernel.org with ESMTP id S263070AbTH0EtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 00:49:12 -0400
Message-ID: <3F4C3834.A4E18C24@vtc.edu.hk>
Date: Wed, 27 Aug 2003 12:48:53 +0800
From: Nick Urbanik <nicku@vtc.edu.hk>
Organization: Institute of Vocational Education (Tsing Yi)
X-Mailer: Mozilla 4.8 [en] (X11; U; Linux 2.4.20-20.9dbgpentax i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Dresser <mdresser_l@windsormachine.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stable P4 Mother board?  Hard Lockups: Asus P4B533-E, SiS680  IDE
References: <3F4B939D.FD19B561@vtc.edu.hk> <Pine.LNX.4.56.0308261343130.23883@router.windsormachine.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Junkmail-Whitelist: YES (by domain whitelist at pandora.vtc.edu.hk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Folks,

Mike Dresser wrote:

> On Wed, 27 Aug 2003, Nick Urbanik wrote:
>
> > What modern motherboards work well with Linux?
> > What IDE cards work well?
>
> I'm using the ASUS P4B533's and P4B533-E's here successfully, very stable
> motherboards, both on our Windows PC's and Linux servers.
>
> As well, there's a few MSI 845 based boards being used here.
>
> 3ware makes very nice cards, both in the PATA(7xxx) and SATA(8xxx)
> versions.  Be warned, they're more expensive than other IDE cards.
> They're made in 2, 4, 8 and 12 port models.

They have a problem that requires I backup everything first before setting up
the disks.  That will require enormous time (to back up 203GB onto CDs) or
money (buy a big tape backup system).

> I've had problems with both Promise and Highpoint cards in the
> past(highpoint hpt366's were especially buggy under any OS).

Yes, I bought Promise fasttrack100 TX@ (PDC20270), Adaptek 1200A (HPT370A
chipset), Iwill (HPT368 chipset), HighPoint Rocket 133 (HPT302 chip: didn't
work at all), and PDC20276 built onto the Asus P4B533-E motherboard, as well
as the CMD648 (from memory), CMD649, and the SiliconImage 680 that I am
currently stuck with as the best of the bunch.

Do you think there is there any chipset available that I can use native IDE
on so I can use the software RAID on Linux?

> The 3ware's can be used with software or hardware raid(they're hardware),
> and seem to be actively supported by 3ware.

Yes; if only I could use it without a massive backup and restore!

Thank you Mike.

--
Nick Urbanik   RHCE                               nicku(at)vtc.edu.hk
Dept. of Information & Communications Technology
Hong Kong Institute of Vocational Education (Tsing Yi)
Tel:   (852) 2436 8576, (852) 2436 8713          Fax: (852) 2436 8526
PGP: 53 B6 6D 73 52 EE 1F EE EC F8 21 98 45 1C 23 7B     ID: 7529555D
GPG: 7FFA CDC7 5A77 0558 DC7A 790A 16DF EC5B BB9D 2C24   ID: BB9D2C24



