Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131398AbQKNUyx>; Tue, 14 Nov 2000 15:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131424AbQKNUyn>; Tue, 14 Nov 2000 15:54:43 -0500
Received: from spike2.i405.net ([63.229.23.90]:524 "EHLO spike2.i405.net")
	by vger.kernel.org with ESMTP id <S131398AbQKNUyf>;
	Tue, 14 Nov 2000 15:54:35 -0500
Message-ID: <0066CB04D783714B88D83397CCBCA0CD4963@spike2.i405.net>
From: "Stephen Gutknecht (linux-kernel)" <linux-kernel@i405.com>
To: linux-kernel@vger.kernel.org
Subject: newbie, 2.4.0 on Asus CUSL2 (Intel 815E chipset with onboard vide
	o)
Date: Tue, 14 Nov 2000 12:23:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the prior help on getting the kernel to compile; real newbie
mistake of not finding the right options in the "make menuconfig" screens.

I can now compile 2.4.0-test, but it hangs on the first line of loading.

 -- I have tried 2.4.0-test10 and 2.4.0-test11-pre4
 -- If I only do my network adapter, it compiles and boots fine.  It is when
I add my desired settings (via "make menuconfig") for video support that the
compiled kernel hangs at system boot.

I have documented the exact procedure I use to compile the kernel at:

  http://www.roundsparrow.com/Linux/240oni815/

Help from other CUSL2 owners (or Intel 815E chipset) appreciated.    Feel
free to keep replies off the main list, as this may be a training issue more
than a kernel one :)

  Stephen Gutknecht
  Renton, Washington
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
