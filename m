Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261966AbREPNxm>; Wed, 16 May 2001 09:53:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbREPNxc>; Wed, 16 May 2001 09:53:32 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:12824 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261966AbREPNxP>; Wed, 16 May 2001 09:53:15 -0400
Date: Wed, 16 May 2001 15:52:53 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5pre2aa1
Message-ID: <20010516155253.A15796@athlon.random>
In-Reply-To: <20010515235916.B2415@athlon.random> <Pine.LNX.4.21.0105152039060.4671-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105152039060.4671-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Tue, May 15, 2001 at 08:42:03PM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2001 at 08:42:03PM -0300, Rik van Riel wrote:
> On Tue, 15 May 2001, Andrea Arcangeli wrote:
> 
> > Detailed description of 2.4.5pre2aa1 follows.
> 
> > 00_buffer-2
> > 
> > 	Reschedule during oom while allocating buffers, still getblk
> > 	can deadlock with oom but this will hide it pretty well as
> > 	it won't loop in a tight loop anymore.
> 
> These descriptions are very helpful. Are they available somewhere

I'm happy to hear that.

> for all your (recent) patches?

Almost everything was shortly described in my last emails. Those
descriptions are available also as .log into my ftp area.

Andrea
