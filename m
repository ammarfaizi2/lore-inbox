Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269598AbRHCUyX>; Fri, 3 Aug 2001 16:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269599AbRHCUyO>; Fri, 3 Aug 2001 16:54:14 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:12561 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S269598AbRHCUx5>;
	Fri, 3 Aug 2001 16:53:57 -0400
Date: Fri, 3 Aug 2001 17:53:55 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: David Ford <david@blue-labs.org>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Ongoing 2.4 VM suckage
In-Reply-To: <3B6AE67A.9060709@blue-labs.org>
Message-ID: <Pine.LNX.4.33L.0108031751590.11893-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Aug 2001, David Ford wrote:

> If it is that badly broken, isn't that sufficient criteria to justify
> the patch?

It's not just a patch. Fixing this problem will require
a major VM rewrite. A rewrite I really wasn't willing
to make for 2.4.

I'll start writing the thing, but I won't be aiming at
getting it included in 2.4. I guess I could code it in
such a way to give a drop-in replacement for people
willing to cut themselves on the bleeding edge, though ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

