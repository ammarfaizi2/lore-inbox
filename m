Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbREZOju>; Sat, 26 May 2001 10:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261936AbREZOja>; Sat, 26 May 2001 10:39:30 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11530 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S261759AbREZOjS>; Sat, 26 May 2001 10:39:18 -0400
Date: Sat, 26 May 2001 16:38:57 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
Message-ID: <20010526163857.V9634@athlon.random>
In-Reply-To: <20010526161825.T9634@athlon.random> <Pine.LNX.4.21.0105261120500.30264-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0105261120500.30264-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Sat, May 26, 2001 at 11:21:18AM -0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 26, 2001 at 11:21:18AM -0300, Rik van Riel wrote:
> On Sat, 26 May 2001, Andrea Arcangeli wrote:
> 
> > I didn't checked the alloc_pages() other thing mentioned by Ben, if
> > alloc_pages() deadlocks internally that's yet another completly
> > orthogonal bug and that will be addressed by another patch if it
> > persists.
> 
> O, that part is fixed by the patch that Linus threw away
> yesterday ;)

what are you smoking? I read your patch and there's nothing related to
such fix in your patch. I won't have much more time to follow up on this
thread. From now on about the highmem deadlocks topic I will only listen
to real world bugreports of 2.4.5 plus the bugfix I posted a few minuts
ago. If anybody is able to reproduce the deadlocks press SYSRQ+T and
send me the output along the System.map. Thanks in advance for your
cooperation.

Andrea
