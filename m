Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265416AbSIRGAh>; Wed, 18 Sep 2002 02:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265419AbSIRGAh>; Wed, 18 Sep 2002 02:00:37 -0400
Received: from triton.neptune.on.ca ([205.233.176.2]:49891 "EHLO
	triton.neptune.on.ca") by vger.kernel.org with ESMTP
	id <S265416AbSIRGAc> convert rfc822-to-8bit; Wed, 18 Sep 2002 02:00:32 -0400
Date: Wed, 18 Sep 2002 02:05:30 -0400 (EDT)
From: Steve Mickeler <steve@neptune.ca>
X-X-Sender: steve@triton.neptune.on.ca
To: Ole =?ISO-8859-1?Q?Andr=E9?= Vadla =?ISO-8859-1?Q?Ravn=E5s?= 
	<oleavr-lkml@jblinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Virtual to physical address mapping
In-Reply-To: <1032328456.5812.16.camel@zole.jblinux.net>
Message-ID: <Pine.LNX.4.44.0209180204380.2876-100000@triton.neptune.on.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That info will be in /proc/pci


On 18 Sep 2002, Ole André Vadla Ravnås wrote:

> Hi
>
> I've noticed that ifconfig shows a base address and an interrupt
> number.. However, I can't get that base address to correspond to
> anything in /proc/iomem, which means that I can't determine which PCI
> device (in this case) it corresponds to (guess the base address is
> virtual). What I want is to find a way to get the PCI bus and device no
> for the network device, but is this at all possible without altering the
> kernel?
>
> Ole André
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



[-] Steve Mickeler [ steve@neptune.ca ]

[|] Todays root password is brought to you by /dev/random

[+] 1024D/9AA80CDF = 4103 9E35 2713 D432 924F  3C2E A7B9 A0FE 9AA8 0CDF

