Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbQLBRuS>; Sat, 2 Dec 2000 12:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129692AbQLBRuJ>; Sat, 2 Dec 2000 12:50:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:34316 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129532AbQLBRuB>; Sat, 2 Dec 2000 12:50:01 -0500
Subject: Re: Fasttrak100 questions...
To: pavel@suse.cz (Pavel Machek)
Date: Sat, 2 Dec 2000 17:18:43 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        kernel@blackhole.compendium-tech.com (Dr. Kelsey Hudson),
        hps@tanstaafl.de (Henning P. Schmiedehausen),
        linux-kernel@vger.kernel.org
In-Reply-To: <20001202175035.A253@bug.ucw.cz> from "Pavel Machek" at Dec 02, 2000 05:50:35 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E142GJB-0001kK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is currently happening with lucent winmodem driver: there's
> modified version of serial.c, and customers are asked to compile it
> and (staticaly-)link it against proprietary code to get usable
> driver. Is that okay or not?

Probably not, its up to Ted to enforce I suspect.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
