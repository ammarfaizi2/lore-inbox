Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbRK0PJf>; Tue, 27 Nov 2001 10:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280101AbRK0PJU>; Tue, 27 Nov 2001 10:09:20 -0500
Received: from ns.suse.de ([213.95.15.193]:25352 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S280727AbRK0PIF>;
	Tue, 27 Nov 2001 10:08:05 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 'spurious 8259A interrupt: IRQ7'
In-Reply-To: <1793.10.119.8.1.1006872608.squirrel@extranet.jtrix.com.suse.lists.linux.kernel> <E168jk1-0001J7-00@the-village.bc.nu.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Nov 2001 16:08:00 +0100
In-Reply-To: Alan Cox's message of "27 Nov 2001 15:59:50 +0100"
Message-ID: <p73hergs14f.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > > Something I should have added to my post is that I have a Tulip based
> > > NIC  from Netgear.  But I believe something is definitely amiss with
> > > Athlon based  machines and Tulip cards and compiled in SMP support.
> > 
> > Mine is a UP box.
> 
> With IO Apic support included ? If you are using an AMD/VIA combo chipset
> board that would explain it

I see it on a SIS 735 board too (with IO-APIC enabled).

-Andi
