Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261990AbRE3UNP>; Wed, 30 May 2001 16:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262009AbRE3UNF>; Wed, 30 May 2001 16:13:05 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12808 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261990AbRE3UNB>;
	Wed, 30 May 2001 16:13:01 -0400
Date: Wed, 30 May 2001 17:12:41 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Tania Oka <tania@centurysys.co.jp>
Cc: linux-kernel@vger.kernel.org, glenn@centurysys.co.jp
Subject: Re: boundary condition bug in do_mmap()
In-Reply-To: <3B14B3A2.2843422E@centurysys.co.jp>
Message-ID: <Pine.LNX.4.21.0105301712170.13062-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Tania Oka wrote:

>     if ((offset + PAGE_ALIGN(len)) < offset)

Why are you mailing this the week after it was
fixed ?  :)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

