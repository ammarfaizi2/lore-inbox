Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288089AbSAMUOQ>; Sun, 13 Jan 2002 15:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288090AbSAMUOH>; Sun, 13 Jan 2002 15:14:07 -0500
Received: from paloma13.e0k.nbg-hannover.de ([62.181.130.13]:57272 "HELO
	paloma13.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288089AbSAMUNI>; Sun, 13 Jan 2002 15:13:08 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: J Sloan <jjs@pobox.com>, Robert Love <rml@tech9.net>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Sun, 13 Jan 2002 21:11:56 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020113201352Z288089-13997+4417@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem here is that when people report
> that the low latency patch works better for them
> than the preempt patch, they aren't talking about
> bebnchmarking the time to compile a kernel, they
> are talking about interactive feel and smoothness.
>
> You're speaking to a peripheral issue.

Yes, but I did latency testing for Robert for several months, now.

> I've no agenda other than wanting to see linux
> as an attractive option for the multimedia and
> gaming crowds

I am, too. But more for 3D visualization/simulation (with audio).

> - and in my experience, the low
> latency patches simply give a much smoother
> feel and a more pleasant experience.

Not for me. Even when lock-brake is applied.

> Kernel
> compilation time is the farthest thing from my
> mind when e.g. playing Q3A!

Q3A is _NOT_ changed in any case. Even some smoother system "feeling" with 
Q3A and UT 436 running in parallel on an UP 1 GHz Athlon II, 640 MB. Have you 
seen something on any Win box?

> I'd be happy to check out the preempt patch
> again and see if anything's changed, if the
> problem of tux+preempt oopsing has been
> dealt with -

You told me that TUX show some problems with preempt before.
What problems? Are they TUX specific?

Some latency numbers coming soon.

-Dieter

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
