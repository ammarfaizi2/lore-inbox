Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316782AbSFUU0M>; Fri, 21 Jun 2002 16:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316783AbSFUU0L>; Fri, 21 Jun 2002 16:26:11 -0400
Received: from [213.23.20.221] ([213.23.20.221]:20911 "EHLO starship")
	by vger.kernel.org with ESMTP id <S316782AbSFUU0K>;
	Fri, 21 Jun 2002 16:26:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Cort Dougan <cort@fsmlabs.com>, Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: Linux, the microkernel (was Re: latest linus-2.5 BK broken)
Date: Fri, 21 Jun 2002 22:25:22 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Larry McVoy <lm@bitmover.com>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206201003500.8225-100000@home.transmeta.com> <3D136BEF.3030509@mandrakesoft.com> <20020621124634.H13628@host110.fsmlabs.com>
In-Reply-To: <20020621124634.H13628@host110.fsmlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17LUyA-0001wU-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 June 2002 20:46, Cort Dougan wrote:
> I don't see Linux being in serious jeopardy in the short-term of becoming
> solaris.  It only aims at running on 1-4 processors and does a pretty good
> job of that.  Most sane people realize, as Larry points out, that the
> current design will not scale to 64 processors and beyond.  That's obvious,
> it's not an alarmist or deep statement.  The key is to realize that it's
> not _meant_ to scale that high right now.

And originally, it was never meant to scale to more than one processor.

-- 
Daniel
