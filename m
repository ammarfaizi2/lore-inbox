Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314815AbSDVVfa>; Mon, 22 Apr 2002 17:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314816AbSDVVf3>; Mon, 22 Apr 2002 17:35:29 -0400
Received: from bitmover.com ([192.132.92.2]:8873 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314815AbSDVVf1>;
	Mon, 22 Apr 2002 17:35:27 -0400
Date: Mon, 22 Apr 2002 14:35:27 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [OFF TOPIC] BK license change
Message-ID: <20020422143527.K18800@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020421095715.A10525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 09:57:15AM -0700, Larry McVoy wrote:
> I'm considering a change to the BKL which says that N days after a
> changeset is made, that changeset (and its ancestory) must be available
> on a public bk server.  In other words, put a hard limit on how long
> you may hide.

OK, people have been replying in private to this raising various objections
and making good points:

    David Mosberger was worried that I was suggesting that not
    providing access to changes to GPLed code immediately (or ever,
    if you don't redistribute) is a GPL violation.  To clarify: people
    can make changes to GPLed software and are only required to make
    those changes available if they redistribute.  That's the rule.
    The point I was trying to make is that I wanted BK to be used for
    free on work which is done out in the open, not behind closed doors.

    Greg KH raised the point that not everyone can have a public
    BK server, their IT department may not allow that.  He said that
    bkbits.net may need beefing up if we force people out into the open
    (it needs beefing up anyway, but point is well taken).

    Itai Nahshon raised several points about encrypted software, illegal
    under the DMCA software, etc.

    Jonathan Corbet raised the point of exposing software that isn't
    done yet, which may have security holes, and/or other problems.

There were others, but this gives you a feel.  In general, I'm getting 
the message that forcing everything out into the open isn't always going
to be a good thing.

Yet I still have the problem of people abusing the system (not to mention
the "spirit" of free software).  What I'd like is a way to qualify that
"abuse" and put that in the license, and what I'm hearing is that any
blanket statement may be a net negative for someone who should not be
adversely affected.

So that leaves a more selective approach.  We can add a clause that says
we reserve the right to insist you either

    a) maintain your changes in public within 90 days of making them, or
    b) buy closed use seats, or
    c) cease to use the product.

and then apply it to the abusers of the system.  I understand this is 
still a scary thing in that there is no guarentee that we won't knock 
on your door, but the reality is that people always find ways to 
avoid the intent of licenses and we need some recourse.  At least this
way doesn't force this upon everyone, you have to exhibit some bad
behaviour in order for us to notice.

If you have a better idea on how to shut down the abusers without scaring
the legit users, I'm all ears.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
