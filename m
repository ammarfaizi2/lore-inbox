Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130635AbQLFBlO>; Tue, 5 Dec 2000 20:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130251AbQLFBlE>; Tue, 5 Dec 2000 20:41:04 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:516 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130139AbQLFBkt>; Tue, 5 Dec 2000 20:40:49 -0500
Subject: Re: 2.4.0-test12-pre4 + cs46xx + KDE 2.0 = frozen system
To: scole@lanl.gov
Date: Wed, 6 Dec 2000 01:00:03 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <00120515471500.00866@spc.esa.lanl.gov> from "Steven Cole" at Dec 05, 2000 03:47:15 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E143Swc-0000DH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I did confirm that 2.4.0-test11(final) works properly with sound and KDE 2.0.

Ok. That sounds even more like its PCI changes

> I do think its rather odd that these test12-pre3,4,5 kernels all work with
> GNOME and the CD player works then.  KDE 2.0 is doing something different
> at the "Loading the panel" stage that causes this bug to surface.

Do you have a battery monitoring applet running in KDE and not gnome ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
