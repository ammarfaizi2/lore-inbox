Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314069AbSDVGcN>; Mon, 22 Apr 2002 02:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314070AbSDVGcM>; Mon, 22 Apr 2002 02:32:12 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:56582 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314069AbSDVGcL>; Mon, 22 Apr 2002 02:32:11 -0400
Date: Mon, 22 Apr 2002 16:33:45 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alexander Viro <viro@math.psu.edu>
Cc: torvalds@transmeta.com, spyro@armlinux.org, linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-Id: <20020422163345.31a9172f.rusty@rustcorp.com.au>
In-Reply-To: <Pine.GSO.4.21.0204202347010.27210-100000@weyl.math.psu.edu>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Apr 2002 00:05:27 -0400 (EDT)
Alexander Viro <viro@math.psu.edu> wrote:

> As one of the guys who doesn't use BK _and_ had submitted a lot of patches
> since Linus had started using it, I'm probably qualified to tell whether it
> hurts or not, right?  Well, it doesn't.  So far the only difference was
> in the quality (and latency) of changelogs and that was definitely welcome.

"me too".  Actually, I found it easier to get the Trivial patches in, and
about the same for per-cpu and futex patches.  I don't bk.

When patches didn't go in, it's more due to Mingo Theorum[1] than being
non-bk.  And that's a Good Thing for calibrating my coding tastes upwards.

Rusty.
[1] Message-ID: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain>
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
