Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315479AbSGFAZC>; Fri, 5 Jul 2002 20:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSGFAZC>; Fri, 5 Jul 2002 20:25:02 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:40458
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315479AbSGFAZB>; Fri, 5 Jul 2002 20:25:01 -0400
Date: Fri, 5 Jul 2002 17:25:42 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Nick Evgeniev <nick@octet.spb.ru>
cc: Dave Jones <davej@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: linnux 2.4.19-rc1 i845e ide not detected. dma doesn't work
In-Reply-To: <001001c2235c$ad9ce820$15cf69c2@nick>
Message-ID: <Pine.LNX.4.10.10207051710430.25668-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Does it work in 2.5 ?


On Thu, 4 Jul 2002, Nick Evgeniev wrote:

> Well, anyway, 2.4.19-pre10-ac2 works for me :)
> 
> > No it has everything to do with determining if the HBA is in compatablity
> > or native mode and if the device is properly enabled.
> >
> > On Wed, 3 Jul 2002, Dave Jones wrote:
> >
> > > On Mon, Jul 01, 2002 at 03:49:43PM +0400, Nick Evgeniev wrote:
> > >
> > >  >     Why are you so assure? It's "msi 845e Max" with LAN on-board mb
> with
> > >  > _latest_ BIOS installed....
> > >  > Just FYI 2.4.18 was even unable to run eepro100 driver on it while
> intels
> > >  > e100 driver was working perfectly.
> > >
> > > Could this be related to the pci id clash I pointed out last week?
> > > That id was for an intel IDE device iirc.
> > >
> > > (Recap: Two id's don't tally between 2.4/2.5)
> > >
> > >         Dave
> > >
> > > --
> > > | Dave Jones.        http://www.codemonkey.org.uk
> > > | SuSE Labs
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
> > Andre Hedrick
> > LAD Storage Consulting Group
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 

Andre Hedrick
LAD Storage Consulting Group

