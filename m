Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315722AbSEILie>; Thu, 9 May 2002 07:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315725AbSEILid>; Thu, 9 May 2002 07:38:33 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:40200 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S315722AbSEILib>; Thu, 9 May 2002 07:38:31 -0400
Date: Thu, 9 May 2002 21:40:09 +1000
From: john slee <indigoid@higherplane.net>
To: "David S. Miller" <davem@redhat.com>
Cc: dank@kegel.com, khttpd-users@alt.org, linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
Message-ID: <20020509114009.GD3855@higherplane.net>
In-Reply-To: <3CD5CE35.3EF2B62E@kegel.com> <20020505.191422.11638807.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2002 at 07:14:22PM -0700, David S. Miller wrote:
>    From: Dan Kegel <dank@kegel.com>
>    Date: Sun, 05 May 2002 17:28:37 -0700
>    
>    If I didn't need it for a demo this week (don't ask), I
>    wouldn't be messing with khttpd; I'd be switching to Tux.
>    
>    Seems like it's time to either fix khttpd or pull it from the kernel.
>    
> We are going to pull it from the kernel.
> 
> The only argument is whether to replace it with TUX or not.
> There is a lot of compelling evidence that suggests that
> reasonably close performance can be obtained in userspace.
> 
> I guess the decision on TUX is not a prerequisite for pulling
> khttpd though.

people who want tux are probably going to want some other related bits
and pieces.  this is a distribution issue.  remove khttpd (even if it is
suddenly maintained again) and let it and tux both be external entities.

tux is more an application than an interface or mechanism.  applications
historically haven't been distributed as part of the main kernel tree.

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
