Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbSKRT4j>; Mon, 18 Nov 2002 14:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264856AbSKRT4j>; Mon, 18 Nov 2002 14:56:39 -0500
Received: from descript.sysdoor.net ([81.91.66.78]:51205 "EHLO jenna")
	by vger.kernel.org with ESMTP id <S264853AbSKRT4h>;
	Mon, 18 Nov 2002 14:56:37 -0500
Message-ID: <00c701c28f3d$b044a160$76405b51@romain>
From: "Vergoz Michael" <mvergoz@sysdoor.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: "Ducrot Bruno" <poup@poupinou.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <028901c28ead$10dfbd20$76405b51@romain> <3DD89813.9050608@pobox.com> <003b01c28edf$9e2b1530$76405b51@romain> <20021118170447.GB27595@poup.poupinou.org> <3DD9227E.5030204@pobox.com> <001901c28f2b$2f3540a0$76405b51@romain> <3DD92DE8.7030501@pobox.com>
Subject: Re: 8139too.c patch for kernel 2.4.19
Date: Mon, 18 Nov 2002 21:04:22 +0100
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

> Vergoz Michael wrote:
>
> > Hi list,
> >
> > The driver that i have post support realtek 8139A/B/C/D/C+ (already
> > tested)
> > and another dlink card (realtek based).
> > On certain motherboard where the chip is integred you will perhaps
> > have some
> > troubles.
>
>
> Would you be willing to work with Linux kernel developers to integrate
> the useful changes in this driver into the kernel?

* of course

>
> The driver you posted is my driver, version 0.9.15, which is an older
> version of the kernel's driver and doesn't include many changes made
> since then.

* Yes, it's yours, but it work :P

>
> If you are seeing a problem, please describe in detail the problem so
> that kernel developers may fix it in the current kernel's 8139too.c.

* The problem is in packet recv, i'v to work this night to find what exactly
is the problem

>
> > The driver 8139cp.c can be removed to the source entry.
>
>
> This is the preferred driver for the 8139C+ chip, as it included many
> bug fixes and is much faster than the version from RealTek.

* I will make a prupose to all linux kernel developers about that. I prefere
to fix that problem before to prupose anything else :P

>
> Jeff
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Best regards,
Vergoz Michael

