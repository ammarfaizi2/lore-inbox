Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289084AbSBMXGt>; Wed, 13 Feb 2002 18:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289089AbSBMXGd>; Wed, 13 Feb 2002 18:06:33 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:10761 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289084AbSBMXGR>;
	Wed, 13 Feb 2002 18:06:17 -0500
Date: Wed, 13 Feb 2002 21:05:54 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Allan Sandfeld <linux@sneulv.dk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-rc1
In-Reply-To: <E16b8HV-0001JS-00@Princess>
Message-ID: <Pine.LNX.4.33L.0202132104290.12554-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Allan Sandfeld wrote:
> On Wednesday 13 February 2002 20:33, Marcelo Tosatti wrote:
> > So here it goes.
> >
> > rc1:
> <snip>
> > - Merge some -ac bugfixes			(Alan Cox)
>
> Here's a crazy idea. Why not branch off the new pre-tree when
> commiting a rc-kernel?

Since I sit next to marcelo in the office I guess I could
answer this question.

The reason not to do this is because maintaining a kernel
is a horrible amount of work already and marcelo is pretty
overloaded with all the patches everybody send him.

OTOH, if _you_ volunteer to keep an -ac like kernel yourself
so small fixes can be sent to marcelo in batches...

cheers,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

