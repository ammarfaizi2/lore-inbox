Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129072AbRBONRW>; Thu, 15 Feb 2001 08:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129106AbRBONRL>; Thu, 15 Feb 2001 08:17:11 -0500
Received: from [62.90.5.51] ([62.90.5.51]:4366 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S129072AbRBONRC>;
	Thu, 15 Feb 2001 08:17:02 -0500
Message-ID: <F1629832DE36D411858F00C04F24847A035902@SALVADOR>
From: Gabi Davar <gabi@SHUNRA.co.il>
To: "'Thomas Foerster'" <puckwork@madz.net>
Cc: "Linux Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: eth0: Something Wicked happened! 2008.
Date: Thu, 15 Feb 2001 15:21:31 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check out http://www.scyld.com/network/ethercard.html look under errata -
Via Rhine.

It seems your link either went down or had too many collisions. This caused
the driver to yell "something wicked happened".

-Gabi

> -----Original Message-----
> From: Thomas Foerster [mailto:puckwork@madz.net]
> Sent: Thursday, February 15, 2001 2:37 PM
> To: linux-kernel@vger.kernel.org
> Subject: eth0: Something Wicked happened! 2008.
> 
> 
> Hello,
> 
> yesterday i successfully set up Linux-2.2.18 on a new machine 
> (Pentium-III-667, D-Link 530TX (via-rhine) network-card, 256MB Ram).
> 
> The system is now running for about 1 day, and now i get 
> lot's of these messages :
> 
> eth0: Something Wicked happened! 2008.
> 
> This happened on another machine a few months ago (never 
> appeared again for months now).
> 
> What does this mean?? Is my NIC damaged??
> 
> Thanx a lot,
>   Thomas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
