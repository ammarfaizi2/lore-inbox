Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284985AbRLKN7y>; Tue, 11 Dec 2001 08:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbRLKN7e>; Tue, 11 Dec 2001 08:59:34 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:28424 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284985AbRLKN7W>;
	Tue, 11 Dec 2001 08:59:22 -0500
Date: Tue, 11 Dec 2001 11:59:06 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
In-Reply-To: <20011211144223.E4801@athlon.random>
Message-ID: <Pine.LNX.4.33L.0112111157410.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001, Andrea Arcangeli wrote:

> > The VM code lacks comments, and nobody except yourself understands
> > what it is supposed to be doing.  That's a bug, don't you think?
>
> Lack of documentation is not a bug, period. Also it's not true that
> I'm the only one who understands it.

Without documentation, you can only know what the code
does, never what it is supposed to do or why it does it.

This makes fixing problems a lot harder, especially since
people will never agree on what a piece of code is supposed
to do.

regards,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

