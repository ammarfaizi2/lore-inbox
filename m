Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261659AbSJFQWd>; Sun, 6 Oct 2002 12:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261695AbSJFQVc>; Sun, 6 Oct 2002 12:21:32 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:60803 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261701AbSJFQUs>;
	Sun, 6 Oct 2002 12:20:48 -0400
Message-ID: <3DA0642A.1070706@colorfullife.com>
Date: Sun, 06 Oct 2002 18:26:18 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: grendel@debian.org
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Larry McVoy <lm@bitmover.com>, "David S. Miller" <davem@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: BK MetaData License Problem?
References: <3DA02F30.8040904@colorfullife.com> <Pine.LNX.4.44.0210061452400.6237-100000@localhost.localdomain> <20021006154806.GA2524@thanes.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russel King wrote:
 >
 > Therefore, I'd stronlg advise people in the EU not to use BK's
 > BK_USER/BK_HOST feature when importing patches.
 >
I think the user info is not critical: according to the GPL, you must 
tag your changes with date+name. By making a patch, you have agreed to 
the GPL terms, which means you have agreed that your name will be used 
together with the change.
I think the copyright laws require that, too.

But the GPL doesn't mandate a changelog...


Marek Habersack wrote:
> 
> Perhaps I am being silly at the moment, but wouldn't it suffice in this case
> to put a statement in your commit message (I believe it can be automated)
> stating that this message and the comitted data are licensed under the GPL?
 >

For example.
Or a sentence in the Licensing file, or whatever.("If you want to 
contribute to the development at www.kernel.org, then you must agree to 
the following conditions: You name will be used, your commit text will 
be used, your mail address will be published etc." No GPL conflict, you
are free to fork)

I agree with Ingo that there is the danger that without anything, it 
might happen that we'd have to throw away the changelogs [or that 
express permission for all existing entries will be needed, which is 
more or less equivalent]

--
	Manfred

