Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287855AbSANR4c>; Mon, 14 Jan 2002 12:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287848AbSANR4N>; Mon, 14 Jan 2002 12:56:13 -0500
Received: from ns1.system-techniques.com ([199.33.245.254]:34947 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S287854AbSANRz7>; Mon, 14 Jan 2002 12:55:59 -0500
Date: Mon, 14 Jan 2002 12:55:19 -0500 (EST)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: esr@thyrsus.com, Giacomo Catenazzi <cate@debian.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
In-Reply-To: <E16QBE1-0002LX-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0201141254001.3238-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello All ,  And what mechanism is going to be used for an -all-
	compiled in kernel ?  Everyone and there brother is so enamoured
	of Modules .  Not everyone uses nor will use modules .
		Tia ,  JimL

On Mon, 14 Jan 2002, Alan Cox wrote:

> > That would be fine with me.  But wouldn't it involve adding a new
> > initialization-time call to every driver.
>
> man lsmod
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

