Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286554AbRL0TrX>; Thu, 27 Dec 2001 14:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286556AbRL0TrP>; Thu, 27 Dec 2001 14:47:15 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:52485 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S286554AbRL0TrI>; Thu, 27 Dec 2001 14:47:08 -0500
Date: Thu, 27 Dec 2001 17:46:51 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: The direction linux is taking
In-Reply-To: <Pine.LNX.4.33.0112271126550.1052-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0112271742470.12225-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Dec 2001, Linus Torvalds wrote:
> On Thu, 27 Dec 2001, Rik van Riel wrote:
> >
> > Of course the patch will be updated when needed, but I still
> > have a few 6-month old patches lying around that still work
> > as expected and don't need any change.
>
> Sure. Automatic re-mailing can be part of the maintainership, if the
> testing of the validity of the patch is also automated (ie add a
> automated note that says that it has been verified).

Patch-bombing you with useless stuff has never been my
objective. I just want to make sure valid patches get
re-sent to you as long as there is a reason to believe
they still need to be sent.

As soon as any hint arrives that the patch shouldn't be
sent right now (a change was made to any of the files the
patch applies to, I see something suspect in the changelog,
the patch was applied, a reply was mailed to the patch...)
the patch will be moved away for manual inspection.

I guess I'll also build in some kind of backoff to make sure
the patch gets sent less often if you're not interested or too
busy.

regards,

Rik
-- 
DMCA, SSSCA, W3C?  Who cares?  http://thefreeworld.net/

http://www.surriel.com/		http://distro.conectiva.com/

