Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262751AbTCVNdp>; Sat, 22 Mar 2003 08:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262758AbTCVNdp>; Sat, 22 Mar 2003 08:33:45 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:39321
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262751AbTCVNdo>; Sat, 22 Mar 2003 08:33:44 -0500
Subject: Re: Question about hdparm & dma.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E7C4E8E.9030704@lucidpixels.com>
References: <3E7C4E8E.9030704@lucidpixels.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048345010.8912.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 14:56:51 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 11:52, Justin Piszcz wrote:
> My question is, how is it possible to get > 33MB/s in only UDMA Mode 2 
> (the linux driver only supports up to UDMA2).

You can overclock things if you have the setup wrong.

> So basically I am wondering if udma mode 5 will be supported for SIS 
> chipsets.

I'm wondering if SiS are ever going to provide useful documentation.
SiS won't deal with individuals only companies which complicates matters

> Secondly, I also have one of those Promise/Serial ATA raid on the 
> motherboard (2 serial ata/1 ata133), but that is not supported at all.

That may change if things go ok. 
