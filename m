Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135363AbRDZMZT>; Thu, 26 Apr 2001 08:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135364AbRDZMZA>; Thu, 26 Apr 2001 08:25:00 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:34705 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S135363AbRDZMYv>;
	Thu, 26 Apr 2001 08:24:51 -0400
Date: Thu, 26 Apr 2001 14:24:37 +0200
From: David Weinehall <tao@acc.umu.se>
To: imel96@trustix.co.id
Cc: John Cavan <johnc@damncats.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
Message-ID: <20010426142437.C3027@khan.acc.umu.se>
In-Reply-To: <3AE741EA.561BE01F@damncats.org> <Pine.LNX.4.33.0104261836130.1677-100000@tessy.trustix.co.id>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0104261836130.1677-100000@tessy.trustix.co.id>; from imel96@trustix.co.id on Thu, Apr 26, 2001 at 07:11:24PM +0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 07:11:24PM +0700, imel96@trustix.co.id wrote:
> 
> On Wed, 25 Apr 2001, John Cavan wrote:
> 
> > Several distributions (Red Hat and Mandrake certainly) offer auto-login
> > tools. In conjunction with those tools, take the approach that Apple
> > used with OS X and setup "sudo" for administrative tasks on the machine.
> > This allows the end user to generally administer the machine without all
> > the need to hack the kernel, modify login, operate as root, etc. You can
> > even restrict their actions with it and log what they do.
> >
> > In the end though, I really don't see the big deal with having a root
> > user for general home use. Even traditionally stand-alone operating
> >
> 
> you're right, we could do it in more than one way. like copying
> with mcopy without mounting a fat disk. the question is where to put it.
> why we do it is an important thing.
> taking place as a clueless user, i think i should be able to do anything.
> i'd be happy to accept proof that multi-user is a solution for
> clueless user, not because it's proven on servers. but because it is
> a solution by definition.

Look, all of this is VERY simple. There is only one single person you
have to convince to get this into the kernel. And you DO have to convince
him, because no matter how many others you try to force this upon, nothing
gets into the kernel without the consent of the almighty penguin.

So do us all a favour, send this patch to Linus. I'd give you a 1/10 chance
of getting a reply at all, and a 1/100000000000000 that the answer won't
be along the terms of "No way in hell, never!" (possibly worded a bit
different.) If you don't get any response in say a week or so, just give
up.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
