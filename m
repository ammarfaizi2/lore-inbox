Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbTIKBRA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbTIKBRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:17:00 -0400
Received: from dp.samba.org ([66.70.73.150]:25730 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265910AbTIKBQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:16:48 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hugh Dickins <hugh@veritas.com>, Ulrich Drepper <drepper@redhat.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>,
       davem@redhat.com
Subject: Re: [PATCH] Re: today's futex changes 
In-reply-to: Your message of "Wed, 10 Sep 2003 12:39:29 +0100."
             <20030910113929.GA21945@mail.jlokier.co.uk> 
Date: Thu, 11 Sep 2003 08:00:00 +1000
Message-Id: <20030911011647.ACB302C21F@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030910113929.GA21945@mail.jlokier.co.uk> you write:
> Rusty Russell wrote:
> > BTW, I'm guessing from your preference for multi-line comments that
> > you don't use a color-coding editor for source?  I must say that once
> > I got used to it, I really prefer comments in green.
> 
> You mean the /*
>               *
>               */ style?
> 
> No, I never use that style, except in futex.c to go along with the
> style that was already there!  I use Emacs with comments in red-orange :) 

I'll submit a trivial patch to condense them again: it's an Ingo-ism.
Comments in my parts of the code are less, um, verbose 8)

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
