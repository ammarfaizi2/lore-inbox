Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129164AbRBVWk4>; Thu, 22 Feb 2001 17:40:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130298AbRBVWkq>; Thu, 22 Feb 2001 17:40:46 -0500
Received: from altern.org ([212.73.209.210]:55563 "HELO altern.org")
	by vger.kernel.org with SMTP id <S129555AbRBVWkj>;
	Thu, 22 Feb 2001 17:40:39 -0500
Date: Thu, 22 Feb 2001 23:35:43 +0100 (CET)
From: <alcove@altern.org>
Subject: re : Re: Problem with ATA/UDMA
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Message-Id: <20010222224040Z129555-30605+148@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> hdf: timeout waiting for DMA
>> ide_dmaproc : chipset supported ide_dma_timeout func only : 14
>> hdf : irq timeout : status=0x48 {DriveReady DataRequest }
>> hdf : DMA disabled
>> ide2 : reset : master : error (0x0a?)
>> ***************
>> 
>> I would like to know what the probem is.
>> I looked on the net and found that some people had exactly the same output in very earlier kernel versions (2.0)
>> Anyway, does anyone know about a bug on this? Is there any patch, or any current development about this?

>yes, there's current development on it.  have you tried 2.4.2?

Thanks for this so fast answer.

I have just started running 2.4.2 (a few minutes ago.)
Is it of any interest that I keep reporting this kind of problems on this mailing list?


Vincent
