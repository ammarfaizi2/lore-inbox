Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310248AbSCKRFV>; Mon, 11 Mar 2002 12:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310222AbSCKRFM>; Mon, 11 Mar 2002 12:05:12 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:32523 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310219AbSCKREy>; Mon, 11 Mar 2002 12:04:54 -0500
Subject: Re: Troubles with ALI15X3 driver in 2.4 kernels
To: ahaas@neosoft.com (Art Haas)
Date: Mon, 11 Mar 2002 17:20:21 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020311110434.B32667@debian> from "Art Haas" at Mar 11, 2002 11:04:34 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kTTB-00018N-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ALI15X3: simplex device:  DMA disabled
> ide0: ALI15X3 Bus-Master DMA disabled (BIOS)
> ALI15X3: simplex device:  DMA disabled
> ide1: ALI15X3 Bus-Master DMA disabled (BIOS)

Is the drive disabled in the BIOS settings ?

> ide_dmaproc: chipset supported ide_dma_timeout func only: 14
> hda: status error: staus = 0x58 { DriveReady SeekComplete DataRequest}
> ... a few more of the same ...
> hda: drive not ready for command

> My system - i586-pc-linux-gnu
> Compiler - gcc-3.0.5 (cvs)

At this point I just lost interest. Please reproduce it with 2.95/2.96 - I'm
betting you can but it would be nice to be sure.
