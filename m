Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262060AbRE3USZ>; Wed, 30 May 2001 16:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262027AbRE3USP>; Wed, 30 May 2001 16:18:15 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:30216 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S262023AbRE3USI>;
	Wed, 30 May 2001 16:18:08 -0400
Date: Wed, 30 May 2001 17:16:41 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Vincent Stemen <linuxkernel@AdvancedResearch.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM... (and 2.4.5-ac3)
In-Reply-To: <01052916363700.00493@quark>
Message-ID: <Pine.LNX.4.21.0105301714400.13062-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2001, Vincent Stemen wrote:

> I do not like that at all.  I should not have to have to tie up a
> bunch of extra hard drive space for swap if I have plenty of RAM for
> 90% of my usage.  During the 2.0.x days I was always able to run with
> a small swap or no swap at all

I don't like it either, but I have not had the time
yet to write a patch to fix this.  Unfortunately the
rest of the world didn't seem to have time to write
a patch either so we'll have to live with the problem
for a while more.

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

