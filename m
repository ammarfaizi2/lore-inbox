Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129150AbQKPWeL>; Thu, 16 Nov 2000 17:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbQKPWeC>; Thu, 16 Nov 2000 17:34:02 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:16968 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129150AbQKPWdt>; Thu, 16 Nov 2000 17:33:49 -0500
Subject: Re: RFC: "SubmittingPatches" text
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Thu, 16 Nov 2000 22:04:02 +0000 (GMT)
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <200011162132.PAA01944@mandrakesoft.mandrakesoft.com> from "Jeff Garzik" at Nov 16, 2000 03:32:40 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wX8W-0008Qt-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	The Unofficial Linus HOWTO

	'Care And Operation Of Your Linus Torvalds'


> 	mv linux linux-vanilla
> 	diff -urN linux-vanilla $MYSRC > /tmp/patch

Include Tigrans recommended exclude list and info

> code.  A MIME attachment also takes Linus a bit more time to process,
> decreasing the likelihood of your MIME-attached change being accepted.

+ If your mailer is mangling patches then someone may ask you to resend them
+ using MIME.

Maybe also note that maintainers of given modules are much more likely to
give feedback than Linus, also the [PATCH]: convention


Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
