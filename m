Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262170AbRFQRui>; Sun, 17 Jun 2001 13:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRFQRu2>; Sun, 17 Jun 2001 13:50:28 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:46342
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S262170AbRFQRuM>; Sun, 17 Jun 2001 13:50:12 -0400
Date: Sun, 17 Jun 2001 10:48:36 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4 VM & swap question
Message-ID: <20010617104836.B11642@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

'lo all.  I've got a question about swap and RAM requirements in 2.4.  Now,
when 2.4.0 was kicked out, the fact that you need swap=2xRAM was mentioned.
But what I'm wondering is what exactly are the limits on this.  Right now
I've got an x86 box w/ 128ram and currently 256swap.  When I had 128, I'd get
low on ram/swap after some time in X, and doing this seems to 'fix' it, in
2.4.4.  However, I've also got 2 PPC boxes, both with 256:256 in 2.4.  One
of which never has X up, but lots of other activity, and swap usage seems
to be about the same as 2.2.x (right now 'free' says i'm ~40MB into swap,
18day+ uptime).  The other box is a laptop and has X up when it's awake and
that too doesn't seem to have any problem.  So what exactly is the real
minium swap ammount?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
