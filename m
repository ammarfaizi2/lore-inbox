Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284752AbRLEVZq>; Wed, 5 Dec 2001 16:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284745AbRLEVZh>; Wed, 5 Dec 2001 16:25:37 -0500
Received: from bitmover.com ([192.132.92.2]:52610 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S284744AbRLEVZe>;
	Wed, 5 Dec 2001 16:25:34 -0500
Date: Wed, 5 Dec 2001 13:25:32 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Message-ID: <20011205132532.Y11801@work.bitmover.com>
Mail-Followup-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	Larry McVoy <lm@bitmover.com>, Rik van Riel <riel@conectiva.com.br>,
	Lars Brinkhoff <lars.spam@nocrew.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011205130547.X11801@work.bitmover.com> <2535737837.1007558085@mbligh.des.sequent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <2535737837.1007558085@mbligh.des.sequent.com>; from Martin.Bligh@us.ibm.com on Wed, Dec 05, 2001 at 01:14:45PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2001 at 01:14:45PM -0800, Martin J. Bligh wrote:
> > Seriously, I went through this at SGI, that's exactly what they did, and it
> > was a huge mistake and it never worked.
> 
> You seem to make this odd logical deduction quite a bit - you (or company X)
> has tried concept X before. Their implementation didn't work. Therefore the
> concept is bad. It's not particularly convincing as an argument style to others.

I think you'll find that a common theme amongst people with experience.  
I also will point out that what you are saying is exactly what I and 
every other young hotshot said in our twenties.  It's funny how when 
you let 15 years go by the people that you argued with in the past 
suddenly become right.  It's certainly been a pattern in my life that
when I argue with people who are older and more experienced, 9 times out
of 10, I let some years pass and I find myself arguing their position.
It's also interesting to note that these days virtually 100% of that
sort of discussion is with someone younger.  Hardly conclusive, but
you can see a pattern emerging.

You are right in suggesting that there are other answers, but what you
miss is that they are not very likely to work.  The field of operating
systems is well explored, in fact, I challenge you to name 5 things that
Linux has done which have not been done before.  The point being that
the graph of choices is well pruned.  Feel free to ignore the pruning,
there is always a chance that the old farts have pruned off a fruitful
branch, or times have changed soas to invalidate the reasoning; just be
warned that the chances are low.

What I'm trying to do is avoid having Linux go down some paths that I 
have seen other people go down because those paths have *all* resulted
in a kernel that none of us would want.  You can assert all you like 
that you'll not make those mistakes, but having seen those same assertions
a half a dozen times before from a half a dozen different OS efforts, all
of which were staffed with talented and careful people, you'll forgive
my skepticism.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
