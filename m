Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130543AbRCIRT3>; Fri, 9 Mar 2001 12:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130586AbRCIRTT>; Fri, 9 Mar 2001 12:19:19 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19460 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130543AbRCIRTI>; Fri, 9 Mar 2001 12:19:08 -0500
Subject: Re: 2.2.18, Intel i815 chipset and DMA
To: dbr@greenhydrant.com (David Rees)
Date: Fri, 9 Mar 2001 17:21:36 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010309090641.C13905@greenhydrant.com> from "David Rees" at Mar 09, 2001 09:06:41 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14bQaA-0005Jc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've got a Gateway here with a Intel 815 chipset running 2.2.18.  Inside
> it's a PIII 733 with 512MB and a Quantum lct15 drive.

The UDMA100 on the i810/815 is supported by 2.4

> turn it on?  The drive should be capable of 10-20MB/s, but I'm
> only getting about 4MB/s with hdparm.  :-(

/dev/hda:
 Timing buffered disk reads:  64 MB in  2.62 seconds = 24.43 MB/sec

[2.4.2ac17]

