Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129416AbQKPGHL>; Thu, 16 Nov 2000 01:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQKPGHB>; Thu, 16 Nov 2000 01:07:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:1834 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129416AbQKPGGy>; Thu, 16 Nov 2000 01:06:54 -0500
Subject: Re: NatSemi CS5530 Sound Support
To: Matthewc@aeimusic.com (Matthew Carlisle)
Date: Thu, 16 Nov 2000 05:37:34 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1DA9F58AA962D4118EAE00508B5BD5439B8F7F@MAIL01SEA> from "Matthew Carlisle" at Nov 15, 2000 05:05:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E13wHjv-0007W6-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there any plans to develop kernel sound driver support for the
> Cyrix/NatSemi CS5530 chipset?  I noticed PCI and IDE support for this

None whatsoever. Use the sb16 driver.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
