Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287933AbSA3Bjy>; Tue, 29 Jan 2002 20:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287924AbSA3Bjf>; Tue, 29 Jan 2002 20:39:35 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:42898
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287880AbSA3BjT>; Tue, 29 Jan 2002 20:39:19 -0500
Message-Id: <200201300139.g0U1d2U23149@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: A modest proposal -- We need a patch penguin
Date: Tue, 29 Jan 2002 20:40:11 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Skip Ford <skip.ford@verizon.net>, <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <andrea@suse.de>
In-Reply-To: <Pine.LNX.4.33.0201291538530.1747-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0201291538530.1747-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 29 January 2002 06:50 pm, Linus Torvalds wrote:
> On Tue, 29 Jan 2002, Rob Landley wrote:
>
> > Ah.  So being listed in the maintainers list doesn't mean someone is
> > actually a maintainer it makes sense to forward patches to?
>
> Sure it does.
>
> It just doesn't mean that they should send stuff to _me_.
>
> Did you not understand my point about scalability?

I was asking for clarification.

> I can work with a
> limited number of people, and those people can work with _their_ limited
> number of people etc etc.

I.E. a tree structure.

> The MAINTAINERS file is _not_ a list of people I work with on a daily
> basis. In fact, I don't necessarily even recognize the names of all those
> people.
>
> Let's take an example. Let's say that you had a patch for ppp. You'd send
> the patch to Paul Mackerras. He, in turn, would send his patches to David
> Miller (who knows a hell of a lot better what it's all about than I do).
> And he in turn sends them to me.
>
> They are both maintainers. That doesn't mean that I necessarily work with
> every maintainer directly.

Okay, so there's a tree of maintainers, and some maintainers seem unaware 
that they should be sending their patches to other maintainers rather than 
directly to you?

Does this seem like a valid assessment of at least part of the problem?

> Why? Because having hundreds of people emailing me _obviously_ doesn't
> scale. Never has, never will. It may work over short timeperiods wih lots
> of energy, but it obviously isn't a stable setup.

Well at least we agree on something. :)

> 			Linus

Rob
