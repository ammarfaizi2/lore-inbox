Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290713AbSARPJ7>; Fri, 18 Jan 2002 10:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290714AbSARPJt>; Fri, 18 Jan 2002 10:09:49 -0500
Received: from [202.87.41.13] ([202.87.41.13]:21741 "HELO postfix.baazee.com")
	by vger.kernel.org with SMTP id <S290713AbSARPJa>;
	Fri, 18 Jan 2002 10:09:30 -0500
Message-ID: <001701c1a032$50c82ef0$3c00a8c0@baazee.com>
Reply-To: "Anish Srivastava" <anishs@vsnl.com>
From: "Anish Srivastava" <anishs@vsnl.com>
To: <linux-kernel@vger.kernel.org>
Subject: kswapd kills linux box with kernel 2.4.17
Date: Fri, 18 Jan 2002 20:40:46 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am having a box with 8GB RAM and 8 CPU's.

I just changed updated the kernel to 2.4.17 and it booted up fine.....but as
soon as it started warming up
and using some memory.....kswapd came in and locked the CPU and the box
overall. The load went
upto about 29. It locked up the box and the CPU usage was at 99%

After sometime it did finish and I regained control on my system, but then
after some time the same problem

Can any of you help??

Thanks in anticipation.

Regards,
Anish Srivastava

