Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292354AbSBYW2g>; Mon, 25 Feb 2002 17:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292350AbSBYW0w>; Mon, 25 Feb 2002 17:26:52 -0500
Received: from air-2.osdl.org ([65.201.151.6]:13330 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292334AbSBYW0Y>;
	Mon, 25 Feb 2002 17:26:24 -0500
Date: Mon, 25 Feb 2002 14:20:24 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Christer Weinigel <wingel@acolyte.hack.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
In-Reply-To: <20020222204823.235A6F5B@acolyte.hack.org>
Message-ID: <Pine.LNX.4.33L2.0202251413100.11464-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Christer,

Thanks for doing this "watchdog-api.txt".
Will you add it to linux/Documentation/ also?
Even with the FIXME's, it's valuable to have this information.

Typo:  in the 3rd paragraph following "Introduction:",
change "implent" to "implement".

Questions:  At various places it refers to
/proc/watchdog and/or /dev/watchdog special device files.
Is /proc/watchdog actually used, or just /dev/watchdog?
And is /proc/watchdog considered a special device file?

-- 
~Randy

