Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261601AbUKAIju@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUKAIju (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 1 Nov 2004 03:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbUKAIju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 03:39:50 -0500
Received: from gprs214-33.eurotel.cz ([160.218.214.33]:23424 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261601AbUKAIjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 03:39:44 -0500
Date: Mon, 1 Nov 2004 09:39:22 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Larry McVoy <lm@work.bitmover.com>,
        Ram?n Rey Vicente <ramon.rey@hispalinux.es>,
        Xavier Bestel <xavier.bestel@free.fr>,
        James Bruce <bruce@andrew.cmu.edu>, Linus Torvalds <torvalds@osdl.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        Andrea Arcangeli <andrea@novell.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
Message-ID: <20041101083922.GA1160@elf.ucw.cz>
References: <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org> <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org> <4180B9E9.3070801@andrew.cmu.edu> <20041028135348.GA18099@work.bitmover.com> <1098972379.3109.24.camel@gonzales> <20041028151004.GA3934@work.bitmover.com> <41827B89.4070809@hispalinux.es> <20041029173642.GA5318@work.bitmover.com> <20041031210323.GG5578@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031210323.GG5578@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > In Spain, reverse engineering is allowed for interoperability.
> > 
> > And in lots of other places.  Which has been mentioned in this and other
> > instances of this discussion for the last 5 years.  And the response is
> > that BK already gives you documented ways to interoperate, extensively
> > documented, in fact.  You can get data and/or metadata into and out of
> > BK from the command line.  You could create your own network protocol,
> > client, and server using the documented interfaces that BK has.  You
> > could create your own CVS2BK tool, your own BK2CVS tool, etc., all
> > using documented interfaces.

Okay, statement here seems to be "it is technically possible to write
BK2something using documented interfaces", problem is just that nobody
but Halle Berry is allowed to do the work. So Larry claims that he's
not doing lock-in because you can export that data. Only catch is that
you are not legally permitted to do that with free version, and Larry
is not going to sell commercial version to you if you do something
like this. So we have unique lockin at legal level, instead of
technical one.

If I misunderstood this, Larry please clarify.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
