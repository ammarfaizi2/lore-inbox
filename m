Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129226AbQK3QaG>; Thu, 30 Nov 2000 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130083AbQK3Q35>; Thu, 30 Nov 2000 11:29:57 -0500
Received: from mx6.port.ru ([194.67.23.42]:50182 "EHLO mx6.port.ru")
        by vger.kernel.org with ESMTP id <S129183AbQK3Q2w>;
        Thu, 30 Nov 2000 11:28:52 -0500
From: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Re[2]: DMA for triton again...
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: 143.167.4.62 via proxy [143.167.1.16]
In-Reply-To: <3A267541.D1AED8E9@windsormachine.com>
Reply-To: "Guennadi Liakhovetski" <gvlyakh@mail.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Message-Id: <E141W6K-000AgZ-00@f6.mail.ru>
Date: Thu, 30 Nov 2000 18:58:24 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

> Chipset is a 430FX, Same hard drive as what you have.  Pentium > 133, 48 meg ram.  Kernel 2.2.17 with raid patch, and ide patch.  

I don't think I need tha raid patch, do I?

> Shares the ide cable with a WDC 850 meg drive as slave.

No slaves on mine.

> What brand is your motherboard?

Intel Morrison64 (not Morrison32!) aka Advanced/MN (in some sources Advanced/AL). BIOS AMI 1.00.03.CA0 (upgraded to 1.00.04.CA0).

What version of hdparm are you using? By the output it looks like 3.9, patched? Did DMA work from the very beginning? Can you send me a copy of your .config file?

Regards
Guennadi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
