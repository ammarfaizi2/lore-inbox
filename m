Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317836AbSFMV3a>; Thu, 13 Jun 2002 17:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317837AbSFMV33>; Thu, 13 Jun 2002 17:29:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:26251 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317836AbSFMV31>;
	Thu, 13 Jun 2002 17:29:27 -0400
Date: Thu, 13 Jun 2002 23:27:16 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: mingo@elte.hu
To: Robert Love <rml@tech9.net>
Cc: "Bhavesh P. Davda" <bhavesh@avaya.com>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] SCHED_FIFO and SCHED_RR scheduler fix, kernel 2.4.18
In-Reply-To: <1024003481.6704.98.camel@sinai>
Message-ID: <Pine.LNX.4.44.0206132324350.14637-100000@e2>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 13 Jun 2002, Robert Love wrote:

> You are entirely right, but Ingo's point is very valid: changing wakeup
> behavior is risky and is not ideal in the middle of 2.4.
> 
> Fixing major bugs is fine for 2.4, but changing behavior to suit an
> ideal is not.  Now is your chance to do so for 2.5, however.

i'd like to point out again that the current 2.5 scheduler has all the
functionality the patch adds for 2.4, so there's no argument about whether
it's correct technically.

	Ingo


