Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313392AbSDUPRU>; Sun, 21 Apr 2002 11:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313403AbSDUPRT>; Sun, 21 Apr 2002 11:17:19 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:37534 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313392AbSDUPRS>;
	Sun, 21 Apr 2002 11:17:18 -0400
Date: Sun, 21 Apr 2002 11:17:17 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Jochen Friedrich <jochen@scram.de>
Cc: Larry McVoy <lm@bitmover.com>, Roman Zippel <zippel@linux-m68k.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421111717.A2301@havoc.gtf.org>
In-Reply-To: <20020420171714.A31656@work.bitmover.com> <Pine.LNX.4.44.0204211121010.18496-100000@alpha.bocc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 11:22:10AM +0200, Jochen Friedrich wrote:
> Hi Larry,
> 
> > Huh?  BK requires no more net access than you require when submitting
> > a regular patch.  You need to be connected to move the bits.
> 
> Wrong. Many corporate firewalls allow email and http (both via proxy) and 
> reject any other traffic. CVS and BK are both unusable in this 
> environment.

Wrong -- both BK and CVS can be proxied.

CVS takes a bit more effort.  'bk helptool url' gives you proxy info for BK.

	Jeff



