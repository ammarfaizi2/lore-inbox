Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVGVXLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVGVXLc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 19:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVGVXLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 19:11:32 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:18955 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261438AbVGVXLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 19:11:31 -0400
Date: Sat, 23 Jul 2005 01:11:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Martin MOKREJ <mmokrejs@ribosome.natur.cuni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Giving developers clue how many testers verified certain kernel version
Message-ID: <20050722231126.GB3160@stusta.de>
References: <42E04D11.20005@ribosome.natur.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E04D11.20005@ribosome.natur.cuni.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 03:34:09AM +0200, Martin MOKREJ? wrote:

> Hi,

Hi Martin,

>  I think the discussion going on here in another thread about lack
> of positive information on how many testers successfully tested certain
> kernel version can be easily solved with real solution.
> 
>  How about opening separate "project" in bugzilla.kernel.org named
> kernel-testers or whatever, where whenever cvs/svn/bk gatekeepers
> would release some kernel patch, would open an empty "bugreport"
> for that version, say for 2.6.13-rc3-git4.
> 
>  Anybody willing to join the crew who cared to download the patch
> and tested the kernel would post just a single comment/follow-up
> to _that_ "bugreport" with either "positive" rating or URL
> of his own bugreport with some new bug. When the bug get's closed
> it would be immediately obvious in the 2.6.13-rc3-git4 bug ticket
> as that bug will be striked-through as closed.
> 
>  Then, we could easily just browse through and see that 2.6.13-rc2
> was tested by 33 fellows while 3 of them found a problem and 2 such
> problems were closed since then.
>...

most likely, only a small minory of the people downloading a patch would 
register at such a "project".

The important part of the work, the bug reports, can already today go to 
lnux-kernel and/or the Bugzilla.

You'd spend efforts for such a "project" that would only produce some 
numbers of questionable value.

> Martin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

