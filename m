Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281090AbRKEMXk>; Mon, 5 Nov 2001 07:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281095AbRKEMXa>; Mon, 5 Nov 2001 07:23:30 -0500
Received: from router.idknet.com ([193.41.117.4]:53911 "EHLO router.idknet.com")
	by vger.kernel.org with ESMTP id <S281092AbRKEMXL>;
	Mon, 5 Nov 2001 07:23:11 -0500
Message-ID: <015001c165f4$c7f0fed0$05dda8c0@maxim>
From: "MaxiM Basunov" <maxim@idknet.com>
To: <linux-kernel@vger.kernel.org>
Subject: Page cache
Date: Mon, 5 Nov 2001 14:24:12 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I have server with 1G RAM.
And i want to run Oracle WITHOUT swapping it to disk...

how to reduce desires of a kernel about page cache?
Mem:  1028692K av, 1023600K used,    5092K free, 678340K cached...

if i disable swap, linux runs kswapd with "load average 35"...

Kernel 2.4.9

System administrator Maxim Basunov
Tiraspol, Interdnestrcom

