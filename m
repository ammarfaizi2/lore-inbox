Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267283AbSKTAHX>; Tue, 19 Nov 2002 19:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267395AbSKTAHX>; Tue, 19 Nov 2002 19:07:23 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:20864 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267283AbSKTAHW>; Tue, 19 Nov 2002 19:07:22 -0500
Subject: RE: Serverworks dma_intr: error=0x40 { UncorrectableError }
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Manish Lachwani <manish@Zambeel.com>
Cc: "'Steven Timm'" <timm@fnal.gov>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1951@xch-a.win.zambeel.com>
References: <233C89823A37714D95B1A891DE3BCE5202AB1951@xch-a.win.zambeel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Nov 2002 00:42:39 +0000
Message-Id: <1037752959.1401.12.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 00:04, Manish Lachwani wrote:
> Yes, CSB5/CSB6 does not have this problem. I have been using this with the
> GC-LE chipset. 
> 
> However, there was something that I noticed when I was experimenting with
> the FreeBSD kernel for producing these corruptions. I could not reproduce
> these corruptions with FreeBSD 4.6 and at UDMA 2. I also noticed that the
> PCI config space settings for the IDE controller were different in FreeBSD
> and Linux 2.4.17.

It might be interesting to know what the differences are. Certainly the
bug is a very strange one.

