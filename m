Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbQKMAoG>; Sun, 12 Nov 2000 19:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbQKMAn4>; Sun, 12 Nov 2000 19:43:56 -0500
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:33195 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S129047AbQKMAnq>; Sun, 12 Nov 2000 19:43:46 -0500
Message-Id: <5.0.0.25.2.20001113002439.0572d070@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0
Date: Mon, 13 Nov 2000 00:43:44 +0000
To: Alan.Cox@linux.org
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Linux-2.2.x-BUG(?) memmory not detected
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just noticed that both 2.2.18pre21 and RedHat-7.0-patched-2.2.16 kernels 
only detect 64Mb out of 192Mb RAM on my Dual Celeron/Intel 440GX chipset 
based workstation. - I haven't tried any other 2.2 kernels on that 
particular PC so maybe this is a general 2.2.x thing.

The setup is one 64Mb SDRAM and one 128Mb SDRAM so it would seem that the 
128Mb one is not detected at all.

All 2.3/2.4 kernels I have tried have always detected the full 192Mb RAM.

Is this a known feature or a bug? - If I can supply any more info to help 
track this down just let me know what you want to know and I will be happy 
to obtain the information from this PC...

Regards,

         Anton

-- 
      "Education is what remains after one has forgotten everything he 
learned in school." - Albert Einstein
-- 
Anton Altaparmakov
Christ's College    eMail: AntonA@bigfoot.com / aia21@cam.ac.uk
Cambridge CB2 3BU    ICQ: 8561279
United Kingdom       WWW: http://www-stu.christs.cam.ac.uk/~aia21/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
