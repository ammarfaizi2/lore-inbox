Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269158AbRHQACk>; Thu, 16 Aug 2001 20:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269178AbRHQACa>; Thu, 16 Aug 2001 20:02:30 -0400
Received: from [209.10.41.242] ([209.10.41.242]:59100 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S269158AbRHQACX>;
	Thu, 16 Aug 2001 20:02:23 -0400
Organization: 
Date: Fri, 17 Aug 2001 02:56:46 +0300 (EET DST)
From: mythos <papadako@csd.uoc.gr>
To: <linux-kernel@vger.kernel.org>
Subject: VIA vt82c686a and second channel
Message-ID: <Pine.GSO.4.33.0108170253560.624-100000@iridanos.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to enable DMA on the second channel of my controller,I get the
following message:
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: timeout waiting for DMA
ide_dmaproc: chipset supported ide_dma_timeout func only: 14
hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
hdc: DMA disabled
ide1: reset: success
Why is this happening?
What is the difference between the first channel where DMA works just fine
and the second one?
Thanks in advance.

		Mythos


