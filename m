Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263554AbTDNQxv (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263563AbTDNQxv (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:53:51 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59274 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263554AbTDNQxt (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:53:49 -0400
Date: Mon, 14 Apr 2003 13:07:28 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: P4-CPU/NoBoot
In-Reply-To: <1050336068.25353.74.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0304141303170.26310@chaos>
References: <Pine.LNX.4.53.0304140954420.25232@chaos>
 <1050336068.25353.74.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Apr 2003, Alan Cox wrote:

> On Llu, 2003-04-14 at 14:55, Richard B. Johnson wrote:
> > I tried to install RH 7.0 on a new box this
> > week-end:
> >
> > 	Motherboard MSI 648 Max
> > 	CPU Intel P4 2.8 GHz
> > 	Memory 1024 MB PC-333 DDR
>
> 7.0 is an odd thing to install but ought to have
> worked. 7.0 doesn't handle PIV feature stuff and
> also doesn't support SMP or hyperthreaded PIV
> (you'll get random segfaults). Intel provided fixes
> for that specific kernel bug in later kernels
>

Okay. Yes 7.0 and 7.1 are the CD/ROMs that I had at home.
I know RH is at 8.0 now. I will try to install the
stuff I have at work on the home CPU, I just brought
my SCSI drive and cloned everything. I will boot
from a floppy first, then LILO or grib the drive if
it boots okay. I just wanted to check if I was going
to have any other problems. Thanks.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

