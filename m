Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263173AbRFCO5r>; Sun, 3 Jun 2001 10:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263175AbRFCOw0>; Sun, 3 Jun 2001 10:52:26 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:58372 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263171AbRFCOsB>; Sun, 3 Jun 2001 10:48:01 -0400
Subject: Re: Linux 2.4.5-ac7
To: rmk@arm.linux.org.uk (Russell King)
Date: Sun, 3 Jun 2001 15:45:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), green@linuxhacker.ru (Oleg Drokin),
        laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010603133333.A25478@flint.arm.linux.org.uk> from "Russell King" at Jun 03, 2001 01:33:33 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156Z88-0004O1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan, a StrongARM 11x0 with its companion SA11x1 chip is a USB master.
> Last time I looked, it was supported:

> + * usb-ohci-sa1111.h

So the SA1110 has PCI bus ? Or at least equivalent logic ?


