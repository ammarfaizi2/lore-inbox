Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270171AbRHGJyj>; Tue, 7 Aug 2001 05:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270166AbRHGJya>; Tue, 7 Aug 2001 05:54:30 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:39696 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S270170AbRHGJyO>; Tue, 7 Aug 2001 05:54:14 -0400
Date: Thu, 2 Aug 2001 13:30:55 +0000
From: Pavel Machek <pavel@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Working reiserfsck?
Message-ID: <20010802133051.A88@toy.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On one of my machines, I installed reiserfs on / fs.... and got to habit
of just powering that machine down with powerswitch. I was running
various kernels at least from 2.4.3 on it.

Now I tried to run reiserfsck, and (besides it having very ugly UI) it
reported some problems. Question is, how to correct those? reiserfsck
attitude seems to be "run me and I'll kill your filesystem". Is it really
that dangerous? Where to get working reiserfsck?
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

