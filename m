Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750822AbWBIXQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbWBIXQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:16:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750825AbWBIXQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:16:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:59154 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1750822AbWBIXQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:16:55 -0500
Date: Fri, 10 Feb 2006 00:16:50 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Paul Jackson <pj@sgi.com>
Cc: Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: git for dummies, anyone? (was: Re: How in tarnation do I git v2.6.16-rc2?  hg died and I still don't git git)
Message-ID: <20060209231650.GF11380@w.ods.org>
References: <20060208070301.1162e8c3.pj@sgi.com> <yq0vevollx4.fsf@jaguar.mkp.net> <20060209065011.45ba1b88.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060209065011.45ba1b88.pj@sgi.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2006 at 06:50:11AM -0800, Paul Jackson wrote:
> Thanks for the git guide links.
> 
> I spent some time reading them yesterday (not the Ubuntu
> one you pointed to, but others.)
> 
> After repeated efforts, beginning with the birth of git,
> it is clear that I have some sort of congenital mental
> defect that makes me unsuited for using git.

Hey Paul, welcome to the club, you're not alone :-)

Every time I use it, I spend more time fixing my mistakes
than doing useful work. I'm at the point of doing a "cp -a"
before starting anything because it too often gets very bad
after a few operations. Even git-reset often fails for me.

I think that the biggest problem is that it's not intuitive,
so if you don't use it often, it's hard to remember all the
tricks. Anyway, there are so many people happy with it that
I think that *we both* have mental defects. BTW, have you
tried cogito ? Not much more intuitive, but at least, it
reduces the number of commands for some basic operations,
and this sometimes leads to less mistakes.

> Hopefully someone benefited from your links.
> 
> -- 
>                   I won't rest till it's the best ...
>                   Programmer, Linux Scalability
>                   Paul Jackson <pj@sgi.com> 1.925.600.0401

Cheers,
Willy

