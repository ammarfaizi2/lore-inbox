Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265039AbSKUWZV>; Thu, 21 Nov 2002 17:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265037AbSKUWZS>; Thu, 21 Nov 2002 17:25:18 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:11415 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265034AbSKUWZI>;
	Thu, 21 Nov 2002 17:25:08 -0500
Date: Thu, 21 Nov 2002 22:30:31 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.48-dj1 (sort of)
Message-ID: <20021121223031.GB25741@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's just under 700KB worth of bits left in 2.5-dj,
mostly driver changes.

I just spent some time splitting these up into per-change patches
and put the result at ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/2.5.48/
Some chunks aren't quite per-change, and need further
splitting up before they can go to maintainers/Linus.

There's also still quite a few questionable bits in there that
will need throwing out, so I'd appreciate anyone with a
spare couple of minutes to take a quick looksee and let me
know "patch xxx is bogus, drop it".

The more obviously correct stuff will be going to Linus asap.
Note that I'm not taking new stuff, throw that to Alan.
I'm concentrating on getting rid of as much of this as possible
be that by dropping it, or pushing it.

The split-up files with filenames beginning with "voodoo-"
are patches to bits which I've no real clue about, I've lost
the original mails those bits came from, so I'm none the
wiser how useful they are any more.

For good measure, I've cat'd the lot together to make
a 2.5.48-dj1.  This is just for reference and will only
apply to Linus' current bitkeeper tree.
(Ie, don't mail me with "it doesn't apply to 2.5.48", I know)
The real interesting bits are in the split-dj1/ directory.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
