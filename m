Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284924AbRLFBhy>; Wed, 5 Dec 2001 20:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284929AbRLFBho>; Wed, 5 Dec 2001 20:37:44 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:52752 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S284924AbRLFBhg>;
	Wed, 5 Dec 2001 20:37:36 -0500
Date: Wed, 5 Dec 2001 23:37:19 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Pavel Machek <pavel@suse.cz>
Cc: <torvalds@transmeta.com>, <marcelo@conectiva.com.br>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Trivial typo in comment, please apply
In-Reply-To: <20011205223755.A263@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33L.0112052336470.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Pavel Machek wrote:

> Yep, its simple.

> - * mm.h, but m.h is including fs.h via sched .h :-/
> + * mm.h, but mm.h is including fs.h via sched .h :-/
                                           ^^^^^^^^
... and wrong, you might as well fix the last typo too ;)

cheers,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

