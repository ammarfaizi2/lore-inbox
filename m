Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291436AbSBHGOu>; Fri, 8 Feb 2002 01:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291437AbSBHGOk>; Fri, 8 Feb 2002 01:14:40 -0500
Received: from altus.drgw.net ([209.234.73.40]:1029 "EHLO altus.drgw.net")
	by vger.kernel.org with ESMTP id <S291432AbSBHGO0>;
	Fri, 8 Feb 2002 01:14:26 -0500
Date: Fri, 8 Feb 2002 00:14:21 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: Larry McVoy <lm@work.bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020208001421.P17426@altus.drgw.net>
In-Reply-To: <20020207080714.GA10860@come.alcove-fr> <Pine.LNX.4.33.0202070833400.2269-100000@athlon.transmeta.com> <20020207092640.P27932@work.bitmover.com> <20020207232858.M17426@altus.drgw.net> <20020207220619.A18469@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020207220619.A18469@work.bitmover.com>; from lm@bitmover.com on Thu, Feb 07, 2002 at 10:06:19PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 10:06:19PM -0800, Larry McVoy wrote:
> > Ideally, this should ask what changesets you want to send, and what 
> > public tree to look at to see *what* makes sense to send.
> 
> In BK 2.1.4 we added a 
> 
> 	bk send -u<url> email
> 
> which does the sync with the URL and sends only what you have that the
> URL doesn't have.  But you have to be running 2.1.4 on both ends.

Perfect. 

Does 2.1.4 have a "is the user on crack and trying to send the whole
tree" check?

-- 
Troy Benjegerdes | master of mispeeling | 'da hozer' |  hozer@drgw.net
-----"If this message isn't misspelled, I didn't write it" -- Me -----
"Why do musicians compose symphonies and poets write poems? They do it
because life wouldn't have any meaning for them if they didn't. That's 
why I draw cartoons. It's my life." -- Charles Schulz
