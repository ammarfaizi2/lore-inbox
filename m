Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbUKJAHg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbUKJAHg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbUKJAHg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:07:36 -0500
Received: from chello062179026180.chello.pl ([62.179.26.180]:10972 "EHLO
	pioneer.space.nemesis.pl") by vger.kernel.org with ESMTP
	id S261794AbUKJAHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:07:14 -0500
Date: Wed, 10 Nov 2004 01:08:04 +0100 (CET)
From: Tomasz Rola <rtomek@cis.com.pl>
To: Alistair John Strachan <alistair@devzero.co.uk>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel or failing harddisc?
In-Reply-To: <200411091350.15626.alistair@devzero.co.uk>
Message-ID: <Pine.LNX.3.96.1041110010428.3390H-100000@pioneer.space.nemesis.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tue, 9 Nov 2004, Alistair John Strachan wrote:

> On Tuesday 09 Nov 2004 11:07, Alan Cox wrote:
> [snip]
> >
> > It could be anything. An interrupt went walkies which could easily be
> > the driver, thermals, cabling, phase of the moon, drive,... If those are
> > the only logged lines then the drive hasn't reported any problems back.
> >
> > Failed maxtors normally make it very clear they died - both in smart
> > data (usually) and by spewing drive level errors.
> >
> > Alan
> 
> Thanks Alan, I'll look into it. Since I've not received any SMART warnings, 
> I'll just assume the drive is fine and it's something else.

Maybe motherboard? I had once a chipset (an older one, via mvp3 I
believe), that gave me strange errors until I disabled DMA with hdparm.
Besides this, open your case and check cables. Who knows, maybe this will
cure your system.

bye
T.

- --
** A C programmer asked whether computer had Buddha's nature.      **
** As the answer, master did "rm -rif" on the programmer's home    **
** directory. And then the C programmer became enlightened...      **
**                                                                 **
** Tomasz Rola          mailto:tomasz_rola@bigfoot.com             **


-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 5.0i for non-commercial use
Charset: noconv

iQA/AwUBQZFb6xETUsyL9vbiEQIAXQCdH7Ka3RvrNtdhZzkygO2cAtCAr8AAni9j
8UV4fhpY7rOypeaHQ6G4/RIw
=tYlO
-----END PGP SIGNATURE-----


