Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283585AbRLMH1R>; Thu, 13 Dec 2001 02:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283586AbRLMH1H>; Thu, 13 Dec 2001 02:27:07 -0500
Received: from balu.sch.bme.hu ([152.66.208.40]:29932 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S283585AbRLMH04>;
	Thu, 13 Dec 2001 02:26:56 -0500
Date: Thu, 13 Dec 2001 08:26:49 +0100 (MET)
From: Pozsar Balazs <pozsy@sch.bme.hu>
To: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
cc: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Subject: Re: Unknown bridge resource
In-Reply-To: <1008211968.16830.1.camel@nc1701d>
Message-ID: <Pine.GSO.4.30.0112130825440.27101-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Dec 2001, Juergen Sawinski wrote:

> If the pci id is not found (see drivers/pci/pci.ids), you'll get this
> message. If you can supply the description, the maintainer is Martin
> Mares <mj@ucw.cz>, see also http://pciids.sf.net/.

This is with 2.4.17-pre8, so I am willing to supply any info need, just
teel me what is it.


>
> On Thu, 2001-12-13 at 00:08, Pozsar Balazs wrote:
> >
> > Hi all,
> >
> > During boot, i got these two lines in dmesg:
> > Unknown bridge resource 0: assuming transparent
> > Unknown bridge resource 2: assuming transparent
> >
> > What do they mean?
> >
> >
> > ps: I noticed these because they are written on the console even if quiet
> > mode is on. There was a patch for 2.4-ac, but it seems that it somehow
> > lost... :(
> >
> > --
> > Balazs Pozsar
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> --
> Juergen Sawinski
> Max-Planck-Institute for Medical Research
> Dept. of Biomedical Optics
> Jahnstr. 29
> D-69120 Heidelberg
> Germany
>
> Phone:  +49-6221-486-309
> Fax:    +49-6221-486-325
>
> priv.
> Phone:  +49-6221-418 848
> Mobile: +49-171-532 5302
>

-- 
Balazs Pozsar

