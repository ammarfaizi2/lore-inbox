Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262662AbREZOZe>; Sat, 26 May 2001 10:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbREZOZY>; Sat, 26 May 2001 10:25:24 -0400
Received: from [200.203.199.88] ([200.203.199.88]:39940 "HELO netbank.com.br")
	by vger.kernel.org with SMTP id <S262658AbREZOZL>;
	Sat, 26 May 2001 10:25:11 -0400
Date: Sat, 26 May 2001 11:21:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526161825.T9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105261120500.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:

> I didn't checked the alloc_pages() other thing mentioned by Ben, if
> alloc_pages() deadlocks internally that's yet another completly
> orthogonal bug and that will be addressed by another patch if it
> persists.

O, that part is fixed by the patch that Linus threw away
yesterday ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

