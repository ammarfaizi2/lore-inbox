Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313698AbSDUSAD>; Sun, 21 Apr 2002 14:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313705AbSDUSAC>; Sun, 21 Apr 2002 14:00:02 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:42148 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313698AbSDUR75>;
	Sun, 21 Apr 2002 13:59:57 -0400
Date: Sun, 21 Apr 2002 13:59:55 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Larry McVoy <lm@work.bitmover.com>, CaT <cat@zip.com.au>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421135955.B8142@havoc.gtf.org>
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship> <20020421171629.GK4640@zip.com.au> <20020421104046.J10525@work.bitmover.com> <20020421134851.B7828@havoc.gtf.org> <20020421105437.L10525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 10:54:37AM -0700, Larry McVoy wrote:
> On Sun, Apr 21, 2002 at 01:48:51PM -0400, Jeff Garzik wrote:
> > Can you get the bkbits.net interface to spit out text/plain GNU-style
> > patches?
> 
> Not on bkbits.net.  It eats up too much bandwidth.

Your bkbits.net web interface _already_ spits out HTML-ized patches.
It _reduces_ bandwidth to spit them out as text/plain.

But I think you are misunderstanding a bit, see below.


> Otherwise you are getting a cset at a 
> time and that's a bit too fine grained, at least I think it is.

That's what the web interface does now, and that's what I'm talking about.

I'm talking about making the "all diffs" link in the web interface spit
out text/plain.

	Jeff


