Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271577AbTGQVyX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271579AbTGQVyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:54:23 -0400
Received: from adicia.telenet-ops.be ([195.130.132.56]:41450 "EHLO
	adicia.telenet-ops.be") by vger.kernel.org with ESMTP
	id S271533AbTGQVyW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:54:22 -0400
Date: Fri, 18 Jul 2003 00:09:16 +0200
From: Kurt Roeckx <Q@ping.be>
To: linux-kernel@vger.kernel.org
Subject: Sb16 kernel parameters.
Message-ID: <20030717220915.GA5046@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an sound blaster 16, but I'm unable to get it working with
2.6.

During boot I get:
Advanced Linux Sound Architecture Driver Version 0.9.4 (Mon Jun
09 12:01:18 2003 UTC).
ALSA device list:
  #0: Sound Blaster 16 at 0x220, irq 5, dma 1&5

Normally I'm using irq 7, and that has always worked for me, but
for some reason it's selecting it.

I'm still using my kernel parameter line from 2.4:
sb=0x220,7,1,5

And I tried some other things, but I'm unable to get it to work.


How am I supposed to get the IRQ of the SB16 that's compiled in
the kernel?


Kurt

