Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129775AbQLaQnJ>; Sun, 31 Dec 2000 11:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbQLaQm7>; Sun, 31 Dec 2000 11:42:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62476 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129775AbQLaQmo>; Sun, 31 Dec 2000 11:42:44 -0500
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
To: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw)
Date: Sun, 31 Dec 2000 16:13:22 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <20001231165058.H940@arthur.ubicom.tudelft.nl> from "Erik Mouw" at Dec 31, 2000 04:50:58 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14Cl6r-0008BG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> But that doesn't solve the problem with corrupted sound, serial drop
> outs, etc. To solve those issues (well, to decrease their impact),
> could we cache the results from a previous call and only call the APM
> BIOS once a minute or so?

Userspace issue. 

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
