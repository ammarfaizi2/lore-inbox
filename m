Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286574AbRL0UHz>; Thu, 27 Dec 2001 15:07:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286584AbRL0UHq>; Thu, 27 Dec 2001 15:07:46 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:63240 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286574AbRL0UHd>; Thu, 27 Dec 2001 15:07:33 -0500
Date: Thu, 27 Dec 2001 18:07:22 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <200112271957.fBRJvdv00960@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.33L.0112271802130.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Richard Gooch wrote:

> If you get this working nicely, it might even be a generally useful
> thing. A set of perl scripts and easy interface commands could prove
> popular. I would certainly find it convenient to have a patch
> retransmission system that re-sent patches every time a new pre-patch
> came out, and emailed me when the patch no longer applies.

... or compiles, or applies with an offset

> If it could automatically de-queue when the patch is applied, or when
> I manually remove it, that would be even better.

... or when somebody replies to the patch and the reply
gets caught by a program invoked from your .procmailrc

If Linus replies he has seen the patch, don't keep
bombing him.

Of course when the patch gets dequeued, the program should
send you a mail with the reason.

> And if I make an update to a queued patch, it obsoletes the old one,
> that would be good too.

Good one, this needs to be added.

Any more requirements / ideas / volunteers / ... ?

(and remember, this thing is designed to make Linus his life
easier, too)

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

