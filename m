Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265355AbTBTMZ4>; Thu, 20 Feb 2003 07:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTBTMYQ>; Thu, 20 Feb 2003 07:24:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11392 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S265243AbTBTMXw>;
	Thu, 20 Feb 2003 07:23:52 -0500
Date: Thu, 20 Feb 2003 13:33:23 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <20030220121216.GK22687@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0302201332580.11598-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


i had some other stuff in my tree as well, which could be the culprit. The
crash looked unrelated though. (procfs optimizations for the threaded
case.)

	Ingo

