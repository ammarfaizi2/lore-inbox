Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129259AbRB1U1t>; Wed, 28 Feb 2001 15:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129270AbRB1U1j>; Wed, 28 Feb 2001 15:27:39 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:60942 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129259AbRB1U1W>;
	Wed, 28 Feb 2001 15:27:22 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200102282027.XAA05533@ms2.inr.ac.ru>
Subject: Re: rsync over ssh on 2.4.2 to 2.2.18
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 28 Feb 2001 23:27:10 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200102272043.UAA01056@raistlin.arm.linux.org.uk> from "Russell King" at Feb 27, 1 08:43:15 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I'll see if I can strace it from the start until it hangs tomorrow.

Please...

Also, try to make binary tcpdump.


> I was running at one point a 2.4.0-test kernel, but I didn't see these

Yes, it did not result in full stall. Lost wakeups were recovered
f.e. by any keyboard activity. 8)

Wow! 2.2.15? rsync surely does work with 2.2.15. The first 2.2 fixing
the same bugs, which solaris has now, was 2.2.17.

Alexey
