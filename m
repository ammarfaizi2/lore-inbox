Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313199AbSELNYB>; Sun, 12 May 2002 09:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313384AbSELNYA>; Sun, 12 May 2002 09:24:00 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:44041 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313199AbSELNX7>; Sun, 12 May 2002 09:23:59 -0400
Subject: Re: IRQ > 15 for Athlon SMP boards
To: hugh@nospam.com (Hugh)
Date: Sun, 12 May 2002 14:43:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CDE5110.5090608@nospam.com> from "Hugh" at May 12, 2002 08:25:04 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E176tda-0003Ru-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Asus A7M266-D with two Athlon MP 1900+'s (running at 1.6GHz) with
> 2GB registered DDR at 133MHz.
> Ethernet IntelPro 100 working fine with IRQ19.
> The ASUS BIOS version 1.005a.
> SuSE-7.3.

With Red Hat 7.2 and dual MP 1800+'s its all working fine for me

> G400.  Those two boards worked fine on a Intel-P4 machine.
> This means that I keep XF86Config files for the respective
> boards perfectly working on the Intel P4.

The bus layout will depend on the motherboard remember
