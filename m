Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282067AbRLWQZG>; Sun, 23 Dec 2001 11:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281835AbRLWQYz>; Sun, 23 Dec 2001 11:24:55 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:23353 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S281787AbRLWQYp>; Sun, 23 Dec 2001 11:24:45 -0500
Message-Id: <4.3.2.7.2.20011223080930.00c5aed0@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Sun, 23 Dec 2001 08:24:29 -0800
To: David Woodhouse <dwmw2@infradead.org>
From: Stephen Satchell <list@fluent2.pyramid.net>
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in
  Configure.help. 
Cc: Phil Howard <phil-linux-kernel@ipal.net>, linux-kernel@vger.kernel.org
In-Reply-To: <32114.1009104214@redhat.com>
In-Reply-To: <4.3.2.7.2.20011222075342.00c11e00@10.1.1.42>
 <4.3.2.7.2.20011222075342.00c11e00@10.1.1.42>
 <Pine.GSO.4.30.0112221113120.2091-100000@balu>
 <E16H9C4-0005ST-00@sites.inka.de>
 <Pine.GSO.4.30.0112221113120.2091-100000@balu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:43 AM 12/23/01 +0000, David Woodhouse wrote:
>If you are more interested in the choices of the marketplace than in
>technical correctness, one has to wonder what you're doing on this mailing
>list.

Nice ad hominem attack, David.  Attack the messenger.  Good boy.

If you recall (or perhaps you have placed me in your kill file) I mentioned 
that the last place you want to make a sudden change in terminology is in 
the most public of places, the configuration help file.  You also missed my 
call to use the new abbreviations FIRST within the kernel itself, in /proc, 
and in those userland utilities that report system resource usage.  If the 
universe of Linux users accept it (translation: no flames erupt) then you 
can consider populating the configuration help files with them.

I also mentioned that we have a very, very large base of "legacy users" who 
do not understand what MiB would be (outside of the context of the movie 
_Men in Black_) and who would become very, very confused.  In short, making 
the change would CONFUSE THE NON-TECHNICAL USERS more than they already are.

I'm not against technical correctness.  I'm against witless, thoughtless, 
blind deployment of an idea without considering the consequences of that 
deployment.

Don't underestimate the power of "the market."  Have you seen much about 
MINIX lately?

Stephen Satchell

