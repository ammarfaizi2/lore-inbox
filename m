Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129733AbRAHUuP>; Mon, 8 Jan 2001 15:50:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbRAHUuF>; Mon, 8 Jan 2001 15:50:05 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:27399 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129226AbRAHUt4>; Mon, 8 Jan 2001 15:49:56 -0500
Subject: Re: Ext2 (dma ?) error
To: m.duelli@web.de (Michael Duelli)
Date: Mon, 8 Jan 2001 20:51:44 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), m.duelli@web.de (Michael Duelli),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010108214933.A483@Unimatrix01.surf-callino.de> from "Michael Duelli" at Jan 08, 2001 09:49:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14FjGd-0005K1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Nevertheless I checked the partition with my old SuSE 2.2.16 kernel
> and it gave a different error message:
> 
> hda: read_intr: status=0x59 { DriveReady SeekComplete DataRequest Error }
> hda: read_intr: error=0x40 { UncorrectableError } LBAsect = 2421754, sector
> 210048
> end_request: I/O error, dev 03:03 (hda), sector 2100448
> 
> no more dma but read.

Different mode, same error

> Fortunately it is still under warranty.

One to return. If a disk starts to go bad under warranty return and replace it
if you can. It maybe a one off but its often the sign of a disk about to go
completely kerblam

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
