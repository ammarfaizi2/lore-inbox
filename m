Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129109AbRBBPJ0>; Fri, 2 Feb 2001 10:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129126AbRBBPJQ>; Fri, 2 Feb 2001 10:09:16 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:40966 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129109AbRBBPJI>; Fri, 2 Feb 2001 10:09:08 -0500
Subject: Re: vaio doesn't boot with 2.4.1-ac1, stops at PCI: Probing PCI hardware
To: ookhoi@dds.nl
Date: Fri, 2 Feb 2001 15:09:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010202140731.E3922@ookhoi.dds.nl> from "Ookhoi" at Feb 02, 2001 02:07:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14OhqD-0006cy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Does 2.4.1 with the following patch applied still boot
> 
> No, it doesn't boot anymore (hangs at probing pci hardware again).
> I hope this helps. :-)

Excellent. That means I have a good handle on the problem. It also means I
know which bits to not send Linus 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
