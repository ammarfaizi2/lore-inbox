Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262799AbREOPuM>; Tue, 15 May 2001 11:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbREOPuC>; Tue, 15 May 2001 11:50:02 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:14088 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262807AbREOPtt>;
	Tue, 15 May 2001 11:49:49 -0400
Date: Tue, 15 May 2001 12:49:41 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] filemap.c fixes
In-Reply-To: <Pine.LNX.4.21.0105150835330.1802-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0105151247140.4671-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001, Linus Torvalds wrote:

> Can you and Marcelo fight out the changes you've posted and re-do them
> against pre2?

OK. Though I don't know when Marcelo and I will be on the same
timezone again (for some reasons his days don't seem to take
24 hours ;)).

> I've applied some of the most obvious ones, but some had a thread of
> "we should really remove xxx/3" etc that didn't seem to get finished..

It should be ok to apply that patch anyway. When we _do_ figure
out which of the two options we should take we'll send you an
incremental patch. Until then we can just leave the "xxx/3" thing
alone.

(in fact, I don't think it'll make much of a difference at all)

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

