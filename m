Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTBLUZg>; Wed, 12 Feb 2003 15:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbTBLUZg>; Wed, 12 Feb 2003 15:25:36 -0500
Received: from mail.dir.bg ([194.145.63.28]:25768 "EHLO dir.bg")
	by vger.kernel.org with ESMTP id <S267613AbTBLUZf>;
	Wed, 12 Feb 2003 15:25:35 -0500
Date: Wed, 12 Feb 2003 23:32:20 +0300
From: "Andrey V. Ignatov" <mef@dir.bg>
X-Mailer: The Bat! (v1.61) Business
Reply-To: "Andrey V. Ignatov" <mef@dir.bg>
X-Priority: 3 (Normal)
Message-ID: <164518946245.20030212233220@dir.bg>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: SMP lock ups on Intel SCB2 (2.4.19-2.4.21-pre4)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried linux kernels from 2.4.19 to 2.4.21-pre4 and all of them lock
up my server under heavy CPU load if i enable SMP. And after lookup i
have If i disable SMP
all works fine.
I tried win2K & winXP too and under this OSes both processors worked
fine under heavy load, but i like linux very much and hate win on
servers.
Please help me.
My hardware:
Intel SCB2 board with latest BIOS
Two PIII-1266MHz stepping 01
kernel lock ups after 10-30 minutes of heavy load with no messages on
console or in logs :(
But BIOS event log before lock up contain a lot of messages: Critical
interrupt #07.
Maybe it's hardware problem? But why windows still working fine for
more than 48h under heavy load ? :(

Please CC to me because i am not list subscriber
  

-- 
Best regards,
 Andrey                          mailto:mef@dir.bg


