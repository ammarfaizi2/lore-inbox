Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263337AbSJFFqN>; Sun, 6 Oct 2002 01:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263338AbSJFFqN>; Sun, 6 Oct 2002 01:46:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20232 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263337AbSJFFqN>; Sun, 6 Oct 2002 01:46:13 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: New BK License Problem?
Date: Sun, 6 Oct 2002 05:50:50 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <anoivq$35b$1@penguin.transmeta.com>
References: <AD47B5CD-D7DB-11D6-A2D4-0003939E069A@mac.com> <3D9F49D9.304@redhat.com> <20021005162852.I11375@work.bitmover.com> <1033861827.4441.31.camel@irongate.swansea.linux.org.uk>
X-Trace: palladium.transmeta.com 1033883479 21844 127.0.0.1 (6 Oct 2002 05:51:19 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 6 Oct 2002 05:51:19 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1033861827.4441.31.camel@irongate.swansea.linux.org.uk>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>
>Linus used to do about a patch every 2 days. Nowdays its a lot slower. I
>put that down to buttkeeper

Don't be silly, Alan.

I don't do any pre-patches or daily patches any more, because it's all
automated.  There are several snapshot bots that give you patches a lot
more often than "every 2 days".  You don't need BK to use it, it's there
in the good old diff format. 

(I haven't checked whether the auto-patches do a good job of doing
changelogs too, but since all the changelogs I generate for the _real_
releases are also automated and I make the tools I use to generate them
available, that's certainly not anything fundamental). 

So yes, you can "put it down to bitkeeper" in the sense that it's
because of the automation that BK allows that I don't _need_ to
personally do pre-patches any more. 

"Big boo-hoo, bitkeeper is evil, and Linus doesn't manually do any more
 what BK plus a few scripts does better for us automatically."

		Linus
