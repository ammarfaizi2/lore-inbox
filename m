Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131085AbQLCTQE>; Sun, 3 Dec 2000 14:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131116AbQLCTPy>; Sun, 3 Dec 2000 14:15:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11066 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131115AbQLCTPp>; Sun, 3 Dec 2000 14:15:45 -0500
Subject: Re: Fasttrak100 questions...
To: Wayne.Brown@altec.com
Date: Sun, 3 Dec 2000 18:45:18 +0000 (GMT)
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <862569AA.005C068D.00@smtpnotes.altec.com> from "Wayne.Brown@altec.com" at Dec 03, 2000 10:41:20 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E142e8W-0002zx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Where can this Lucent driver be found?  The one I use with my Thinkpad is
> version 5.68.  It comes as a loadable module (ltmodem.o) with no serial.c, and I
> havent gotten it to work with any kernel later than 2.2.14.

The serial API had to change in 2.2.15. I know it broke the lucent driver, the
fix was a neccessary security fix

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
