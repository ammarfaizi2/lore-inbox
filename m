Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135537AbRDSDx2>; Wed, 18 Apr 2001 23:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135538AbRDSDxS>; Wed, 18 Apr 2001 23:53:18 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6155 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135537AbRDSDxF>; Wed, 18 Apr 2001 23:53:05 -0400
Subject: Re: ANNOUNCE New Open Source X server
To: gnea@rochester.rr.com (Scott Prader)
Date: Thu, 19 Apr 2001 04:54:52 +0100 (BST)
Cc: miles@megapathdsl.net (Miles Lane), linux-kernel@vger.kernel.org
In-Reply-To: <20010418215602.A9035@rochester.rr.com> from "Scott Prader" at Apr 18, 2001 09:56:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14q5Ww-0006N1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> different, new, from scratch, to go in another direction.  I think Linus
> himself did this back in 1991, obviously not with X, but you get the
> idea I think.  If not, then don't bother answering cuz it'll just be a

Yeah and we spent most of those 10 years reinventing wheels in order to make
them free.  There are people doing interesting things with X rendering and
the ideas behind it. Some of them have been at it since Linus was a small
child. The TinyX server framework also lets you hack arbitarily interesting
card drivers into a nice easy framework. 

There are also folks like the directfb people who've implemented something
Rasterman ranted about ages ago - which is using the 3d hardware subsystem to
render windows as rectangular textures.

I've seen exactly _one_ X project that is justifiably seperate. Thats weirdX
and its separate because its in Java. If you like the idea of

	http://localhost/

giving you an Xdm window you'll find it worth a play

