Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315921AbSFCX6u>; Mon, 3 Jun 2002 19:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315919AbSFCX6t>; Mon, 3 Jun 2002 19:58:49 -0400
Received: from revdns.flarg.info ([213.152.47.19]:43148 "EHLO noodles.internal")
	by vger.kernel.org with ESMTP id <S315921AbSFCX6r>;
	Mon, 3 Jun 2002 19:58:47 -0400
Date: Tue, 4 Jun 2002 01:00:29 +0100
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux 2.5.20-dj1
Message-ID: <20020604000029.GA13899@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a resync against 2.5.20, I'll start digging through
the rather large patch queue next time, after pushing another
load of this to Linus..

As usual,..

Patch against 2.5.20 vanilla is available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/davej/patches/2.5/

Merged patch archive: http://www.codemonkey.org.uk/patches/merged/

Check http://www.codemonkey.org.uk/Linux-2.5.html before reporting
known bugs that are also in mainline.

 -- Davej.

2.5.20-dj1
o   Drop some more bogus bits found whilst patch-splitting.
o   emu10k1 compile fix.				(Alistair Strachan)
o   Framebuffer updates.				(James Simmons)
o   Drop some bogus kbuild bits.			(Kai Germaschewski)
o   Unobsolete egcs kernel builds.			(Me)
    | The known bug can be worked around, and this is compiler 
    | of choice on sparc and other archs.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
