Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131761AbRCUUNC>; Wed, 21 Mar 2001 15:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131764AbRCUUMw>; Wed, 21 Mar 2001 15:12:52 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:40978 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131761AbRCUUMi>; Wed, 21 Mar 2001 15:12:38 -0500
Date: Wed, 21 Mar 2001 17:05:01 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: kswapd deadlock 2.4.3-pre6
In-Reply-To: <Pine.LNX.4.21.0103211654540.9056-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.21.0103211704290.9056-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Mar 2001, Rik van Riel wrote:
> On Wed, 21 Mar 2001, Mike Galbraith wrote:
> 
> > I have a repeatable deadlock when SMP is enabled on my UP box.
> 
> Linus' version of do_anonymous_page() is racy too...

Umm, forget that, I was reading too much code at once and
missed a few lines ... ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

