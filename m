Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268714AbRH0WWG>; Mon, 27 Aug 2001 18:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269463AbRH0WV4>; Mon, 27 Aug 2001 18:21:56 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:36382 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S268714AbRH0WVq>; Mon, 27 Aug 2001 18:21:46 -0400
Date: Mon, 27 Aug 2001 18:22:04 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: A tester is needed with dual P3 and USB
Message-ID: <20010827182204.A25212@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, All:

I received a complaint that a UP kernel hangs on boot if USB is
enabled. SMP works. An SMP kernel started with "nosmp" hangs too.
The reporter is, umm, how shall I put it... is a power user.

I need someone to help me to track the problem down, because
I am curious. I heard of SMP hangs before, but a UP hang is
a novel idea.

The box is VA Linux 1000 (similar to IBM Netfinity 4000r).
Kernel is 2.4.8-ac10.

If you love me (or USB subsystem in kernel) enough to help
me out, and you your hardware reproduces the problem,
please reply privately.

Thanks in advance,
-- Pete
