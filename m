Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281497AbRKMK5i>; Tue, 13 Nov 2001 05:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281500AbRKMK53>; Tue, 13 Nov 2001 05:57:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30472 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281497AbRKMK5Q>; Tue, 13 Nov 2001 05:57:16 -0500
Subject: Re: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
To: adam-dated-1006079431.a988a6@flounder.net (Adam McKenna)
Date: Tue, 13 Nov 2001 11:04:57 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20011113023029.A15075@flounder.net> from "Adam McKenna" at Nov 13, 2001 02:30:29 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E163bNB-0000pS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am having problems with both UDMA and Multiword DMA.  The problem doesn't
> go away unless I disable CONFIG_IDEDMA_PCI_AUTO.
> 
> I don't know if there is actual FS corruption with MWord DMA, but there is
> definitely a "hang" for a few seconds accompanied by a DMA error.

I've no other reports from MWDMA other than the usual "CDROM that doesnt
handle DMA" things
