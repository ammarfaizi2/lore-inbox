Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316516AbSEOW7h>; Wed, 15 May 2002 18:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316517AbSEOW7g>; Wed, 15 May 2002 18:59:36 -0400
Received: from bitmover.com ([192.132.92.2]:38113 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316516AbSEOW7f>;
	Wed, 15 May 2002 18:59:35 -0400
Date: Wed, 15 May 2002 15:59:35 -0700
From: Larry McVoy <lm@bitmover.com>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Larry McVoy <lm@bitmover.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Changelogs on kernel.org
Message-ID: <20020515155935.K13795@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	Larry McVoy <lm@bitmover.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020515153016.H13795@work.bitmover.com> <Pine.LNX.4.44.0205151752400.1802-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2002 at 05:56:18PM -0500, Kai Germaschewski wrote:
> On Wed, 15 May 2002, Larry McVoy wrote:
> 
> > bk park		# saves work as a patch
> > bk pull
> > bk unpark	# restores the patch
> > 
> > park/unpark are undocumented because they puke when there are patch rejects.
> > If we document them, then we have to explain to people what to do when there
> > are patch rejects, and if you need that explanation, we probably can't help
> > you.  You guys all grok patch rejects, so try park/unpark.
> 
> So what's the undocumented option to turn off consistency checks? ;-)
> 
> I understand that they exist for a reason, etc, but I'd really like to 
> have the option to switch them off (and suffer the consequences all by 
> myself)

We've got a release in the works which makes it so you can run them only
once in a 24 hour period.  I'm fixing up the stuff that caused the problems
on multiple patch imports and then we'll do a release.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
