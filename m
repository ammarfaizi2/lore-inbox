Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261708AbREOXmm>; Tue, 15 May 2001 19:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261709AbREOXmc>; Tue, 15 May 2001 19:42:32 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59920 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261708AbREOXmU>;
	Tue, 15 May 2001 19:42:20 -0400
Date: Tue, 15 May 2001 20:42:03 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5pre2aa1
In-Reply-To: <20010515235916.B2415@athlon.random>
Message-ID: <Pine.LNX.4.21.0105152039060.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Andrea Arcangeli wrote:

> Detailed description of 2.4.5pre2aa1 follows.

> 00_buffer-2
> 
> 	Reschedule during oom while allocating buffers, still getblk
> 	can deadlock with oom but this will hide it pretty well as
> 	it won't loop in a tight loop anymore.

These descriptions are very helpful. Are they available somewhere
for all your (recent) patches?

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

