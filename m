Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287500AbSAURTE>; Mon, 21 Jan 2002 12:19:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287552AbSAURSz>; Mon, 21 Jan 2002 12:18:55 -0500
Received: from ns.suse.de ([213.95.15.193]:15877 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287500AbSAURSu>;
	Mon, 21 Jan 2002 12:18:50 -0500
Date: Mon, 21 Jan 2002 18:18:47 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Sven <luther@dpt-info.u-strasbg.fr>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH] fbdev fbgen cleanup
In-Reply-To: <Pine.LNX.4.10.10201210849030.20645-100000@www.transvirtual.com>
Message-ID: <Pine.LNX.4.33.0201211815210.5384-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, James Simmons wrote:

> > > The best tree to work with is the Dave Jones tree for 2.5.X. DJ tree
> > > provides a better testing ground. Eventually when stuff goes from DJ to
> > > Linus tree ruby and 2.5.X will look alot more alike :-)
> > Mmm, any timeline for the DJ->linus move ?
> At the moment no. I guess when Linus will take patches :-)

I'm pushing Linus some of the small bits right now (though no
feedback, so I'm backing off simultaneously)
I'm staying clear of the fbdev/console code for two reasons.

1. I'd rather James/Vojtech did this so that a, they get it right
   and b, it gives me more time to push Linus other bits.
2. Several Framebuffer driver authors want to push their relevant
   bits to Linus themselves. which is fine by me. (See 1b)

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

