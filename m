Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRABRSt>; Tue, 2 Jan 2001 12:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbRABRSj>; Tue, 2 Jan 2001 12:18:39 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:16650
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129729AbRABRS3>; Tue, 2 Jan 2001 12:18:29 -0500
Date: Tue, 2 Jan 2001 08:47:40 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: dep <dennispowell@earthlink.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE-DMA Timeout Bug may be dead...
In-Reply-To: <01010209450300.00545@depoffice.localdomain>
Message-ID: <Pine.LNX.4.10.10101020847100.25677-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Nothing to do with your dirty crosstolak in you ribbon..

On Tue, 2 Jan 2001, dep wrote:

> On Tuesday 02 January 2001 06:00 am, Andre Hedrick wrote:
> | Doing final tests but it may have come to and end and that deadlock
> | may be gone in a few hours after some sleep.
> 
> if it has anything to do with this, then it's reduced but not gone:
> 
> Jan  2 09:42:35 depoffice kernel: hda: dma_intr: status=0x51 { 
> DriveReady SeekComplete Error }
> Jan  2 09:42:35 depoffice kernel: hda: dma_intr: error=0x84 { 
> DriveStatusError BadCRC }
> 
> via, w.d. drive, error been around for months, no apparent effect 
> except to slow things down a tad and fill /var/log/messages.
> 
> -- 
> dep
> --
> bipartisanship: an illogical construct not unlike the idea that
> if half the people like red and half the people like blue, the 
> country's favorite color is purple.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
