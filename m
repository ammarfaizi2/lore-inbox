Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVCNRDf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVCNRDf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 12:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbVCNRDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 12:03:34 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:33481 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261621AbVCNRD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 12:03:27 -0500
Date: Mon, 14 Mar 2005 18:03:10 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: David Lang <david.lang@digitalinsight.com>, Dave Jones <davej@redhat.com>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Message-ID: <20050314170310.GB5461@elf.ucw.cz>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503140855.18446.jbarnes@engr.sgi.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > "non-experimental driver may only print out one line per actual
> > device?"
> >
> > (and perhaps: dmesg output for boot going okay should fit on one screen).
> >
> > Or perhaps we should have warnings-like regression testing.
> >
> > "New kernel 2.8.17 came: 3 errors, 135 warnings, 1890 lines of dmesg
> > junk".
> >         Pavel
> 
> We already have the 'quiet' option, but even so, I think the kernel is *way* 
> too verbose.  Someone needs to make a personal crusade out of removing 
> unneeded and unjustified printks from the kernel before it really gets better 
> though...

I know about "quiet". You can 2> /dev/null on warnings, too ;-), and
quiet is quite equivalent... And I'm about fed enough to start that
personal crusade. OTOH "POSIX conformance testing by UniFix" is gone
now ;-).
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
