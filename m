Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbTBTPoB>; Thu, 20 Feb 2003 10:44:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTBTPoB>; Thu, 20 Feb 2003 10:44:01 -0500
Received: from mx1.elte.hu ([157.181.1.137]:62848 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S265612AbTBTPoA>;
	Thu, 20 Feb 2003 10:44:00 -0500
Date: Thu, 20 Feb 2003 16:52:46 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302200717230.2142-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302201652210.29812-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


another datapoint: on SMP i can get various types of backtraces, on UP
it's the spontaneous reboot that triggers.

	Ingo

