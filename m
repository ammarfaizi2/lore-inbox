Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261496AbSIXAn1>; Mon, 23 Sep 2002 20:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261497AbSIXAn1>; Mon, 23 Sep 2002 20:43:27 -0400
Received: from dp.samba.org ([66.70.73.150]:33492 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S261496AbSIXAn0>;
	Mon, 23 Sep 2002 20:43:26 -0400
Date: Tue, 24 Sep 2002 10:40:30 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: jlnance@intrex.net, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-Id: <20020924104030.0e53b95e.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0209201842200.8689-100000@localhost.localdomain>
References: <20020920083736.B1280@tricia.dyndns.org>
	<Pine.LNX.4.44.0209201842200.8689-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Sep 2002 18:42:48 +0200 (CEST)
Ingo Molnar <mingo@elte.hu> wrote:
> 
> On Fri, 20 Sep 2002 jlnance@intrex.net wrote:
> > Is this related to the thread library work that IBM was doing or was
> > this independently developed?
> 
> independently developed.

And, ironically, using the futex implementation developed on IBM time 8).

Of course, the time I spent on futexes would have been completely wasted
without the 95% done by Ingo and Uli to reach normal user programs and
address the other scalability problems.

Thanks guys!  IOU each a beer or local equiv...
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
