Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315879AbSENRF4>; Tue, 14 May 2002 13:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315884AbSENRFz>; Tue, 14 May 2002 13:05:55 -0400
Received: from mail7.svr.pol.co.uk ([195.92.193.21]:27163 "EHLO
	mail7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S315879AbSENRFx>; Tue, 14 May 2002 13:05:53 -0400
Posted-Date: Tue, 14 May 2002 12:47:28 GMT
Date: Tue, 14 May 2002 13:47:28 +0100 (BST)
From: Riley Williams <rhw@InfraDead.Org>
Reply-To: Riley Williams <rhw@InfraDead.Org>
To: Francis Avila <franga@shentel.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.14.19-pre8 fails to boot
In-Reply-To: <001401c1f595$51df3780$0301a8c0@dell>
Message-ID: <Pine.LNX.4.21.0205141345460.12716-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francis.

> On my HP Omnibook 5500ct, kernel 2.14.19-pre8 fails to boot.
> Immediately upon the kernel being run by the bootloader, the
> machine reboots. Nothing is printed to the console before reboot.
>
> This does not happen on my Dell Inspiron 3800, which boots without
> any problems. I have not tested anything else. The Dell uses Lilo
> 21.7.5, not Grub.
>
> I tried compiling a less-ambitious kernel (i.e., a 386 instead of a
> 586 kernel, stripping out everything I could think of except for Ide
> and ext2fs support, even not passing the kernel any "command line"
> arguments), but to no avail.
>
> My bootloader is Grub 0.90. On loading the kernel, grub reports:
>
> [Linux-bzImage, setup=0x1400, size=0x8d6ad]
>
> Nothing out of the ordinary. Its only when grub tries to boot the
> kernel that the machine reboots.
>
> The next-newest kernel I've run on this machine was a 2.14.18, which
> booted fine, so something went wrong among the pre's.

I can't personally help with any of this, so I've forwarded your query
to the Linux kernel developer's list <Linux-Kernel@Vger.Kernel.Org> as
there's certain to be somebody there who can help.

The one thing I would point out is that a comparison between a system
using LILO to boot and one using GRUB to boot for problems in the boot
process is unlikely to be valid.

Best wishes from Riley.
