Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261661AbSJ2ICp>; Tue, 29 Oct 2002 03:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261666AbSJ2ICp>; Tue, 29 Oct 2002 03:02:45 -0500
Received: from [212.3.242.3] ([212.3.242.3]:60402 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S261661AbSJ2ICo>;
	Tue, 29 Oct 2002 03:02:44 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org, Russell King <rmk@arm.linux.org.uk>
Subject: [2.5.44] 8250_cs does not work.
Date: Tue, 29 Oct 2002 09:08:49 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210290908.49320.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Since I've started to test the 2.5 series, I've noticed that 8250_cs doesn't 
really work - it doesn't detect my pcmcia card (psion global gold card).

I had a patch for 2.5.40 from Russell King that fixed it, but I can't get it 
to apply to 2.5.44, and well - out of the box it still doesn't work.

Is there any plan to get that fix in the kernel?

Thanks!

DK
-- 
The scum also rises.
		-- Dr. Hunter S. Thompson

