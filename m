Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSEDXDO>; Sat, 4 May 2002 19:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315241AbSEDXDN>; Sat, 4 May 2002 19:03:13 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:778 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315239AbSEDXDM>; Sat, 4 May 2002 19:03:12 -0400
Date: Sat, 4 May 2002 16:01:49 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Adrian Bunk <bunk@fs.tum.de>
cc: Robert Baruch <autophile@starband.net>, mdharm-usb@one-eyed-alien.net,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NDA used for drivers/usb/storage/shuttle_usbat.c?
In-Reply-To: <Pine.NEB.4.44.0205041618030.283-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.10.10205041559020.19145-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not if they setup the agreement to permit such a driver creation.
99% of the NDA is so you can not talk about the borrowed or stolen
industry IP between companies.  In the the game of storage, one is always
looking to obtains your competiters (sp) edge and use it better.


On Sat, 4 May 2002, Adrian Bunk wrote:

> Hi Robert,
> 
> drivers/usb/storage/shuttle_usbat.c contains the following:
> 
> <--  snip  -->
> 
> ...
>  * SCM Microsystems (www.scmmicro.com) makes a device, sold to OEM's only,
>  * which does the USB-to-ATAPI conversion.  By obtaining the data sheet on
>  * their device under nondisclosure agreement, I have been able to write
>  * this driver for Linux.
> ...
> 
> <--  snip  -->
> 
> This sounds as if it might be that this open source driver violates the
> NDA you signed. Could you please clarify in the comment in this file that
> this driver doesn't violate the NDA?
> 
> 
> TIA
> Adrian
> 
> -- 
> 
> You only think this is a free country. Like the US the UK spends a lot of
> time explaining its a free country because its a police state.
> 								Alan Cox
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

