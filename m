Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSGUTW0>; Sun, 21 Jul 2002 15:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313113AbSGUTW0>; Sun, 21 Jul 2002 15:22:26 -0400
Received: from mx2.elte.hu ([157.181.151.9]:48526 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S312938AbSGUTWZ>;
	Sun, 21 Jul 2002 15:22:25 -0400
Date: Sun, 21 Jul 2002 21:24:25 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: Re: [patch] "big IRQ lock" removal, 2.5.27-A1
In-Reply-To: <Pine.LNX.4.44.0207212111300.24336-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0207212121050.24336-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (there's one more open bug, i can now see the 'exited with preempt_count
> 1' messages.)

fixed this bug as well, new patch is at:

   http://redhat.com/~mingo/remove-irqlock-patches/remove-irqlock-2.5.27-A4

	Ingo

