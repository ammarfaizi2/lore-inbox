Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265106AbSJROoC>; Fri, 18 Oct 2002 10:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265107AbSJROoC>; Fri, 18 Oct 2002 10:44:02 -0400
Received: from fastmail.fm ([209.61.183.86]:30630 "EHLO www.fastmail.fm")
	by vger.kernel.org with ESMTP id <S265106AbSJROoB> convert rfc822-to-8bit;
	Fri, 18 Oct 2002 10:44:01 -0400
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.2  (F2.6; T1.001; A1.48; B2.12; Q2.03)
Date: Fri, 18 Oct 2002 14:49:53 UT
From: "Jeffrey Lim" <kernel-list@jfsworld.fastmail.fm>
To: "David S. Miller" <davem@redhat.com>, genlogic@inrete.it
X-Epoch: 1034952598
X-Sasl-enc: +b106Frfe/k0HcZyTSKCbQ
Cc: linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
Message-Id: <20021018144951.337862FD51@server4.fastmail.fm>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Oct 2002 12:52:34 -0700 (PDT), "David S. Miller"
<davem@redhat.com> said:
>
>        From: Daniele Lugli <genlogic@inrete.it>
>        Date: Mon, 14 Oct 2002 21:46:08 +0200
>    
>        Moral of the story: in my opinion kernel developers should reduce to a
>        minimum the use of #define, and preferably use words in uppercase
>        and/or with underscores, in any case not commonly used words.
> 
> Or maybe you should change your datastructure to not have member names
> the conflict with 7 year old well defined global symbols in the Linux
> kernel?
>

I guess tradition may have been well established. Is there an faq for
this somewhere (for these "well defined global symbols", that is) that we
could perhaps refer to?

I do believe he has a point though. It would be good to watch the
#defines in the future, so as to make it easier for aspiring coders.

-jf
 
#!/bin/signoff
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
echo The reasonable man adapts himself to the world; the unreasonable one
echo persists in trying to adapt the world to himself. Therefore, all
echo progress depends on the unreasonable.
echo                                              — George Bernard Shaw
# ~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~
 
 
