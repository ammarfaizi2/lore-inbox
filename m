Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129659AbQKRHor>; Sat, 18 Nov 2000 02:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130159AbQKRHoh>; Sat, 18 Nov 2000 02:44:37 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42501 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129659AbQKRHoX>;
	Sat, 18 Nov 2000 02:44:23 -0500
Message-ID: <3A162C4B.822A4BB5@mandrakesoft.com>
Date: Sat, 18 Nov 2000 02:14:19 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Greg KH <greg@wirex.com>
CC: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: test11-pre6 still very broken
In-Reply-To: <Pine.LNX.4.21.0011171935560.1796-100000@saturn.homenet> <8v4306$sga$1@cesium.transmeta.com> <3A161337.6A1BE826@linux.com> <20001117223137.A26341@wirex.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> On Fri, Nov 17, 2000 at 09:27:19PM -0800, David Ford wrote:
> >
> > The second issue is usb.  I now have two machines that lockup on boot in USB.
> > One is the above workstation, the second is a Compaq laptop.  Unfortunately
> > I have no way of unplugging the USB hardware inside the laptop :P
> 
> Can't you not compile in the UHCI driver?  Actually, it seems odd that a
> Compaq laptop would have a uhci driver, as Compaq was one of the OHCI
> creators...

It's quite common actually.  Many newer Compaq laptops, including my
dinky Presario, use Via for their north/southbridge chipset.

	Jeff


-- 
Jeff Garzik             |
Building 1024           | The chief enemy of creativity is "good" sense
MandrakeSoft            |          -- Picasso
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
