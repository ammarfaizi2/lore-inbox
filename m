Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132140AbRDAKEE>; Sun, 1 Apr 2001 06:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132137AbRDAKDz>; Sun, 1 Apr 2001 06:03:55 -0400
Received: from hyperion.expio.net.nz ([202.27.199.10]:49678 "EHLO expio.co.nz")
	by vger.kernel.org with ESMTP id <S132125AbRDAKDo>;
	Sun, 1 Apr 2001 06:03:44 -0400
Message-ID: <00d501c0ba93$1e6331b0$1400a8c0@expio.net.nz>
From: "Simon Garner" <sgarner@expio.co.nz>
To: <linux-kernel@vger.kernel.org>
Cc: <linux-smp@vger.kernel.org>
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot
Date: Sun, 1 Apr 2001 22:04:17 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mikael Pettersson" <mikpe@csd.uu.se>

> Boot with "nmi_watchdog=0" as a boot parameter. Does it work now?
> 
> Some people have reported before here that the IO-APIC driven NMI
> watchdog itself can cause boot-time hangs.
> 
> /Mikael


Thanks, but I do not have watchdog support compiled into the kernel.


