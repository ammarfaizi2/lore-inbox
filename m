Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268086AbTBOAZu>; Fri, 14 Feb 2003 19:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268168AbTBOAZu>; Fri, 14 Feb 2003 19:25:50 -0500
Received: from tux.rsn.bth.se ([194.47.143.135]:27777 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id <S268086AbTBOAZt>;
	Fri, 14 Feb 2003 19:25:49 -0500
Subject: Small keyboard problem in 2.5.58, doesn't happen in 2.4
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045269335.692.42.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 15 Feb 2003 01:35:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vojtech.

I seem to have a small problem with the keyboard in 2.5.58
Sometimes when I press a key it repeats that same character 4-5 times
_very very_ rapidly, a lot faster than the repeatrate.

It seems to happen maybe once a week so it's not a major problem, it's
just that it has never happened in 2.4

hardware:
intel 440bx chipset (tyan s1830s motherboard)
old noname AT keyboard.

Andrew Morton says it happens to him all the time, so I'm not alone with
this problem.

Do you have any ideas or things to test? (might take quite some time to
see the effects of any changes...)

-- 
/Martin

Never argue with an idiot. They drag you down to their level, then beat you with experience.
