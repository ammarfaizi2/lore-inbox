Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267253AbSK3Oqf>; Sat, 30 Nov 2002 09:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267254AbSK3Oqf>; Sat, 30 Nov 2002 09:46:35 -0500
Received: from [213.140.2.50] ([213.140.2.50]:42942 "EHLO
	mailres.fastwebnet.it") by vger.kernel.org with ESMTP
	id <S267253AbSK3Oqe>; Sat, 30 Nov 2002 09:46:34 -0500
Message-Id: <5.1.1.5.2.20021130150415.028fda08@popmail.iol.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.1.1
Date: Sat, 30 Nov 2002 15:09:07 +0100
To: acpi-devel@sourceforge.net
From: Alberto Ornaghi <alor@iol.it>
Subject: [2.5.50] ACPI problems on presario 705
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I enable the ACPI subsystem it doesn't boot at all.
no log in /var/log/messages, only a call trace on the video, but it is too 
long and it scroll down too fast so I can only see few line.

the call trace ends with this message:

Code: 8b 00 0f 0d 00 81 7c 24 0c ac 00 45 c0 0f 85 7a ff ff ff 9c
  <0>Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

sorry, my laptop doesn't have a serial port, so I cannot dump the call 
trace...
anyone who can ? anyone experiencing the same problem ?

passing the acpi=off option the kernel boots normally

I'm running acpi 20021122 under 2.4.20 and it works like a charme...

are there substantial difference between the 2.4. and 2.5. version of ACPI ?

bye

    --==> ALoR <==---------------------- -  -   -

There are only 10 types of people in this world...
those who understand binary, and those who don't.

