Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265305AbSKKBbW>; Sun, 10 Nov 2002 20:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbSKKBbW>; Sun, 10 Nov 2002 20:31:22 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:7184 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265305AbSKKBbV>; Sun, 10 Nov 2002 20:31:21 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1893@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Craig Whitmore'" <linuxkernel@orcon.net.nz>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>
Cc: Martin Knoblauch <knobi@knobisoft.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: Memory performance on Serverworks GC-LE based system poor?
Date: Sun, 10 Nov 2002 17:37:37 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I, too get 1600 using the Force 4203 motherboard with GC-LE chipset. Same
CPU and RAM ...

Thanks
Manish

-----Original Message-----
From: Craig Whitmore [mailto:linuxkernel@orcon.net.nz]
Sent: Sunday, November 10, 2002 5:23 PM
To: Alan Cox; Dave Jones
Cc: Martin Knoblauch; Linux Kernel Mailing List
Subject: Re: Memory performance on Serverworks GC-LE based system poor?


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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
