Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133087AbQL3SUI>; Sat, 30 Dec 2000 13:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135248AbQL3ST7>; Sat, 30 Dec 2000 13:19:59 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17162 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133087AbQL3STw>; Sat, 30 Dec 2000 13:19:52 -0500
Subject: Re: Linux 2.2.18: /proc/apm slows system time (was: Linux 2.2.19pre3)
To: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw)
Date: Sat, 30 Dec 2000 17:50:51 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        matthias.andree@stud.uni-dortmund.de (Matthias Andree),
        linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <20001230183837.C1536@arthur.ubicom.tudelft.nl> from "Erik Mouw" at Dec 30, 2000 06:38:38 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14CQ9d-0006qx-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > made the box visibly stall and jerk doing X operations
> 
> Yup, same over here. Is there any way to find out if my laptop also
> enters SMM mode? Just to check if it has the same problem as your
> laptop.

Not unless you want to stick wires into it and onto the i2c bus 8) At least
not that I know of other than disassembling the drivers

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
