Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263135AbSJJAUl>; Wed, 9 Oct 2002 20:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbSJJAUl>; Wed, 9 Oct 2002 20:20:41 -0400
Received: from relay1.pair.com ([209.68.1.20]:27917 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S263135AbSJJAUk>;
	Wed, 9 Oct 2002 20:20:40 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3DA4CBC2.DA1A4A68@kegel.com>
Date: Wed, 09 Oct 2002 17:37:22 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: BK is *evil* corporate software [was Re: New BK License Problem?]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> wrote:
> if you have 3-5 developers there is no reason to not use CVS,
> it works well enough.  ...
> OK, now let's look at it as you grow.  Most of our customers are in the 
> 25-100 developer range.  They move very quickly and have lots of parallelism
> in the code.  So things like work flow and merging are critical, if that
> doesn't work, the whole team slows down.  Let's say we have a 60 seat sale.
> That's $90K/year for BK.  Let's say the engineers cost $100K/each (it
> may be lower where you are but it's more like $180-220 here when you add
> in building/mgmt/all the other overhead).  So that's $6M/year in engineers.
> The BK cost is 1.5% of that.  You say that your guys are $50K/year?  OK,
> so we're at 3% of that.  The point is that if BK makes your team 3% more
> productive, it costs zero.
> 
> And none of that includes the hardware costs, which are dramatically
> cheaper for BK, it works on a laptop.  Clearcase doesn't.

Larry is spot on.  I evaluated Clearcase, Bitkeeper, and Perforce
recently
for an 80 developer shop currently suffering with SourceSafe.
Clearcase was ridiculously expensive and complex; I would never use it.  
Bitkeeper appeared to have *exactly* the features we wanted,
and the price was not out of our range.  We eventually settled on trying
Perforce for a while because we know it could do most of what we needed,
but it was a really tough call.  Larry took the time to make sure we
understood the issues, and I have a lot of respect for him.

Anyone who says Larry is evil is smoking crack.  He's good people.
- Dan
