Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286328AbRLJUZg>; Mon, 10 Dec 2001 15:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286371AbRLJUZ2>; Mon, 10 Dec 2001 15:25:28 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:16651 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284615AbRLJUZQ>; Mon, 10 Dec 2001 15:25:16 -0500
Date: Mon, 10 Dec 2001 17:08:44 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
Message-ID: <Pine.LNX.4.21.0112101705281.25362-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea, 

Could you please start looking at any 2.4 VM issues which show up ?

Just please make sure that when sending a fix for something, send me _one_
problem and a patch which fixes _that_ problem.

I'm tempted to look at VM, but I think I'll spend my limited time in a
better way if I review's others people work instead.

---------- Forwarded message ----------
Date: Mon, 10 Dec 2001 16:46:02 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up



On Mon, 10 Dec 2001, Abraham vd Merwe wrote:

> Hi!
> 
> If I leave my machine on for a day or two without doing anything on it (e.g.
> my machine at work over a weekend) and I come back then 1) all my memory is
> used for buffers/caches and when I try running application, the OOM killer
> kicks in, tries to allocate swap space (which I don't have) and kills
> whatever I try start (that's with 300M+ memory in buffers/caches).

Abraham, 

I'll take a look at this issue as soon as pre8 is released. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

