Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268022AbTBMLpx>; Thu, 13 Feb 2003 06:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268025AbTBMLpx>; Thu, 13 Feb 2003 06:45:53 -0500
Received: from 3-157.ctame701-1.telepar.net.br ([200.193.161.157]:10983 "EHLO
	3-157.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S268022AbTBMLpw>; Thu, 13 Feb 2003 06:45:52 -0500
Date: Thu, 13 Feb 2003 09:55:28 -0200 (BRST)
From: Rik van Riel <riel@imladris.surriel.com>
To: Jamie Lokier <jamie@shareable.org>
cc: Andrea Arcangeli <andrea@e-mind.com>, "" <linux-kernel@vger.kernel.org>
Subject: Re: openbkweb-0.0
In-Reply-To: <20030213024751.GA14016@bjl1.jlokier.co.uk>
Message-ID: <Pine.LNX.4.50L.0302130946541.21354-100000@imladris.surriel.com>
References: <20030206021029.GW19678@dualathlon.random>
 <20030213024751.GA14016@bjl1.jlokier.co.uk>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2003, Jamie Lokier wrote:
> Andrea Arcangeli wrote:
> > I guess the bitkeeper network protocol could be also implemented on the
> > longer run, it should be much faster to fetch all the database that way,
>
> Nobody (who is covered by copyright laws) is allowed to use the _free_
> version of BitKeeper to reverse engineer the protocol.  I may be
> mistaken - perhaps the BitKeeper "anti-competition" clause would be
> found unenforcable.. but I'm not interested in going there.

Reverse engineering the protocol is probably allowed, as long
as you don't create an alternative implementation yourself.

I can't see how Larry's license would stop people from writing
that alternative implementation, as long as those people don't
use bitkeeper themselves.

This is mostly because the license doesn't forbid creating an
alternative to bitkeeper (I doubt Larry would even want that,
even if the law granted that much power).  All it does is not
grant the free use of bitkeeper to people working on an alternative.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>
