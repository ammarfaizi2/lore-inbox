Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262286AbREZAjE>; Fri, 25 May 2001 20:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262302AbREZAiy>; Fri, 25 May 2001 20:38:54 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:24593 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S262286AbREZAih>; Fri, 25 May 2001 20:38:37 -0400
Date: Fri, 25 May 2001 21:38:28 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [with-PATCH-really] highmem deadlock removal, balancing & cleanup
In-Reply-To: <Pine.LNX.4.31.0105251731090.1105-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0105252137270.10469-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2001, Linus Torvalds wrote:

> That's not the part of the patch I object to - fixing that is fine.
>
> What I object to it that it special-cases the zone names, even
> though that doesn't necessarily make any sense at all.

OK, I'll fix that part.  Maybe even this weekend, before I go
on holidays ;)

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

