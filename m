Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135186AbQLIA0o>; Fri, 8 Dec 2000 19:26:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135184AbQLIA0e>; Fri, 8 Dec 2000 19:26:34 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:29203 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133075AbQLIA0S>; Fri, 8 Dec 2000 19:26:18 -0500
Subject: Re: [PATCH] for YMF PCI sound cards
To: zaitcev@metabyte.com (Pete Zaitcev)
Date: Fri, 8 Dec 2000 23:57:27 +0000 (GMT)
Cc: proski@gnu.org (Pavel Roskin), linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, zaitcev@metabyte.com (Pete Zaitcev),
        perex@suse.cz (Jaroslav Kysela)
In-Reply-To: <200012081831.KAA06813@ns1.metabyte.com> from "Pete Zaitcev" at Dec 08, 2000 10:31:10 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144XOM-0004ee-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	{0x414B4D01, "Asahi Kasei AK4540 rev 1", NULL},
> > +	{0x41445303, "Yamaha YMF????"          , NULL},
> 
> Are you sure it's correct? I am almost certain that no YMFxxx

Its definitely wrong

> has on-chip AC97. I'd like to see a document that allows you
> the change quoted above.

4144 is Analog Devices vendor ID. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
