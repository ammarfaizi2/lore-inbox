Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272029AbRHVPpM>; Wed, 22 Aug 2001 11:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272030AbRHVPpD>; Wed, 22 Aug 2001 11:45:03 -0400
Received: from [66.52.6.235] ([66.52.6.235]:46990 "EHLO puddy.travisshirk.net")
	by vger.kernel.org with ESMTP id <S272032AbRHVPoq>;
	Wed, 22 Aug 2001 11:44:46 -0400
Date: Wed, 22 Aug 2001 09:46:14 -0600 (MDT)
From: Travis Shirk <travis@pobox.com>
X-X-Sender: <travis@puddy.travisshirk.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Kernel Locking Up
Message-ID: <Pine.LNX.4.33.0108220938390.1152-100000@puddy.travisshirk.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Ever since I upgraded to the 2.4.x (currently running 2.4.8)
kernels, my machine has been locking up every other day
or so.  Does anyone have any hints/tips for figuring out
what is going on.

The symptons are total lock-up of the machine.  No mouse
movement, all GUI monoitors freeze, and I cannot switch to a
virtual console.  I'm not able to ping the locked machine or
ssh/telnet into it either.  So I'm left wondering....how and
the hell to I debug this problem.  It'd be nice to have some
more information to go on or post to the list.

I'm running on a dual PIII 850, and this problem occurs with
2.4.7 and 2.4.8.

Any suggestions?

Travis

-- 
Travis Shirk <travis at pobox dot com>
Mathematics is God and Knuth is our prophet.

