Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271617AbRIBNLu>; Sun, 2 Sep 2001 09:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271618AbRIBNLl>; Sun, 2 Sep 2001 09:11:41 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:18438 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271617AbRIBNLZ>;
	Sun, 2 Sep 2001 09:11:25 -0400
Date: Sun, 2 Sep 2001 10:11:21 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Rik`s ac12-pmap2 vs ac12-vanilla perfcomp
In-Reply-To: <200109021710.f82HAbD00606@vegae.deep.net>
Message-ID: <Pine.LNX.4.33L.0109021009310.24097-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Sep 2001, Samium Gromoff wrote:

>    No flames please - i know these were low VM loads, i did this just
> to know how big is test rmaps maitenance overhead. It shows us that
> even on low VM load there is a huge win in using rmap. And the win
> increases with the VM load.

Interesting, I'm just at a proof-of-concept implementation right
now, which is not yet stable or ready.  ;)

I guess page replacement _is_ important...

cheers,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

