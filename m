Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSFXUYA>; Mon, 24 Jun 2002 16:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSFXUX7>; Mon, 24 Jun 2002 16:23:59 -0400
Received: from chaos.analogic.com ([204.178.40.224]:53126 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315239AbSFXUX6>; Mon, 24 Jun 2002 16:23:58 -0400
Date: Mon, 24 Jun 2002 16:27:12 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Miles Lane <miles@megapathdsl.net>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when a laptop is powered by a battery?
In-Reply-To: <1024948946.30229.19.camel@turbulence.megapathdsl.net>
Message-ID: <Pine.LNX.3.95.1020624161800.15711A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jun 2002, Miles Lane wrote:

> Hi,
> 
> Is there any possibility we could:
> 
> 1)  Add support to the boot/mounting process 
>     so that, if a machine is being powered by
>     battery, EXT3 partitions are mounted with
>     EXT2, instead?
> 
> 2)  While the machine is running, notice when the
>     power source switches between AC and battery
>     or vice versa and remount partitions EXT3
>     partitions to use EXT2 whenever a battery is
>     being used?
> 
> This could save laptop users a lot of power,
> while keeping the benefits of EXT3 when AC
> power is available.
> 
> I know that this can be accomplished with more
> direct user intervention, but I am hoping a more
> general and transparent solution can be created.
> 
> 	Miles
> 

What does ext2 do for batteries that ext3 doesn't?
Are they compatible?

>From what I've observed, ext3 has nothing to do with
battery power. It can just handle larger media.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).

                 Windows-2000/Professional isn't.

