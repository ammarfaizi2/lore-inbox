Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291849AbSBAQjj>; Fri, 1 Feb 2002 11:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291837AbSBAQjV>; Fri, 1 Feb 2002 11:39:21 -0500
Received: from bitmover.com ([192.132.92.2]:17601 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291845AbSBAQi4>;
	Fri, 1 Feb 2002 11:38:56 -0500
Date: Fri, 1 Feb 2002 08:38:55 -0800
From: Larry McVoy <lm@bitmover.com>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: Keith Owens <kaos@ocs.com.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020201083855.C8664@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
	Keith Owens <kaos@ocs.com.au>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <lm@bitmover.com> <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200202011111.g11BBVf0009257@tigger.cs.uni-dortmund.de>; from brand@jupiter.cs.uni-dortmund.de on Fri, Feb 01, 2002 at 12:11:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 12:11:30PM +0100, Horst von Brand wrote:
> > This is certainly possible to do.  However, unless you are willing to fund
> > this development, we aren't going to do it.  We will pick up the costs of
> > making changes that you want if and only if we have commercial customers
> > who want (or are likely to want) the same thing.  Nothing personal, it's
> > a business and we make tradeoffs like that all the time.
> 
> I wonder how your commercial customers develop code then. Either each
> programmer futzes around in his/her own tree, and then creates a patch (or
> some such) for everybody to see (then I don't see the point of source
> control as a help to the individual developer), or everybody sees all the
> backtracking going on everywhere (in which case the repository is a mostly
> useless mess AFAICS).

You are presupposing that all the developers are checking in many bad changes
and only one good change.  And that all the bad changes are obscuring the
good ones.  That a correct statement of your beliefs?

If so, what you are describing is called "hacking" in the negative
sense of the word, and what my customers do is called "programming".
It's quite rare to see the sort of mess that you described, it happens,
but it is rare.  I don'tknow how else to explain it, but it is not the
norm in the professional world to try a zillion different approaches
and revision control each and every one.

The norm is:
	clone a repository
	edit the files
	modify/compile/debug until it works
	check in
	push the patch up the shared repository
I'm really at a loss as to why that shouldn't be the norm here as well.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
