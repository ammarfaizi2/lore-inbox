Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265633AbSKTCwl>; Tue, 19 Nov 2002 21:52:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267395AbSKTCwl>; Tue, 19 Nov 2002 21:52:41 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:31166 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S265633AbSKTCwk>; Tue, 19 Nov 2002 21:52:40 -0500
Date: Wed, 20 Nov 2002 00:59:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Josh Myer <jbm@joshisanerd.com>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <Pine.LNX.4.44.0211192036530.30881-100000@blessed.joshisanerd.com>
Message-ID: <Pine.LNX.4.44L.0211200057370.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Josh Myer wrote:
> On Tue, 19 Nov 2002, Rik van Riel wrote:
> > On Tue, 19 Nov 2002, Jeff Garzik wrote:
> > > But who knows if #include'd code constitutes a derived work :(
> >
> > Only if the #included snippets of code are large enough to be
> > protected by copyright, which might be true of the stuff in
> > mm_inline.h and of some of the semaphore code, but probably
> > isn't true of the spinlock code.

> Since you're functionally using it, and it's not a protected use
> (Satire, etc, though some would argue that the nvidia drivers are a
> mockery...), I would tend to think Fair Use wouldn't apply in this case.
> Are there any IP Lawyers in the house?
>
> The only analogy i can think of is a remix of songs, and several people
> have gotten into wonderfully large lawsuits over that.

You can copyright songs, but not individual musical notes.

Likewise, snippets of code aren't copyrightable if they're below
a certain "triviality size".

> > Even if the code #included is large enough to be protected by
> > copyright I don't know if the code including it would be considered
> > a derived work. Many questions remaining...
>
> This basically all falls upon the shoulders of whoever wrote the spinlock
> code on whatever platform you're compiling for...

No, this is an issue of legislation and case law. Some copyright
holders (*eyes hollywood*) would like to be able to decide such
things for themselves, but this isn't something copyright holders
can decide...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

