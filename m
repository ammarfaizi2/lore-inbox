Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129219AbRBLIOm>; Mon, 12 Feb 2001 03:14:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbRBLIOc>; Mon, 12 Feb 2001 03:14:32 -0500
Received: from server1.cosmoslink.net ([208.179.167.101]:55155 "EHLO
	server1.cosmoslink.net") by vger.kernel.org with ESMTP
	id <S129219AbRBLIOU>; Mon, 12 Feb 2001 03:14:20 -0500
Message-ID: <000901c094cc$880a75c0$bba6b3d0@Toshiba>
From: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Jaswinder Singh" <jaswinder.singh@3disystems.com>
Subject: Problem with Ramdisk in linux-2.4.1 
Date: Mon, 12 Feb 2001 00:19:33 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear linux-kernel mailing list,

I am facing this problem in linux-2.4.1 :-

RAMDISK driver initialized: 16 RAM disks of 8192K size
1024 blocksize
RAMDISK: Compressed image found at block 0
 incomplete distance tree
invalid compressed format (err=1)Freeing initrd
memory: 4096k freed

Is any body seen this problem earlier , any hint .

But this ramdisk works fine with linux-2.2.12 .

Thanks ,

Best Regards,

Jaswinder.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
