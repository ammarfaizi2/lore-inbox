Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286012AbRLTDvE>; Wed, 19 Dec 2001 22:51:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286044AbRLTDuy>; Wed, 19 Dec 2001 22:50:54 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:53253 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S286012AbRLTDur>;
	Wed, 19 Dec 2001 22:50:47 -0500
Date: Thu, 20 Dec 2001 01:50:36 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Davide Libenzi <davidel@xmailserver.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112181508001.3410-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0112200149330.15741-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2001, Linus Torvalds wrote:

> The thing is, I'm personally very suspicious of the "features for that
> exclusive 0.1%" mentality.

Then why do we have sendfile(), or that idiotic sys_readahead() ?

(is there _any_ use for sys_readahead() ?  at all ?)

cheers,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/

