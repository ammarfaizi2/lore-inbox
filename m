Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272253AbRIRPjX>; Tue, 18 Sep 2001 11:39:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272158AbRIRPjN>; Tue, 18 Sep 2001 11:39:13 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46598 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S272253AbRIRPjI>; Tue, 18 Sep 2001 11:39:08 -0400
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
To: VDA@port.imtp.ilyichevsk.odessa.ua
Date: Tue, 18 Sep 2001 16:43:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <11433641523.20010918175148@port.imtp.ilyichevsk.odessa.ua> from "VDA" at Sep 18, 2001 05:51:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15jN29-00017p-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> stomper, I think patch could be applied to
> arch/i386/kernel/pci-pc.c in mainline kernel.
> Diffed against 4.2.9.
> BTW, there are similar fixup routines in drivers/pci/quirks.c

arch/i386/kernel/pci-pc   PC specific fixups

drivers/pci/quirks.c 	Cross platform fixes
