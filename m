Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133012AbREHRge>; Tue, 8 May 2001 13:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133018AbREHRgZ>; Tue, 8 May 2001 13:36:25 -0400
Received: from [194.213.32.137] ([194.213.32.137]:260 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S133012AbREHRgU>;
	Tue, 8 May 2001 13:36:20 -0400
Message-ID: <20010508134516.A119@bug.ucw.cz>
Date: Tue, 8 May 2001 13:45:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: PCMCIA ide flash card does not work
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

My ide flash card used to work in 2.4.0, but does not work in
2.4.4. Everything compiled in (no modules)

May  8 13:43:44 bug cardmgr[58]: initializing socket 0
May  8 13:43:44 bug cardmgr[58]: socket 0: ATA/IDE Fixed Disk
May  8 13:43:44 bug cardmgr[58]: module //pcmcia/ide_cs.o not
available
May  8 13:43:45 bug cardmgr[58]: get dev info on socket 0 failed:
Resource temporarily unavailable

PCMCIA ne2000 card works at the same time.

Any hints?

								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
