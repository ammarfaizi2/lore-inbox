Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264125AbRFIH4D>; Sat, 9 Jun 2001 03:56:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264262AbRFIHzy>; Sat, 9 Jun 2001 03:55:54 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:273 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S264125AbRFIHzk>;
	Sat, 9 Jun 2001 03:55:40 -0400
Date: Sat, 9 Jun 2001 04:55:36 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Derek Glidden <dglidden@illusionary.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <m1ofs15tm0.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.21.0106090455050.14934-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Jun 2001, Eric W. Biederman wrote:
> Derek Glidden <dglidden@illusionary.com> writes:
> 
> > The problem I reported is not that 2.4 uses huge amounts of swap but
> > that trying to recover that swap off of disk under 2.4 can leave the
> > machine in an entirely unresponsive state, while 2.2 handles identical
> > situations gracefully.  
> 
> The interesting thing from other reports is that it appears to be
> kswapd using up CPU resources.

This part is being worked on, expect a solution for this thing
soon...


Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

