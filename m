Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129529AbQKWDu0>; Wed, 22 Nov 2000 22:50:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131179AbQKWDuQ>; Wed, 22 Nov 2000 22:50:16 -0500
Received: from proxy.outblaze.com ([202.77.223.120]:57861 "HELO
        proxy.outblaze.com") by vger.kernel.org with SMTP
        id <S129529AbQKWDuB>; Wed, 22 Nov 2000 22:50:01 -0500
Date: 23 Nov 2000 03:19:51 -0000
Message-ID: <20001123031951.1726.qmail@yusufg.portal2.com>
From: Yusuf Goolamabbas <yusufg@outblaze.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test11 reports CPU inconsistent variable MTRR settings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I installed 2.4.0-test11 on a Dual P3-550 [Tyan Tiger 133 with
S1834 BIOS]. I updated the mobo with the latest bios found on Tyan's
website

http://www.tyan.com/support/html/b_tg_133.html

Reading dmesg, I found the following

mtrr: your CPUs had inconsistent variable MTRR settings
mtrr: probably your BIOS does not setup all CPUs

Am not sure if this is going to lead to bad juju. Anybody else seeing
this on a similar mobo

Regards, Yusuf

-- 
Yusuf Goolamabbas
yusufg@outblaze.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
