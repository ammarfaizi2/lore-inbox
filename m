Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132443AbRACRE6>; Wed, 3 Jan 2001 12:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132507AbRACREi>; Wed, 3 Jan 2001 12:04:38 -0500
Received: from [4.22.152.149] ([4.22.152.149]:46124 "HELO
	spanky.comspacecorp.com") by vger.kernel.org with SMTP
	id <S132458AbRACREf>; Wed, 3 Jan 2001 12:04:35 -0500
Date: Wed, 3 Jan 2001 10:28:44 -0600
Message-Id: <200101031628.f03GSiE19644@spanky.comspacecorp.com>
From: Bill Priest <bpriest@comspacecorp.com>
To: linux-kernel@vger.kernel.org
Subject: Followup:  2.2.1x unknown kernel messages in syslog; 2.4.0 doesn't init sound card
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,
		I installed 2.4.0 prerelease and the problem I was seeing
w/ kernel: "seemingly random characters" went away.  So it would
appear that this is a 2.2 problem only.

	    One thing I noticed in going to 2.4 was that my sound card
initialization/parameters were/are not available to be set in either
xconfig or menuconfig.  I read thru Documentation/Changes and didn't
see anything relevant.  I have a no-name half MSS/half SB sound card;
but it did work flawlessly w/ 2.2.  The boot messages indicate that
the parameters must be set (I don't remember the actual message; I
can follow up if necessary).  I'm sure there is something I am missing;
I just can't see it.

original message titled 2.2.1x unknown kernel messages in syslog
reference:http://uwsg.ucs.indiana.edu/hypermail/linux/kernel/0012.3/0463.html

FYI,

Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
