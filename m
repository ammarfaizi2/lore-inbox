Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131049AbRBIXBA>; Fri, 9 Feb 2001 18:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131060AbRBIXAv>; Fri, 9 Feb 2001 18:00:51 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:56582 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131049AbRBIXAf>; Fri, 9 Feb 2001 18:00:35 -0500
Subject: Re: Linux 2.4.1ac9
To: sorisor@Hell.WH8.TU-Dresden.De (Udo A. Steinberg)
Date: Fri, 9 Feb 2001 23:01:13 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <3A847252.54AD7579@Hell.WH8.TU-Dresden.De> from "Udo A. Steinberg" at Feb 09, 2001 11:42:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14RMXU-0008DV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've noticed that -ac9 comes with the "Disable PCI-Master-Read-Caching
> on VIA" patch that Peter Horton posted a while back. I don't know
> whether it was applied in Linus' or your tree first, but is it
> actually verified to fix anything?

Not yet. As the story becomes clear it can either be dropped or pushed
on

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
