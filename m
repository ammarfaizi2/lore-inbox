Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265840AbRFYBnU>; Sun, 24 Jun 2001 21:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265842AbRFYBnL>; Sun, 24 Jun 2001 21:43:11 -0400
Received: from be02.imake.com ([151.200.87.11]:47119 "EHLO be02.tfsm.com")
	by vger.kernel.org with ESMTP id <S265840AbRFYBnB>;
	Sun, 24 Jun 2001 21:43:01 -0400
Message-ID: <3B3697FB.3B7F098@247media.com>
Date: Sun, 24 Jun 2001 21:46:36 -0400
From: Russell Leighton <russell.leighton@247media.com>
X-Mailer: Mozilla 4.51 [en] (Win98; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Jason McMullan <jmcmullan@linuxcare.com>
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: What are the VM motivations??
In-Reply-To: <20010621190103.A888@jmcmullan.resilience.com> <Pine.LNX.4.21.0106241203420.7419-100000@imladris.rielhome.conectiva> <20010624140114.A10745@jmcmullan.resilience.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I read this thread as asking the question:

    If VM management is viewed as an optimization problem,
    then what exactly is the function that you are optimizing and what are the constraints?

If you could express that well with a even a very loose model, then
the code could be reviewed to see if it was really doing what was intended
and assumptions could be tested.

This seems like a reasonable request.

Jason McMullan wrote:

> On Sun, Jun 24, 2001 at 12:04:43PM -0300, Rik van Riel wrote:
> > OK.  I challenge you to come up with:
> >
> > 1) the set of inputs for the neural network
> > 2) the set of outputs
> > 3) the goal for training the thing
> >
> > I'm pretty fed up with people who want to "change the VM"
> > but never give any details of their ideas.
>
>         Uhh. That's not what I was ranting about. What I was
> ranting about is that we have never 'put to paper' the
> requirements ('motiviations') for a good VM, nor have we
> looked at said nonexistent list and figured out what instrumentation
> would be needed.
>
>         I don't now that much about VM, but I do know a bunch of
> people each scratching their own itch, and most of them not looking
> at the bigger picture. Linus, RvR, etc. excepted. Mostly. ;^)
>
>         The whole 'neural network' bit was mostly troll. Sorry,
> I got a little carried away at that point.
>
> --
> Jason McMullan, Senior Linux Consultant
> Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
> jmcmullan@linuxcare.com, http://www.linuxcare.com/
> Linuxcare. Putting open source to work.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
---------------------------------------------------
Russell Leighton    russell.leighton@247media.com
---------------------------------------------------


