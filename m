Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317637AbSGFMjw>; Sat, 6 Jul 2002 08:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317640AbSGFMjv>; Sat, 6 Jul 2002 08:39:51 -0400
Received: from [194.105.207.66] ([194.105.207.66]:50064 "EHLO
	vider.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S317637AbSGFMju>; Sat, 6 Jul 2002 08:39:50 -0400
Message-ID: <004c01c224ea$816bfb80$15cf69c2@nick>
From: "Nick Evgeniev" <nick@octet.spb.ru>
To: "Andre Hedrick" <andre@linux-ide.org>
Cc: "Dave Jones" <davej@suse.de>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.10.10207051710430.25668-100000@master.linux-ide.org>
Subject: Re: linnux 2.4.19-rc1 i845e ide not detected. dma doesn't work
Date: Sat, 6 Jul 2002 16:41:52 +0400
Organization: M.Y.T.H. Inc
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Scanner: exiscan *17Qosr-0005KZ-00*4Mu9ctJDgpg* (M.Y.T.H. Inc)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know. Actually, I'm trying to setup "production" environment :)) &
i845e (or i845pe) is the only one solution (I don't want to try via+promise
anymore)

----- Original Message -----
From: "Andre Hedrick" <andre@linux-ide.org>
To: "Nick Evgeniev" <nick@octet.spb.ru>
Cc: "Dave Jones" <davej@suse.de>; "Alan Cox" <alan@lxorguk.ukuu.org.uk>;
<linux-kernel@vger.kernel.org>
Sent: Saturday, July 06, 2002 4:25 AM
Subject: Re: linnux 2.4.19-rc1 i845e ide not detected. dma doesn't work


>
> Does it work in 2.5 ?
>
>
> On Thu, 4 Jul 2002, Nick Evgeniev wrote:
>
> > Well, anyway, 2.4.19-pre10-ac2 works for me :)
> >
> > > No it has everything to do with determining if the HBA is in
compatablity
> > > or native mode and if the device is properly enabled.
> > >
> > > On Wed, 3 Jul 2002, Dave Jones wrote:
> > >
> > > > On Mon, Jul 01, 2002 at 03:49:43PM +0400, Nick Evgeniev wrote:
> > > >
> > > >  >     Why are you so assure? It's "msi 845e Max" with LAN on-board
mb
> > with
> > > >  > _latest_ BIOS installed....
> > > >  > Just FYI 2.4.18 was even unable to run eepro100 driver on it
while
> > intels
> > > >  > e100 driver was working perfectly.
> > > >
> > > > Could this be related to the pci id clash I pointed out last week?
> > > > That id was for an intel IDE device iirc.
> > > >
> > > > (Recap: Two id's don't tally between 2.4/2.5)
> > > >
> > > >         Dave
> > > >
> > > > --
> > > > | Dave Jones.        http://www.codemonkey.org.uk
> > > > | SuSE Labs
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
> > in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > >
> > >
> > > Andre Hedrick
> > > LAD Storage Consulting Group
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> > >
> >
>
> Andre Hedrick
> LAD Storage Consulting Group
>
>

