Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130405AbQLaX3p>; Sun, 31 Dec 2000 18:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130423AbQLaX3f>; Sun, 31 Dec 2000 18:29:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:54797 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129747AbQLaX3Y>; Sun, 31 Dec 2000 18:29:24 -0500
Subject: Re: tdfx.o and -test13
To: tmh@magenta-netlogic.com (Tony Hoyle)
Date: Sun, 31 Dec 2000 23:01:05 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jjs@pobox.com (J Sloan),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3A4FB803.20765A02@magenta-netlogic.com> from "Tony Hoyle" at Dec 31, 2000 10:49:39 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14CrTQ-0000BD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> make 3.79.1

Ditto

> gcc 2.95.2 20000220
gcc version 2.96 20000731 (Red Hat Linux 7.0)

and I really can't see that being relevant

> ld 2.10.91
GNU ld version 2.10.90 (with BFD 2.10.0.18)

> modversions 2.3.23
insmod version 2.3.21

I see modversions.h being included properly on the command line

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
