Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131690AbRBBA0r>; Thu, 1 Feb 2001 19:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131817AbRBBA0h>; Thu, 1 Feb 2001 19:26:37 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:26642 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131690AbRBBA0U>; Thu, 1 Feb 2001 19:26:20 -0500
Subject: Re: hard crashes 2.4.0/1 with NE2K stuff
To: roel@grobbebol.xs4all.nl (Roeland Th. Jansen)
Date: Fri, 2 Feb 2001 00:13:45 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010201231652.A2684@grobbebol.xs4all.nl> from "Roeland Th. Jansen" at Feb 01, 2001 11:16:52 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OTrH-0005Px-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the used board BP6 (abit), apics enabled. non-overclocked. card is a
> 
> 00:09.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL-8029(AS)

Try 2.4.1ac - that should fix it
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
