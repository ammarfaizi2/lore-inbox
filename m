Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265727AbSLSRVV>; Thu, 19 Dec 2002 12:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSLSRVV>; Thu, 19 Dec 2002 12:21:21 -0500
Received: from skyline.vistahp.com ([65.67.58.21]:25285 "HELO
	escalade.vistahp.com") by vger.kernel.org with SMTP
	id <S265727AbSLSRVU>; Thu, 19 Dec 2002 12:21:20 -0500
Message-ID: <20021219173329.32340.qmail@escalade.vistahp.com>
References: <200212191335.gBJDZRDL000704@darkstar.example.net>
In-Reply-To: <200212191335.gBJDZRDL000704@darkstar.example.net>
From: "Brian Jackson" <brian-kernel-list@mdrx.com>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dedicated kernel bug database
Date: Thu, 19 Dec 2002 11:33:29 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would just like to second what somebody said about bugzilla yesterday, 
that it is hard to search for bugs that have already been entered. Just 
something to think about. 

 --Brian Jackson 

John Bradford writes: 

> Following on from yesterday's discussion about there not being much
> interaction between the kernel Bugzilla and the developers, I began
> wondering whether Bugzilla might be a bit too generic to be suited to
> kernel development, and that maybe a system written from the ground up
> for reporting kernel bugs would be better? 
> 
> I.E. I am prepared to write it myself, if people think it's
> worthwhile. 
> 
> For example, we get a lot of posts on LKML like this: 
> 
> "Hi, foobar doesn't work in 2.4.19" 
> 
> Now, does that mean: 
> 
> * The bug first appeared in 2.4.19, and is still in 2.4.20
> * The bug reporter hasn't tested 2.4.20
> * The bug reporter can't test 2.4.20 because something else is broken
> * The bug actually first appeared in 2.4.10, but it didn't irritate
>   them enough to complain until now. 
> 
> A bug database designed from scratch could allow such information to
> be indexed in a way that could be processed and searched usefully.  A
> list of tick-boxes for worked/didn't work/didn't test/couldn't test
> for several kernel versions could be presented. 
> 
> Also, we could have a non-web interface, (telnet or gopher to the bug
> DB, or control it by E-Mail). 
> 
> It could warn the user if they attach an un-decoded oops that their
> bug report isn't as useful as it could be, and if they mention a
> distribution kernel version, that it's not a tree that the developers
> will necessarily be familiar with. 
> 
> I'm not criticising the fact that we've got Bugzilla up and running,
> but just pointing out that we could do better, (and I'm prepared to
> put in the time and effort).  I just need ideas, really. 
> 
> John.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
 
