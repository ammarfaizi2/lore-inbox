Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUB0LSf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 06:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbUB0LSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 06:18:33 -0500
Received: from zadnik.org ([194.12.244.90]:6873 "EHLO lugburz.zadnik.org")
	by vger.kernel.org with ESMTP id S261202AbUB0LSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 06:18:31 -0500
Date: Fri, 27 Feb 2004 13:18:12 +0200 (EET)
From: Grigor Gatchev <grigor@zadnik.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A Layered Kernel: Proposal
In-Reply-To: <403E47B4.8080507@matchmail.com>
Message-ID: <Pine.LNX.4.44.0402271151040.26240-100000@lugburz.zadnik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 26 Feb 2004, Mike Fedyk wrote:

> Grigor Gatchev wrote:
> > I don't see the need for starting a project.
> >
> > First, if unsuccssful, no reason to start it. And if successful, it will
> > fork the kernel development, with all negative implications following.
> > I see no sense in doing what eventually will damage the kernel
> > development, instead of improving it.
>
> If you start a project, that doesn't mean the "fork" is bad as long as
> the intention is to integrate the work back into the base.

Typically, yes. But what I am trying to discuss is a kernel model
improvement. Such a project, when taken to the point where it works well,
will be very hard, if possible at all, to integrate into the base. If it
wasn't so,I would be the happiest man around, being able to test all
doubts in practice, without meddling in other people's work.

> What you are asking for is for people to add to their list of things to
> code.  You should be adding code yourself.

Not true. I would be doing that if I was thoroughly convinced that the
layered model is good, and that it is exactly the kernel model needed.

Currenly, it seems to me a good idea. That is why, after some months of
gnawing at it, I dared to post here. However, I have also seen a lot of
"great" ideas that are actually bad - and am afraid that this may turn one
of these. My judgement is not subscribed for the eternal truth, after all.

Currently we talk not already coding, but still designing. And what I am
asking for is people to add to _my_ list to work on. If they would like to
contribute some design work, that will be nice, but a simple "It is weak
here, see to improve it" will be already excellent help.

> Linux has many groups of people pushing and pulling it in numerous
> directions.  Very rarely does a direction succeed if the people who want
> that specific direction don't submit code.
>
> Useful discussion would be asking for implementation suggestions to get
> to your goal.  Oh wait, I think there are already some of those in this
> thread.

Wait, wait a bit :-) I am still trying to see if that attractively looking
model is really good. After (rather, _if_) it is proven good, I would be
asking for implementation suggestions. But let's see first if it is worth
implementing.

As for directions and adding code: Nobody ever, AFAIK, has intentionally
pushed the kernel towards this layered model. And the kernel source is
already structured in a way convenient to go with it, and for the last
three years was going exactly in this direction! That is why it seems
to me that this is the internal logic of the kernel development.


Grigor

