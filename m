Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273918AbRIRVEL>; Tue, 18 Sep 2001 17:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273925AbRIRVDx>; Tue, 18 Sep 2001 17:03:53 -0400
Received: from 64-42-29-14.atgi.net ([64.42.29.14]:18692 "HELO
	mail.clouddancer.com") by vger.kernel.org with SMTP
	id <S273918AbRIRVDp>; Tue, 18 Sep 2001 17:03:45 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.4 Success story
Reply-To: klink@clouddancer.com
Message-Id: <20010918192003.5C326783ED@mail.clouddancer.com>
Date: Tue, 18 Sep 2001 12:20:03 -0700 (PDT)
From: klink@clouddancer.com (Colonel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A brief note of _thanks_ to all that create the linux kernel.

Mid-morning, I checked on a database fetch that has occaisonally
gotten out of hand and overrun the system -- depending on the kernel
version.  It was overrun but this time, it was probably due to a
change I made in the fetch code yesterday....  but the _real_ issue is
that this is the first time I have ever had a very responsive system
under a load of 13+ and a couple hundred processes.  There have been
countless times in the past that getting control when the system load
has gone past 6-7 was nearly impossible.

I was completely amazed and spent about 30 seconds to tame the rogue
processes, with system access feeling just like normal load
conditions.

This particular gem of a kernel is:

2.4.9-ac10 #1 SMP Tue Sep 11 21:47:15 PDT 2001 i686

THANKS!


I'd suggest that those running large applications experiencing
problems in transition from 2.2 -> 2.4 give this kernel a try.


