Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289982AbSAPPiE>; Wed, 16 Jan 2002 10:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290395AbSAPPhy>; Wed, 16 Jan 2002 10:37:54 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:23306 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289982AbSAPPhs>; Wed, 16 Jan 2002 10:37:48 -0500
Date: Wed, 16 Jan 2002 10:37:36 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: KDE hang with 2.4.18-pre3-ac2
Message-ID: <Pine.LNX.3.96.1020116103205.28369E-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got an interesting symptom on the first machine I tried using the new
-ac2 kernel. The KDE bar wouldn't launch any applications. The rest of the
system was running just fine, applications running, `sessions' starting
connections to various machines, mail going along, but KDE just didn't
start apps, with no errors.

After reboot all was fine, restarting KDE didn't change anything.

I mention this only as something people might shrug off otherwise, but
this KDE hasn't done that, and it's an old one from Slack7.0. Can't
replicate otherwise, this is not a bug report proper or not, just
something to notice. If restarting KDE fixed it I'd say it was a KDE bug,
but it didn't.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

