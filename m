Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132109AbRDAJSv>; Sun, 1 Apr 2001 05:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132112AbRDAJSl>; Sun, 1 Apr 2001 05:18:41 -0400
Received: from hyperion.expio.net.nz ([202.27.199.10]:4366 "EHLO expio.co.nz")
	by vger.kernel.org with ESMTP id <S132109AbRDAJSc>;
	Sun, 1 Apr 2001 05:18:32 -0400
Message-ID: <00a401c0ba8c$c54efdd0$1400a8c0@expio.net.nz>
From: "Simon Garner" <sgarner@expio.co.nz>
To: "Allen Campbell" <lkml@campbell.cwx.net>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <004801c0ba62$6cd67810$1400a8c0@expio.net.nz> <20010331221319.A95411@const.>
Subject: Re: Asus CUV4X-D, 2.4.3 crashes at boot
Date: Sun, 1 Apr 2001 21:18:25 +1200
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

From: "Allen Campbell" <lkml@campbell.cwx.net>

> I've seen the exact same behavior with my CUV4X-D (2x1GHz) under
> 2.4.2 (debian woody).  In addition, the kernel would sometimes hang
> around NMI watchdog enable.  At least, I think it's trying to
> `enable'.  The hang would occur around 50% of boot attempts.  Once
> booted, everything was stable.  A non-SMP 2.4.2 kernel (no IO-APIC
> either, sorry, didn't test that) always booted without hangs.

Yep, sounds like the same problem.


>
> Strangely, (happily for me,) the boot hangs stopped with 2.4.3.
> I've booted maybe 10 times (hot and cold) since I built 2.4.3 and
> I've had no hangs.  When I get back to the box, I'll try booting
> a few dozen more times and see if I can confirm your observation.
>

Please do test it. I think you'll find the problem is still very much
present.


Cheers

Simon Garner

