Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265306AbSKKBRD>; Sun, 10 Nov 2002 20:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265308AbSKKBRD>; Sun, 10 Nov 2002 20:17:03 -0500
Received: from mail.orcon.net.nz ([210.55.12.3]:49356 "EHLO mail.orcon.net.nz")
	by vger.kernel.org with ESMTP id <S265306AbSKKBRC>;
	Sun, 10 Nov 2002 20:17:02 -0500
Message-ID: <055901c28920$d33d8ba0$6df058db@PC2>
From: "Craig Whitmore" <linuxkernel@orcon.net.nz>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Dave Jones" <davej@codemonkey.org.uk>
Cc: "Martin Knoblauch" <knobi@knobisoft.de>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <200211110130.13943.knobi@knobisoft.de> <20021111005143.GA22055@suse.de> <1036978410.2919.16.camel@irongate.swansea.linux.org.uk>
Subject: Re: Memory performance on Serverworks GC-LE based system poor?
Date: Mon, 11 Nov 2002 14:22:39 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get 1600 on a similar machine but with a Intel SHG2 motherboard
(ServerWorks GC LE Chipset as well) (Same RAM + Processors)
Maybe not a very good Motherboard you have?

Thanks
Craig

> >
> >  >  I have experienced extreme low STREAMS numbers (about 600 MB/sec for
Triad)
> >  > on two dual CPU systems based on the ServerWorks GC-LE chipset
(SuperMicro
> >  > P4DLR+ mainboard). Both systems had 2x2.4 GHz XEONs, 4GB of DDR
memory and
> >  > were running kernel 2.4.18. I would usually expect STREAMS numbers of
about
> >  > 2000 MB/sec for this kind of systems.
> >  >
> >  > Does this ring any bells?
> >
> > ISTR serverworks LE errata with MTRRs and write-combining.
> > Whether this is biting you or not I can't say.
>
> Write combining would really only bite graphics cards. The only other
> performance errata I know about affects the CIOB20 earlier revisions
> (vendor serverworks id 0x0006)

