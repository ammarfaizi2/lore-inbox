Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292290AbSBOXw4>; Fri, 15 Feb 2002 18:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292289AbSBOXwq>; Fri, 15 Feb 2002 18:52:46 -0500
Received: from [208.29.163.248] ([208.29.163.248]:62870 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S292288AbSBOXwg>; Fri, 15 Feb 2002 18:52:36 -0500
Date: Fri, 15 Feb 2002 15:51:09 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <20020215153636.D32005@work.bitmover.com>
Message-ID: <Pine.LNX.4.44.0202151549360.2991-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wasn't at the kernel summit meeting, but my undersanding from the
'press' reports was that it was the CML1 guys who said they wanted to
throw it out and start from scratch. I don't know what role Eric had in
the discussion, but it sure didn't sound like it was him alone prompting
the change.

David Lang


On Fri, 15 Feb 2002, Larry McVoy wrote:

> Date: Fri, 15 Feb 2002 15:36:36 -0800
> From: Larry McVoy <lm@bitmover.com>
> To: linux-kernel@vger.kernel.org
> Subject: Re: Disgusted with kbuild developers
>
> On Sat, Feb 16, 2002 at 12:23:12AM +0100, Matthias Andree wrote:
> > Are you telling that kernel programmers don't rewrite code from scratch?
> > Is that a correct interpretation of "improve the existing system"? Note
> > that "it can't be done" can also imply "cannot reasonable be done".
> >
> > If that's not what you mean, stop reading this mail, drop a line to
> > clarify this and forget this piece of mail.
>
> That's not what I mean.  But it's worthwhile to note that almost all
> "rewrite from scratch" projects really translate into "I'm unwilling to
> learn what the last guy did, and I'm smarter, so I'm going to do what
> I want to do".  And that is not what kernel programmers do.  They would
> love to be able to do that but it's very rare that doing so makes sense.
>
> In reality, the guy who came before you wasn't an idiot.  Maybe s/he
> didn't do the best job possible, but the fact that the code is there and
> works implies some level of understanding.  Real programmers make their
> work fit *seamlessly* with the work of the people who came before them.
> It's egoless programming, you are striving to make things fit so well
> that noone can see where person A stopped and person B started.
>
> In Eric's case, it would have been far better if he had done some work
> to make CML1 work better.  It simply isn't broken enough to justify
> throwing it out.  And it's not at all clear to me, at least, that the
> CML2 stuff is any less broken, it's just broken in different ways.
> Unless Eric can make a system that is widely viewed as better overall
> than CML1, making one that is better in some ways but worse or just as
> bad in others, well, that's a big waste of time.
>
> At Sun, we had a rule that a major change was automatically disallowed
> unless it showed a factor of 2 improvement in some important way while
> holding the other variables constant.  I don't think CML2 would pass
> that test.  Aunt Tillie's opinion doesn't count.
> --
> ---
> Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
