Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129431AbQLaXMl>; Sun, 31 Dec 2000 18:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130177AbQLaXMb>; Sun, 31 Dec 2000 18:12:31 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:51725 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129431AbQLaXMN>; Sun, 31 Dec 2000 18:12:13 -0500
Subject: Re: tdfx.o and -test13
To: tmh@magenta-netlogic.com (Tony Hoyle)
Date: Sun, 31 Dec 2000 22:43:48 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), jjs@pobox.com (J Sloan),
        linux-kernel@vger.kernel.org (Kernel Mailing List)
In-Reply-To: <3A4FB514.67F0EA39@magenta-netlogic.com> from "Tony Hoyle" at Dec 31, 2000 10:37:08 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14CrCg-00009m-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Possibly something in the auto-dependencies?  Unfortunately I don't have
> the info files for gcc so
> I can't work out why the '-include' directive would be
> overridden/ignored.

Im wondering if it is make dependant. It seems to be working here
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
