Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279795AbRJ0JsP>; Sat, 27 Oct 2001 05:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279796AbRJ0JsF>; Sat, 27 Oct 2001 05:48:05 -0400
Received: from cmb1-3.dial-up.arnes.si ([194.249.32.3]:60546 "EHLO
	cmb1-3.dial-up.arnes.si") by vger.kernel.org with ESMTP
	id <S279795AbRJ0Jrv>; Sat, 27 Oct 2001 05:47:51 -0400
From: Igor Mozetic <igor.mozetic@uni-mb.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15322.33513.293148.371409@cmb1-3.dial-up.arnes.si>
Date: Sat, 27 Oct 2001 11:48:25 +0200
To: linux-kernel@vger.kernel.org
Subject: Any stable 2.4 kernel?
X-Mailer: VM 6.96 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if anybody has found a stable kernel for the following
hardware: C440GX+, dual Xeon 550, 2GB RAM, 1GB swap, aic7xxx.
Usage pattern is load > 2, highmem, not much I/O (maybe swap?).
Some of our jobs take weeks, so stable means months between reboots.

I found anything beyond 2.4.10 useless - lockups after a few days.
Currently I run 2.4.3 with varying degree of success - initial lifespan
was 4 months, but last reincarnation survived for 3 weeks only.

Any recommendation for 2.4 or should I consider going back to 2.2 ?
I don't need any fancy features (apart to SMP and highmem),
only stability is important.

-Igor Mozetic
