Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292611AbSBZBXN>; Mon, 25 Feb 2002 20:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292593AbSBZBWx>; Mon, 25 Feb 2002 20:22:53 -0500
Received: from acolyte.thorsen.se ([193.14.93.247]:38662 "HELO
	acolyte.hack.org") by vger.kernel.org with SMTP id <S292605AbSBZBWt>;
	Mon, 25 Feb 2002 20:22:49 -0500
From: Christer Weinigel <wingel@acolyte.hack.org>
To: rddunlap@osdl.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0202251413100.11464-100000@dragon.pdx.osdl.net>
	(rddunlap@osdl.org)
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <Pine.LNX.4.33L2.0202251413100.11464-100000@dragon.pdx.osdl.net>
Message-Id: <20020226012245.95555F5B@acolyte.hack.org>
Date: Tue, 26 Feb 2002 02:22:45 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap <rddunlap@osdl.org> wrote:
> Questions:  At various places it refers to
> /proc/watchdog and/or /dev/watchdog special device files.
> Is /proc/watchdog actually used, or just /dev/watchdog?
> And is /proc/watchdog considered a special device file?

That's just a typo.  It should be /dev/watchdog.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"
