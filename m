Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264579AbRFTThV>; Wed, 20 Jun 2001 15:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264580AbRFTThL>; Wed, 20 Jun 2001 15:37:11 -0400
Received: from wet.kiss.uni-lj.si ([193.2.98.10]:62732 "EHLO
	wet.kiss.uni-lj.si") by vger.kernel.org with ESMTP
	id <S264579AbRFTThF>; Wed, 20 Jun 2001 15:37:05 -0400
Content-Type: text/plain;
  charset="iso-8859-2"
From: Rok =?iso-8859-2?q?Pape=BE?= <rok.papez@kiss.uni-lj.si>
Reply-To: rok.papez@kiss.uni-lj.si
To: linux-kernel@vger.kernel.org
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
Date: Wed, 20 Jun 2001 21:36:09 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01062021360901.02282@strader.home>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

It's hard not to reply to this kind of message but there is so much
"anti-thread hype" here that someone obviously has to stand up to it.
This reply isn't aimed just at Larry but at all the anti-thread-rant
people with 0 threads == 0 problems attitude.

On Tuesday 19 June 2001 18:09, Larry McVoy wrote:
>     "If you think you need threads then your processes are too fat"
>     ``Think of it this way: threads are like salt, not like pasta. You
>     like salt, I like salt, we all like salt. But we eat more pasta.''

Here are more from the same basket you obviously got the first quote from:

------------------------------------
Virtual memory is only for unskilled programmers who don't know how to use
overlays.
------------------------------------
Protected memory is a constant 10% CPU hog needed only by undisciplined
programmers who can't keep their memory writes in their own process space.
------------------------------------

> Threads are a really bad idea.

I could *say* the same about Alans co-routines and Async IO :-). But it
would be foolish of me to criticize something I haven't used.

There is more than one way how to skin a dinosaur. And threads are one
way of doing it. You don't like it ? FINE. But don't go bashing it.

Probably most people bash threads becouse of a silly way POSIX designed
(designed is an overstatement) their pthread API and becouse UNIX was
around before threads thus probably making every UNIX thread support a
hacked and not a designed tool.
Other OSes have certainly proven threads to be nice and usable.

And here is another one for you quotes page:
------------------------------------
If you can't stick your head out of your own backyard please... don't
go and crtiticize the world... :-)
------------------------------------

-- 
best regards,
Rok Pape¾.
