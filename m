Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130198AbRBAJQS>; Thu, 1 Feb 2001 04:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130206AbRBAJQI>; Thu, 1 Feb 2001 04:16:08 -0500
Received: from h179-210-243-135.iii.org.tw ([210.243.135.179]:24801 "EHLO
	mta0.iii.org.tw") by vger.kernel.org with ESMTP id <S130221AbRBAJP5>;
	Thu, 1 Feb 2001 04:15:57 -0500
Message-ID: <02d601c08c2f$291b9940$4c0c5c8c@trd.iii.org.tw>
From: "Greeen-III" <greeen@iii.org.tw>
To: "LinuxKernelMailList" <linux-kernel@vger.kernel.org>
Subject: Dump the memory when fail in gunzip ramdisk 
Date: Thu, 1 Feb 2001 17:08:27 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I boot the Linux/MIPS kernel in the emulator board.
But the kernel will halt in gunzip the ramdisk.
And the LCD on the emulator board will show the memory dump.
Is there any possibility to make this kind of problem?

I guess the reason is running out of memory.

Any possibility is welcome!! Thanks!!

************************************
* It's Green!! (萬林明)
* TEL: 886-2-23776100  ext.620
* mailto:greeen@iii.org.tw
* Working at III(資策會)
* 台北市大安區敦化南路二段216號12F
************************************




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
