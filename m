Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262649AbRFRTcl>; Mon, 18 Jun 2001 15:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262653AbRFRTcb>; Mon, 18 Jun 2001 15:32:31 -0400
Received: from [213.97.184.209] ([213.97.184.209]:1408 "HELO piraos.com")
	by vger.kernel.org with SMTP id <S262649AbRFRTcW>;
	Mon, 18 Jun 2001 15:32:22 -0400
Date: Mon, 18 Jun 2001 21:32:24 +0200 (CEST)
From: German Gomez Garcia <german@piraos.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Mailing List Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Strange behaviour of swap under 2.4.5-ac15
In-Reply-To: <20010618174445.F1317@athlon.random>
Message-ID: <Pine.LNX.4.33.0106182130050.266-100000@hal9000.piraos.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2001, Andrea Arcangeli wrote:

> On Mon, Jun 18, 2001 at 05:35:54PM +0200, German Gomez Garcia wrote:
> > On Mon, 18 Jun 2001, Andrea Arcangeli wrote:
> >
> > > On Mon, Jun 18, 2001 at 04:41:02PM +0200, German Gomez Garcia wrote:
> > > > so, if there is another way to get that info (maybe some file in /proc?)
> > >
> > > did you compiled with highmem?
> >
> > 	No,
>
> ok then with 512mbyte on an x86 my patch couldn't help. I thought it was
> it because the sympthom was the same (constant kswapd activity and
> constant swap grow) but it obviously is something else. Then try
> 2.4.6pre3aa1 (it is certainly stable).

	You were right, with 2.4.6pre3aa1 it works in the expected way (at
least the way it was expected before :-). I'm now at home so if you need
more info on it, I'll do my best.

	Regards,

	- german

-------------------------------------------------------------------------
German Gomez Garcia         | "This isn't right.  This isn't even wrong."
<german@piraos.com>         |                         -- Wolfgang Pauli

