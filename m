Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbSJ2JZA>; Tue, 29 Oct 2002 04:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261806AbSJ2JZA>; Tue, 29 Oct 2002 04:25:00 -0500
Received: from [212.3.242.3] ([212.3.242.3]:29693 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id <S261733AbSJ2JY7>;
	Tue, 29 Oct 2002 04:24:59 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: DevilKin <devilkin-lkml@blindguardian.org>
To: linux-kernel@vger.kernel.org
Subject: [2.5.44] Poweroff after warm reboot
Date: Tue, 29 Oct 2002 10:31:11 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210291031.11837.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

If I reboot my laptop with kernel 2.5.44 (warm reboot), the machine reboots, 
loads the kernel, and then in the middle of the booting process powers off. 

Doing an actual shutdown (poweroff) results in a clean boot next time.

This behaviour is not present with kernel 2.5.40.

The last message I'm able to see before the screen goes blank is something 
about serial io being detected/loaded.

Is this a known bug?

PC is a Dell Latitude CPI A XT 366. More info available if needed.

DK
-- 
It is the business of little minds to shrink.
		-- Carl Sandburg

