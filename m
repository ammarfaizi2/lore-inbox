Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131451AbQLMWmz>; Wed, 13 Dec 2000 17:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131478AbQLMWmq>; Wed, 13 Dec 2000 17:42:46 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:39437 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131451AbQLMWm1>; Wed, 13 Dec 2000 17:42:27 -0500
Subject: Re: insmod problem after modutils upgrading
To: kaos@ocs.com.au (Keith Owens)
Date: Wed, 13 Dec 2000 22:13:29 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        chris@chrullrich.de (Christian Ullrich), linux-kernel@vger.kernel.org
In-Reply-To: <4381.976745113@ocs3.ocs-net> from "Keith Owens" at Dec 14, 2000 09:05:13 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146K9T-0003MT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> previously because nobody used those options.  Since these are bugs in
> the modules and only a few modules are affected (less than 5 reported),
> the fix is to correct the modules that have coding errors.

That wont be happening in 2.2 until 2.2.19 which probably means 6 months.
If this is your decision please make it abundantly clear that the new
modutils are a 2.4 only package.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
