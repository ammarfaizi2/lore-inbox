Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQLDMJH>; Mon, 4 Dec 2000 07:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbQLDMJA>; Mon, 4 Dec 2000 07:09:00 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12110 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129413AbQLDMIf>; Mon, 4 Dec 2000 07:08:35 -0500
Subject: Re: [PATCH] i810_audio 2.4.0-test11
To: pavel@suse.cz (Pavel Machek)
Date: Mon, 4 Dec 2000 11:37:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        tjeerd.mulder@fujitsu-siemens.com (Tjeerd Mulder),
        torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <20001203222300.B165@bug.ucw.cz> from "Pavel Machek" at Dec 03, 2000 10:23:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E142tvc-0003je-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Tjeerd. I deliberately applied only small bits of your patch before because
> > the mono mode stuff clutters the driver horribly and is not in the right place.
> > It belongs in the application/libraries
> 
> Then you should kill parts of drivers/usb/audio - it contains format conversions.

Definitely we should

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
