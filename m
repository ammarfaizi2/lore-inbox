Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280572AbRKBF7R>; Fri, 2 Nov 2001 00:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280575AbRKBF7H>; Fri, 2 Nov 2001 00:59:07 -0500
Received: from [203.6.240.4] ([203.6.240.4]:63498 "HELO
	cbus613-server4.colorbus.com.au") by vger.kernel.org with SMTP
	id <S280572AbRKBF65>; Fri, 2 Nov 2001 00:58:57 -0500
Message-ID: <370747DEFD89D2119AFD00C0F017E66150B17F@cbus613-server4.colorbus.com.au>
From: Robert Lowery <Robert.Lowery@colorbus.com.au>
To: linux-kernel@vger.kernel.org
Subject: RE: Best way to setup 128MB box that can only cache 64MB
Date: Fri, 2 Nov 2001 16:58:27 +1100 
X-Mailer: Internet Mail Service (5.5.2653.19)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should have also mentioned that I use this box for playing DVD's (with a
Hollywood+ card) and MP3's.

Of course linux does not need 128MB for a firewall.

-Rob

P.S. The memory zones stuff sounds very interesting and I am looking forward
to any input from the MM gods ;)

> -----Original Message-----
> From: Ryan Cumming [mailto:bodnar42@phalynx.dhs.org]
> Sent: Friday, November 02, 2001 4:53 PM
> To: Robert Lowery
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Best way to setup 128MB box that can only cache 64MB
> 
> 
> On November 1, 2001 20:00, Robert Lowery wrote:
> > Hi,
> >
> > I know most people are now having fun on 2GB+ SMP Mega666 
> processor systems
> > these days ;), But unfortunately, I still only have a 
> Pentium 233MMX system
> > as my firewall with 128MB RAM with the Intel 430FX chip 
> which can only
> > cache the first 64MB.
> >
> > There have been lots of discussions over the years on this 
> topic, but I
> > could not find any definitive answers. How should I set 
> this box up to get
> > the best performance?
> 
> I'm curious if zones could be of any benefit in this 
> situation. Could the 
> kernel be told to use memory over 64megs only if significant 
> pressure is put 
> on the VM, sort of like how we treat the DMA zone now? I 
> suspect this will 
> have much lower overhead than using the top 64megs as swap. 
> Any MM gods want 
> to comment?
> 
> -Ryan
> 
