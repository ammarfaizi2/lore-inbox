Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbVIUUGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbVIUUGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 16:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbVIUUGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 16:06:00 -0400
Received: from mail23.sea5.speakeasy.net ([69.17.117.25]:11701 "EHLO
	mail23.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751367AbVIUUF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 16:05:59 -0400
Date: Wed, 21 Sep 2005 13:05:59 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Nick Warne <nick@linicks.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: A pettiness question.
In-Reply-To: <200509212046.15793.nick@linicks.net>
Message-ID: <Pine.LNX.4.58.0509211305250.24543@shell4.speakeasy.net>
References: <200509212046.15793.nick@linicks.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Nick Warne wrote:

> >> This give a enum of {0,1}. If test is not 0, !!test will give 1,
> >> otherwise 0.
> >>
> >> Am I right?
> >
> > Yes.  I think of it as a "truth value" predicate (or operator).
>
> Interesting.  I thought maybe this way was trick, until later I experimented.
>
> My post here (as Bill Stokes):
>
> http://www.quakesrc.org/forums/viewtopic.php?t=5626
>
> So what is the reason to doing !!num as opposed to num ? 1:0 (which is more
> readable I think, especially to a lesser experienced C coder).  Quicker to
> type?

Some people also prefer the following form:
	num != 0

> My quick test shows compiler renders both the same?
>
> Nick
> --
> "When you're chewing on life's gristle,
> Don't grumble, Give a whistle..."
> -

-Vadim Lobanov
