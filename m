Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286315AbRLJQtf>; Mon, 10 Dec 2001 11:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284460AbRLJQt0>; Mon, 10 Dec 2001 11:49:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:51218 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S284461AbRLJQtP>; Mon, 10 Dec 2001 11:49:15 -0500
Date: Mon, 10 Dec 2001 14:48:55 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: <volodya@mindspring.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: mm question
In-Reply-To: <Pine.LNX.4.20.0112101112430.17492-100000@node2.localnet.net>
Message-ID: <Pine.LNX.4.33L.0112101448120.4755-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2001 volodya@mindspring.com wrote:
> On Mon, 10 Dec 2001, Rik van Riel wrote:
> > On Mon, 10 Dec 2001, Alan Cox wrote:
> >
> > > > I was hoping for something more elegant, but I am not adverse to writing
> > > > my own get_free_page_from_range().
> > >
> > > Thats not a trivial task.
> >
> > Especially because we never quite know the users of a
> > physical page, so moving data around is somewhat hard.
>
> I don't want to move them - I just want to collect all that are free
> and then try to free some more.

I could put it on the TODO list for my VM stuff, but it's
not exactly near the top of the list so it might take quite
a while more before I get around to this...

http://linuxvm.bkbits.net/

cheers,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

