Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261392AbREZP1z>; Sat, 26 May 2001 11:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbREZP1p>; Sat, 26 May 2001 11:27:45 -0400
Received: from [200.203.199.88] ([200.203.199.88]:47622 "HELO netbank.com.br")
	by vger.kernel.org with SMTP id <S261392AbREZP1j>;
	Sat, 26 May 2001 11:27:39 -0400
Date: Sat, 26 May 2001 12:26:38 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.5
In-Reply-To: <20010526172444.A9634@athlon.random>
Message-ID: <Pine.LNX.4.21.0105261226160.30264-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 May 2001, Andrea Arcangeli wrote:
> On Sat, May 26, 2001 at 12:18:07PM -0300, Rik van Riel wrote:
> > It's the changes to __alloc_pages(), where we don't loop forever
> > but fail the allocation.
> 
> __alloc_pages() should definitely not to loop forever but it should
> fail the allocation instead.

Guess what's in my patch?

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

