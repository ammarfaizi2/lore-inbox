Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271669AbRHUNtG>; Tue, 21 Aug 2001 09:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271667AbRHUNs5>; Tue, 21 Aug 2001 09:48:57 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:23569 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271670AbRHUNss>; Tue, 21 Aug 2001 09:48:48 -0400
Subject: Re: New SBE/LMC WAN card drivers
To: nergal@7bulls.com (Rafal Wojtczuk)
Date: Tue, 21 Aug 2001 14:51:50 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010821105234.A1461@lda.sur5.net> from "Rafal Wojtczuk" at Aug 21, 2001 10:52:34 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZBwc-0007qK-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a new version of SBE/LMC WAN Card Drivers for Linux, ready for
> inclusion into the kernel. It can be retrieved (embedded within a src.rpm)
> from
> ftp://ftp.sbei.com/pub/OpenSource/sbe_linux-2.0-1.src.rpm
> Note the module name change (lmc.o -> sbe.o).

If they want them merging into a stable kernel tree then they will need to
submit them as patches like everyone else, and keep the name the same until
2.5

Alan
