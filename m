Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266603AbUIEMnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266603AbUIEMnV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 08:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266611AbUIEMnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 08:43:21 -0400
Received: from rproxy.gmail.com ([64.233.170.198]:1746 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266603AbUIEMnT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 08:43:19 -0400
Message-ID: <1a56ea3904090505437e82b656@mail.gmail.com>
Date: Sun, 5 Sep 2004 13:43:18 +0100
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler experiences
In-Reply-To: <413B0872.1090607@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <1094386464.18114.0.camel@localhost>
	 <1a56ea390409050525583d0438@mail.gmail.com>
	 <413B0872.1090607@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 Sep 2004 22:37:06 +1000, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> DaMouse wrote:
> 
> >
> > I personally like staircase, i also used to use nicksched but i prefer
> > staircases simple design and structure. Nicksched was pretty fast but
> > twiddling around all day with renicing X and now the HT issues are
> > annoying and staircase has always worked perfectly for me without
> > flipping fifty switches in the cockpit.
> >
> 
> The HT issue should be fixed (I hope).
> 
> Why did you have to "twiddle around all day with renicing X"? I realise
> you're overstating, but you really should be fine with just setting X
> to -10 at startup and be done with it.
> 
> 

http://forums.gentoo.org/viewtopic.php?t=217543 <-- see here, your
mind makes it real... spooky :)

Thats -mm2 but I can't find patches that fix the HT problems in that
thread, mind pointing them out?

-DaMouse

-- 
I know I broke SOMETHING but its there fault for not fixing it before me
