Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129040AbRBBNIQ>; Fri, 2 Feb 2001 08:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBBNIG>; Fri, 2 Feb 2001 08:08:06 -0500
Received: from expanse.dds.nl ([194.109.10.118]:6931 "EHLO expanse.dds.nl")
	by vger.kernel.org with ESMTP id <S129040AbRBBNIB>;
	Fri, 2 Feb 2001 08:08:01 -0500
Date: Fri, 2 Feb 2001 14:07:31 +0100
From: Ookhoi <ookhoi@dds.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vaio doesn't boot with 2.4.1-ac1, stops at PCI: Probing PCI hardware
Message-ID: <20010202140731.E3922@ookhoi.dds.nl>
Reply-To: ookhoi@dds.nl
In-Reply-To: <20010202122756.B3922@ookhoi.dds.nl> <E14OfM4-0006PO-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.1.14i
In-Reply-To: <E14OfM4-0006PO-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Feb 02, 2001 at 12:30:19PM +0000
X-Uptime: 12:00pm  up 3 days, 23:04, 22 users,  load average: 0.72, 0.18, 0.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

> > > Firstly however does 2.4.1 (Linus) boot ?
> > 
> > It does boot. :-)  Is there something I can do now? 
> 
> Ok that means its something in my patches. 
> 
> Time to do some patch searching. I see two probable candidates - the
> local apic code and the pci changes.
> 
> Does 2.4.1 with the following patch applied still boot

No, it doesn't boot anymore (hangs at probing pci hardware again).
I hope this helps. :-)

		Ookhoi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
