Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291689AbSBAKzn>; Fri, 1 Feb 2002 05:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291688AbSBAKze>; Fri, 1 Feb 2002 05:55:34 -0500
Received: from smtp.cogeco.net ([216.221.81.25]:36074 "EHLO fep8.cogeco.net")
	by vger.kernel.org with ESMTP id <S291687AbSBAKzZ>;
	Fri, 1 Feb 2002 05:55:25 -0500
Subject: Re: A modest proposal -- We need a patch penguin
From: "Nix N. Nix" <nix@go-nix.ca>
To: Larry McVoy <lm@bitmover.com>
Cc: Troy Benjegerdes <hozer@drgw.net>, Rob Landley <landley@trommello.org>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Eli Carter <eli.carter@inet.com>,
        Georg Nikodym <georgn@somanetworks.com>, Ingo Molnar <mingo@elte.hu>,
        Rik van Riel <riel@conectiva.com.br>,
        Tom Rini <trini@kernel.crashing.org>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020131091914.L1519@work.bitmover.com>
In-Reply-To: <20020130195154.R22323@work.bitmover.com>
	<20020131002355.X14339@altus.drgw.net>
	<20020130223711.L18381@work.bitmover.com>
	<20020131074924.QZMB10685.femail14.sdc1.sfba.home.com@there>
	<20020131111337.Y14339@altus.drgw.net> 
	<20020131091914.L1519@work.bitmover.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1.99+cvs.2002.01.14.17.03 (Preview Release)
Date: 01 Feb 2002 05:55:20 -0500
Message-Id: <1012560924.1572.7.camel@tux>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-31 at 12:19, Larry McVoy wrote: 
> On Thu, Jan 31, 2002 at 11:13:37AM -0600, Troy Benjegerdes wrote:
> > Can you detect the 'collapsed vs full version' thing, and force it to be 
> > a merge conflict? That, and working LOD support would probably get most 
> > of what I want (until I try the new version and find more stuff I want 
> > :P)
> 
> Are you sure you want that?  If so, that would work today, it's about a
> 20 line script.  You clone the tree, collapse all the stuff into a new
> changeset, and pull.  It will all automerge.  But now you have the detailed
> stuff and the non-detailed stuff in the same tree, which I doubt is what
> you want.  I thought the point was to remove information, not double it.

Sounds to me like you should have the /option/ to double your info,
which does not mean that the whole world should start seeing your stuff
double. You must "fool" the other trees into believing that you are the
second Mozart (you get everything right the first time around) and only
to yourself will you admit that it took 15 different tries and you
dead-ended yourself 15 different ways.  Under these conditions you would
have all your blunders documented, but only for yourself.



Regards.

> -- 
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


