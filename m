Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262309AbRFDREc>; Mon, 4 Jun 2001 13:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263846AbRFDRE1>; Mon, 4 Jun 2001 13:04:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5131 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262309AbRFDREJ>; Mon, 4 Jun 2001 13:04:09 -0400
Subject: Re: IDE corruption, 2.2, VIA chipset in PIO mode
To: nconway.list@ukaea.org.uk (Neil Conway)
Date: Mon, 4 Jun 2001 18:02:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B1B9E8E.B91A021E@ukaea.org.uk> from "Neil Conway" at Jun 04, 2001 03:43:26 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E156xkJ-0005d3-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Used for a while, copied about 7gigs onto it.  Then got lots of BadCRC
> errors when reading from disk (from dma_intr).  Decided to disable DMA
> as a result of this...  

Cable errors. Disabling DMA also disabled error checking and correction

