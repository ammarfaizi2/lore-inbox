Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265436AbRF2DHq>; Thu, 28 Jun 2001 23:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265474AbRF2DHh>; Thu, 28 Jun 2001 23:07:37 -0400
Received: from crete.csd.uch.gr ([147.52.16.2]:17626 "EHLO crete.csd.uch.gr")
	by vger.kernel.org with ESMTP id <S265436AbRF2DH2>;
	Thu, 28 Jun 2001 23:07:28 -0400
Organization: 
Date: Fri, 29 Jun 2001 06:06:41 +0300 (EET DST)
From: mythos <papadako@csd.uoc.gr>
To: <linux-kernel@vger.kernel.org>
Subject: Problem with Via VT82C686A
Message-ID: <Pine.GSO.4.33.0106290600290.28793-100000@iridanos.csd.uch.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have installed a second hard drive in my system in the second
channel of my controller.But when I try to enable DMA I get:
hdc: DMA disabled
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

I thought that there were problems only with Via VT82C686B.
Can anyone please help me?
My motherbord is an ASUS K7V with KX133 chipset.


