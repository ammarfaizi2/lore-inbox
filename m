Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292379AbSCBE5P>; Fri, 1 Mar 2002 23:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293476AbSCBE5G>; Fri, 1 Mar 2002 23:57:06 -0500
Received: from penguin.linuxhardware.org ([63.173.68.170]:52148 "EHLO
	penguin.linuxhardware.org") by vger.kernel.org with ESMTP
	id <S292379AbSCBE47>; Fri, 1 Mar 2002 23:56:59 -0500
Date: Fri, 1 Mar 2002 23:47:58 -0500 (EST)
From: Kristopher Kersey <augustus@linuxhardware.org>
To: Andre Hedrick <andre@linuxdiskcert.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Panics on IDE Initialization
In-Reply-To: <Pine.LNX.4.10.10203011615070.2811-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.33.0203012346001.24643-100000@penguin.linuxhardware.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have verified that it is indeed the HighPoint IDE that it's getting hung
up on.  I simply disabled it in the BIOS and it booted just fine.  Any
ideas on a fix though would still be appreciated.  I will test this out on
the ABIT board also since it has a HighPoint on board also.

thanks,
Kris

On Fri, 1 Mar 2002, Andre Hedrick wrote:

>
> Oh I already have the skinny and working on it.
> I still have the touch!
>
> Also I have a sponsor for the 374 code so now to find somebody for the 372
> and the variations it shows up in :-/
>
> Cheers,
>
>
> On Fri, 1 Mar 2002, Alan Cox wrote:
>
> > > I have word that it's the HighPoint controller's fault.  I will verify
> > > this myself and let you know.
> >
> > Ok
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
>
> Andre Hedrick
> Linux Disk Certification Project                Linux ATA Development
>

