Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265873AbRFYEBy>; Mon, 25 Jun 2001 00:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265874AbRFYEBo>; Mon, 25 Jun 2001 00:01:44 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:54287 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S265873AbRFYEBe>; Mon, 25 Jun 2001 00:01:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: klink@clouddancer.com (Colonel), linux-kernel@vger.kernel.org
Subject: Re: What are the VM motivations??
Date: Mon, 25 Jun 2001 06:04:45 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010621190103.A888@jmcmullan.resilience.com> <9h6916$4og$1@ns1.clouddancer.com> <20010625034427.65260784D9@mail.clouddancer.com>
In-Reply-To: <20010625034427.65260784D9@mail.clouddancer.com>
MIME-Version: 1.0
Message-Id: <01062506044500.16624@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 June 2001 05:44, Colonel wrote:
> In clouddancer.list.kernel, you wrote:
> >On Monday 25 June 2001 03:46, Russell Leighton wrote:
> >> I read this thread as asking the question:
> >>
> >>     If VM management is viewed as an optimization problem,
> >>     then what exactly is the function that you are optimizing and what
> >> are the constraints?
> >>
> >> If you could express that well with a even a very loose model, then
> >> the code could be reviewed to see if it was really doing what was
> >> intended and assumptions could be tested.
> >
> >May I suggest an algorithm?
> >
> >  - Write down what you think the optimization constraints are.
> >    (be specific, for example, enumerate all the flavors of page types -
> >    process code, process data, page cache file data, page cache swap
> >    cache, anonymous, shmem, etc.)
> >
> >  - Write down what you think the current algorithms are.
> >    (again, be specific, use file names, function names, pseudocode and
> >    snippets of existing code.)
> >
> >  - Send it to Rik.  He'll tell you if it's right.
>
> POST IT.  Give the rest of us some clues and the opportunity to check
> evaluator's replies.

Well, if you try that strategy you'll find you never get around to posting it 
because you'll be too worried about getting it right.  The point is not to 
get it right, it's to get a starting point down on (virtual) paper.  I'd 
strongly suggest passing something like that around for comment privately 
first.

*Then* post it.

(and convince me you're not just talking)

--
Daniel
