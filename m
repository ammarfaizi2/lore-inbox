Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269067AbRHFW1d>; Mon, 6 Aug 2001 18:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269068AbRHFW1X>; Mon, 6 Aug 2001 18:27:23 -0400
Received: from femail43.sdc1.sfba.home.com ([24.254.60.37]:54935 "EHLO
	femail43.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S269067AbRHFW1N>; Mon, 6 Aug 2001 18:27:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Nico Schottelius <nicos@pcsystems.de>, safemode <safemode@speakeasy.net>
Subject: Re: 3c509: broken(verified)
Date: Mon, 6 Aug 2001 15:30:12 -0700
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E15TNpL-0007rV-00@the-village.bc.nu> <20010805160035Z269969-28344+1638@vger.kernel.org> <3B6EBDAE.F5D619EB@pcsystems.de>
In-Reply-To: <3B6EBDAE.F5D619EB@pcsystems.de>
MIME-Version: 1.0
Message-Id: <01080615301200.00599@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 August 2001 08:54 am, Nico Schottelius wrote:
> > i was just using a 3c509 in my friend's old 486 and it was working
> > fine with 2.4.7.   Just modprobed it and set up the ips and it was
> > able to ping and be pinged.
>
> Did you use twisted pair or coax (bnc) ?
>
> This problems occurs (at least ) when trying to use TP.
>
> Nico
>
> ps: Alan, do you have an solution ?

For what it's worth, I'm using a 3c509 card on vanilla 2.4.7 right now, 
using standard twisted pair patch cable, and it works fine. I've used it 
both as a module and compiled in (using compiled in at the moment) on 
2.4.5 and 2.4.7, I've also previously used it on 2.4.3, both compiled in 
and as a module.

The motherboard is a Soyo K7VIA w/single ISA slot, VIA Apollo Pro KX133 
chipset, using an Athlon processor.

The card is connected to a hub and communicates fine with both my other 
system and my cable modem, using DHCP.

You mention the problem is being unable to change the media, I was 
unaware this was even possible with the current 3c509 driver, and most 
people do it on 3c509's and other PNP cards of this sort (such as NE2000 
clones)  by using a DOS boot diskette and the DOS utilities provided by 
the manufacturer.
