Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129937AbQK3Evs>; Wed, 29 Nov 2000 23:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129760AbQK3Ev3>; Wed, 29 Nov 2000 23:51:29 -0500
Received: from zeus.kernel.org ([209.10.41.242]:25872 "EHLO zeus.kernel.org")
        by vger.kernel.org with ESMTP id <S129761AbQK3EvZ>;
        Wed, 29 Nov 2000 23:51:25 -0500
Subject: Re: USB doesn't work with 440MX chipset, PCI IRQ problem?
To: maillist@chello.nl (Igmar Palsenberg)
Date: Thu, 30 Nov 2000 03:28:41 +0000 (GMT)
Cc: J.A.K.Mouw@ITS.TUDelft.NL (Erik Mouw),
        linux-kernel@vger.kernel.org (Linux kernel mailing list)
In-Reply-To: <Pine.LNX.4.21.0011300501500.8081-100000@server.serve.me.nl> from "Igmar Palsenberg" at Nov 30, 2000 05:03:38 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E141KOp-0006mI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     9:       3134          XT-PIC  3c574_cs
> >    11:          1          XT-PIC  Ricoh Co Ltd RL5c475, usb-uhci
> 
> Your videocard is also at 11. Could be an issue if the USB driver hates
> sharing IRQ's.

Other than a boot time lockup bug which is now fixed it should be fine


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
