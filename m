Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292873AbSCGE2T>; Wed, 6 Mar 2002 23:28:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292877AbSCGE2J>; Wed, 6 Mar 2002 23:28:09 -0500
Received: from altus.drgw.net ([209.234.73.40]:22282 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S292873AbSCGE2D>;
	Wed, 6 Mar 2002 23:28:03 -0500
Date: Wed, 6 Mar 2002 22:27:02 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Larry McVoy <lm@bitmover.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
        Andi Kleen <ak@suse.de>, Andrew Morton <akpm@zip.com.au>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Petition Against Official Endorsement of BitKeeper by Linux Maintainers
Message-ID: <20020306222702.P1682@altus.drgw.net>
In-Reply-To: <Pine.GSO.4.21.0203061424190.14695-100000@vervain.sonytel.be> <Pine.LNX.4.21.0203061525160.6899-100000@serv> <20020306090011.G15303@work.bitmover.com> <3C865BEA.78C7F827@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C865BEA.78C7F827@linux-m68k.org>; from zippel@linux-m68k.org on Wed, Mar 06, 2002 at 07:11:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2002 at 07:11:54PM +0100, Roman Zippel wrote:
> Hi,
> 
> Larry McVoy wrote:
> 
> > Is the problem that you can't figure out how to extract all the patches
> > from BK so you can put them up for FTP?  Here, I'll do it for you:
> 
> Do it for the ppc guys, not me.
> 
> bye, Roman

You really don't want every changeset as a patch :-/

Please talk to Jeramy, or someone else running penguinppc.org. At one 
point we had patches being generated for every changesets. It got to be 
too much of a headache.

Write some scripts to generage a patch every week or so, and we'll put it 
up.

What I'd really like is some kind of one-way bk->$OTHER_SCM mirror setup 
simply so people can pull stuff out without BK.

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
