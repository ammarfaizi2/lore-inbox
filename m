Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287362AbRL3JDR>; Sun, 30 Dec 2001 04:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287364AbRL3JDI>; Sun, 30 Dec 2001 04:03:08 -0500
Received: from [203.197.145.76] ([203.197.145.76]:43526 "HELO
	mailnpd.hcltech.com") by vger.kernel.org with SMTP
	id <S287362AbRL3JCq>; Sun, 30 Dec 2001 04:02:46 -0500
Message-ID: <015d01c19111$299ab1c0$3e64a8c0@hcltech.com>
From: "Kousalya K" <kkasinat@npd.hcltech.com>
To: <rddunlap@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L2.0112040902260.18921-100000@dragon.pdx.osdl.net>
Subject: Any idea about watchdog timer in linux
Date: Sun, 30 Dec 2001 14:35:42 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6700
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I wanted to call a timer function to get current time within kernel space. I
don't want any function call to do this.
Any idea ? In AIX we have watchdog stucture and w_stop, w_start, w_init
functions are there to stop, initiate and  start the watchdog timer.
Anything like that is available in linux?

TIA,
Kousalya.



