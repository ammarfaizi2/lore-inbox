Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132437AbQLJBiv>; Sat, 9 Dec 2000 20:38:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132466AbQLJBil>; Sat, 9 Dec 2000 20:38:41 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:776 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132437AbQLJBi2>; Sat, 9 Dec 2000 20:38:28 -0500
Subject: Re: 2.2.18pre21 oops reading /proc/apm
To: neale@lowendale.com.au (Neale Banks)
Date: Sun, 10 Dec 2000 01:09:06 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), sfr@linuxcare.com (Stephen Rothwell),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.05.10012101021450.16389-100000@marina.lowendale.com.au> from "Neale Banks" at Dec 10, 2000 10:26:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144uzE-00060S-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I did this (at least I think I got it right: the patch was happy) but
> I can't see anything resembling DMI strings (even after I removed

Ok your machine probably doesnt have DMI then. That unfortunately means its
hard to identify the specific machine


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
