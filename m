Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267802AbTBKRCN>; Tue, 11 Feb 2003 12:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267866AbTBKRCM>; Tue, 11 Feb 2003 12:02:12 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5901 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267802AbTBKRBv>; Tue, 11 Feb 2003 12:01:51 -0500
Date: Tue, 11 Feb 2003 09:08:00 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 339] New: compile failure in drivers/char/watchdog/sc1200wdt.c
In-Reply-To: <20030211162307.GA20986@codemonkey.org.uk>
Message-ID: <Pine.LNX.4.44.0302110907230.13587-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Feb 2003, Dave Jones wrote:
> repository at bk://linux-dj.bkbits.net/watchdog 
> Linus, if you can pull that, that should be the only cset currently
> currently pending there.

There currently currently isn't anything there that I can see..

	torvalds@home:~/v2.5/linux> bk pull bk://linux-dj.bkbits.net/watchdog 
	Nothing to pull from bk://linux-dj.bkbits.net/watchdog

Or am I just too fast?

		Linus

