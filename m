Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSEZKMG>; Sun, 26 May 2002 06:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315926AbSEZKMF>; Sun, 26 May 2002 06:12:05 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:16893 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315925AbSEZKME>; Sun, 26 May 2002 06:12:04 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020525143333.A17889@work.bitmover.com> 
To: Larry McVoy <lm@bitmover.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Linus Torvalds <torvalds@transmeta.com>, Wolfgang Denk <wd@denx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)] 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 26 May 2002 11:11:38 +0100
Message-ID: <22471.1022407898@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lm@bitmover.com said:
> On Sat, May 25, 2002 at 05:22:43PM -0400, Albert D. Cahalan wrote:
> > To get a free patent license, EVERYTHING must be GPL.
> > Not just the real-time part! So that would be:
> > 
> > 1. the RT microkernel (OK)
> > 2. the RT "app"       (OK)
> > 3. Linux itself       (OK)
> > 4. normal Linux apps  (ouch!)

> Whether that is true or not I don't know.  But I do know that if all
> the stuff was GPLed, then you are safe no matter what, right? 

It's been asserted that the patent licence requires that _all_ userspace 
apps running on the system by GPL'd. Yet there are many Free Software 
applications in a standard Linux distribution that are under 
GPL-incompatible licences. Apache, xinetd, etc...

If that interpretation is true, it _would_ be a problem, and not just for 
those trying to make money from it.

--
dwmw2


