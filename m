Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313677AbSDURyl>; Sun, 21 Apr 2002 13:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313678AbSDURyk>; Sun, 21 Apr 2002 13:54:40 -0400
Received: from bitmover.com ([192.132.92.2]:26267 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S313677AbSDURyi>;
	Sun, 21 Apr 2002 13:54:38 -0400
Date: Sun, 21 Apr 2002 10:54:37 -0700
From: Larry McVoy <lm@bitmover.com>
To: Jeff Garzik <garzik@havoc.gtf.org>
Cc: CaT <cat@zip.com.au>, Daniel Phillips <phillips@bonn-fries.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
Subject: Re: Suggestion re: [PATCH] Remove Bitkeeper documentation from Linux tree
Message-ID: <20020421105437.L10525@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jeff Garzik <garzik@havoc.gtf.org>, CaT <cat@zip.com.au>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Linus Torvalds <torvalds@transmeta.com>,
	Anton Altaparmakov <aia21@cantab.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204201039130.19512-100000@home.transmeta.com> <E16yfW9-0000aZ-00@starship> <20020421171629.GK4640@zip.com.au> <20020421104046.J10525@work.bitmover.com> <20020421134851.B7828@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 01:48:51PM -0400, Jeff Garzik wrote:
> Can you get the bkbits.net interface to spit out text/plain GNU-style
> patches?

Not on bkbits.net.  It eats up too much bandwidth.  If someone else wants
to host a bkbits.net mirror and they want to allow that, then I'll add
the code.

It actually doesn't do you that much good unless we add an interface to
get the pre-patch style diffs.  Otherwise you are getting a cset at a 
time and that's a bit too fine grained, at least I think it is.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
