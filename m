Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285092AbRLFKPf>; Thu, 6 Dec 2001 05:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285096AbRLFKPZ>; Thu, 6 Dec 2001 05:15:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27403 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285092AbRLFKPU>; Thu, 6 Dec 2001 05:15:20 -0500
Subject: Re: [patch] 2.4.16 for pointers to __devexit functions
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 6 Dec 2001 10:17:48 +0000 (GMT)
Cc: dwmw2@infradead.org (David Woodhouse), davem@redhat.com (David S. Miller),
        kaos@ocs.com.au, marcelo@conectiva.com.br,
        linux-kernel@vger.kernel.org
In-Reply-To: <3C0F3D49.757F8AFD@mandrakesoft.com> from "Jeff Garzik" at Dec 06, 2001 04:41:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BvbA-0001Cu-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Doesn't work at all, or just doesn't work with the (current) minimum
> > recommended compiler? We have to increase those minima at some point.
> 
> akpm and others will yell :)
> egcs-1.1.2 compiles an x86 kernel far faster than newer compilers...

I certainly don't intend to leave the magic egcs workarounds in the drivers
I maintain for 2.5.

Alan
