Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279752AbRJYKgu>; Thu, 25 Oct 2001 06:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279753AbRJYKga>; Thu, 25 Oct 2001 06:36:30 -0400
Received: from [213.236.192.200] ([213.236.192.200]:49829 "EHLO
	mail.circlestorm.org") by vger.kernel.org with ESMTP
	id <S279752AbRJYKg1>; Thu, 25 Oct 2001 06:36:27 -0400
Message-ID: <00e601c15d41$5ad32910$6ac0ecd5@dead2>
From: "Dead2" <dead2@circlestorm.org>
To: <linux-kernel@vger.kernel.org>, "Jeff Garzik" <jgarzik@mandrakesoft.com>
In-Reply-To: <Pine.LNX.4.33.0110241605020.12884-100000@oceanic.wsisiz.edu.pl> <20011025112752.A4795@suse.de> <007101c15d3a$c6ae90e0$6ac0ecd5@dead2> <009901c15d3e$71e96040$6ac0ecd5@dead2>
Subject: Re: Asus CUV-266-D vs Intel NIC (also MSI-6321)
Date: Thu, 25 Oct 2001 12:39:42 +0200
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ooopss...

I have to excuse my error..  I said I used the tulip driver, but I don't.

When I said 'tulip', i meant the 'eepro100' driver.
When I said 'intel', i meant the 'e100' driver

Sorry for any confusion..

-=Dead2=-

Jeff: 'de4x5' didn't work. Not so strange I guess.. =/

----- Original Message -----
From: "Dead2" <dead2@circlestorm.org>
To: <linux-kernel@vger.kernel.org>
Sent: 25 October, 2001 12:18 PM
Subject: Re: Asus CUV-266-D vs Intel NIC (also MSI-6321)


> Tested now with another motherboard with the same results.
>
> MSI 6321 Pro 1.0
>
> Both these motherboards use VIA dual-cpu chipsets.
>
> Same results with 2.4.13-Pre6 on both motherboards.
> I'm running out of ideas now..
>
> -=Dead2=-
>
> ----- Original Message -----
> From: "Dead2" <dead2@circlestorm.org>
> To: <linux-kernel@vger.kernel.org>
> Sent: 25 October, 2001 11:52 AM
> Subject: Asus CUV-266-D vs Intel NIC
>
>
> > I have an Asus CUV266-d motherboard, and want to use my Intel NIC's..
> >
> > 2.4.10 & 2.4.12 hangs while "Setting up routing"
> > No error messages appear.
> >
> > 2.4.x(4 maybe?) has both officail Intel drivers and the tulip drivers.
> > When loading the tulip, it hangs just like with todays kernels.
> > When loading the Intel driver, everything works just fine for a short
> > while..
> > 20-40seconds I guess.. Then the computer hangs.
> >
> > When not loading any NIC drivers, everything works just fine.
> >
> > The NIC's i've tried are named "Intel(R) PRO/100+ Dual Port Server
> Adapter"
> > Have also tried a "Intel(R) PRO/100+ Adapter"
> >
> > Any ideas of what to test?
> > I have the latest bios and have tried just about all bios settings.
> > 'noapic' doesn't help.
> >
> > -=Dead2=-
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


