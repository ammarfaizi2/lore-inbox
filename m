Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282686AbRK0ArO>; Mon, 26 Nov 2001 19:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282688AbRK0ArG>; Mon, 26 Nov 2001 19:47:06 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:5388 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282686AbRK0Aqv>;
	Mon, 26 Nov 2001 19:46:51 -0500
Date: Mon, 26 Nov 2001 22:46:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Nathan G. Grennan" <ngrennan@okcforum.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Unresponiveness of 2.4.16
In-Reply-To: <3C02E009.7C1F17C6@zip.com.au>
Message-ID: <Pine.LNX.4.33L.0111262245550.4079-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Andrew Morton wrote:

> umm...  What I said.
>
> balance_dirty_state() is allowing writes to flood the machine
> with locked buffers.

Saw your patch, it's neat.  I'm going to try it
first thing in the morning...

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

