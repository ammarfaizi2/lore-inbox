Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129963AbQK1JEI>; Tue, 28 Nov 2000 04:04:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130215AbQK1JD6>; Tue, 28 Nov 2000 04:03:58 -0500
Received: from fw.pvt.cz ([194.149.101.194]:64273 "EHLO fw.pvt.cz")
        by vger.kernel.org with ESMTP id <S129963AbQK1JDx>;
        Tue, 28 Nov 2000 04:03:53 -0500
Date: Tue, 28 Nov 2000 09:33:34 +0100 (CET)
From: Tom Mraz <t8m@centrum.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Status of the NTFS driver in 2.4.0 kernels?
Message-ID: <Pine.LNX.4.30.0011280912030.16603-100000@p38mraz.cbu.pvt.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've tried to use the readonly NTFS driver in 2.4.0-test11 kernel, but it
reported me a kernel BUG at fs.c:567. I've searched the archives where David
Weinehall writes that the driver even in readonly mode doesn't support the
Win2k NTFS. But I don't have Win2k NTFS (I have WinNT 4.0 SP 6) and the
kernel still reports this bug :-(. The driver from 2.2.17 kernel seems to
work fine. Could someone help me?

Please Cc me, because I'm not subscribed to the kernel mailing list. (Or
don't if you don't want to because I read the archives regularly. :-))

Thanks,

Tomas Mraz

-----------------------------------------------------------------
No matter how far down the wrong road you've gone, turn back.
						Turkish proverb

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
