Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315374AbSELTFe>; Sun, 12 May 2002 15:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSELTFd>; Sun, 12 May 2002 15:05:33 -0400
Received: from inje.iskon.hr ([213.191.128.16]:4260 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S315374AbSELTFd>;
	Sun, 12 May 2002 15:05:33 -0400
To: Rik van Riel <riel@conectiva.com.br>
Cc: Bill Davidsen <davidsen@tmr.com>, linux-mm@kvack.org,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] IO wait accounting
In-Reply-To: <Pine.LNX.4.44L.0205091607400.7447-100000@duckman.distro.conectiva>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Sun, 12 May 2002 21:05:03 +0200
Message-ID: <87bsbl9ogw.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:
>
> And should we measure read() waits as well as page faults or
> just page faults ?
>

Definitely both. Somewhere on the web was a nice document explaining
how Solaris measures iowait%, I read it few years ago and it was a
great stuff (quite nice explanation).

I'll try to find it, as it could be helpful.
-- 
Zlatko
