Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbTKMKKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 05:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTKMKKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 05:10:30 -0500
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:24987 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S263662AbTKMKK3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 05:10:29 -0500
From: Andrew Walrond <andrew@walrond.org>
To: Larry McVoy <lm@bitmover.com>
Subject: Re: kernel.bkbits.net off the air
Date: Thu, 13 Nov 2003 10:10:26 +0000
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <fa.eto0cvm.1v20528@ifi.uio.no> <200311112021.34631.andrew@walrond.org> <20031111235215.GA22314@work.bitmover.com>
In-Reply-To: <20031111235215.GA22314@work.bitmover.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311131010.27315.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 2. Persuade Larry to release a 'clone/pull-only' version of bk which
> > *anyone* can use to  access open source software
>
> As I've explained in the past, this doesn't make sense.  I'd be far more
> likely to build a sort of CVS like client that could do checkouts and
> updates of read only files.  That's a pretty straightforward thing to
> do, in fact, nobody needs BK source to do that, it could all be done as

I'm a bit confused (not unusual). I think what I'm suggesting is exactly what 
you've just described and doesn't involve releasing any bk source; Release a 
binary only tool which will clone and pull only, (Ie can be used to access 
open source software but not develop it) which is free of the license 
restrictions of the full bk (ie can be used to access open source software by 
anybody, regardless of what they might be working on)

Or am I missing something? How does this hurt the bk business model?

> I could make some comment about this being a good example of one of
> the zillion little problems we've had to solve but if I go there it's
> going to start a flame war.  So I won't.  I will note that none of the
> solutions proposed come close to being acceptable, they all fail on NFS
> and on SMB shares.  And they don't cascade properly as HPA has noted.

Absolutely. Bk is, undeniably, brilliant, and would solve all these problems 
at a stroke, except that the open source community cannot with good 
conscience exclude *anyone* from being able to access the sources.

