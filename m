Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317367AbSGDNMI>; Thu, 4 Jul 2002 09:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317406AbSGDNMI>; Thu, 4 Jul 2002 09:12:08 -0400
Received: from [194.105.207.66] ([194.105.207.66]:57221 "EHLO
	vider.octet.spb.ru") by vger.kernel.org with ESMTP
	id <S317367AbSGDNMH>; Thu, 4 Jul 2002 09:12:07 -0400
Message-ID: <001001c2235c$ad9ce820$15cf69c2@nick>
From: "Nick Evgeniev" <nick@octet.spb.ru>
To: "Andre Hedrick" <andre@linux-ide.org>, "Dave Jones" <davej@suse.de>
Cc: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.10.10207031216420.18712-100000@master.linux-ide.org>
Subject: Re: linnux 2.4.19-rc1 i845e ide not detected. dma doesn't work
Date: Thu, 4 Jul 2002 17:14:07 +0400
Organization: M.Y.T.H. Inc
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Scanner: exiscan *17Q6Qw-0004tE-00*QsYp3dRqa8k* (M.Y.T.H. Inc)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, anyway, 2.4.19-pre10-ac2 works for me :)

> No it has everything to do with determining if the HBA is in compatablity
> or native mode and if the device is properly enabled.
>
> On Wed, 3 Jul 2002, Dave Jones wrote:
>
> > On Mon, Jul 01, 2002 at 03:49:43PM +0400, Nick Evgeniev wrote:
> >
> >  >     Why are you so assure? It's "msi 845e Max" with LAN on-board mb
with
> >  > _latest_ BIOS installed....
> >  > Just FYI 2.4.18 was even unable to run eepro100 driver on it while
intels
> >  > e100 driver was working perfectly.
> >
> > Could this be related to the pci id clash I pointed out last week?
> > That id was for an intel IDE device iirc.
> >
> > (Recap: Two id's don't tally between 2.4/2.5)
> >
> >         Dave
> >
> > --
> > | Dave Jones.        http://www.codemonkey.org.uk
> > | SuSE Labs
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> Andre Hedrick
> LAD Storage Consulting Group
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

