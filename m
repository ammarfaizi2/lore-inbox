Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTBTUH4>; Thu, 20 Feb 2003 15:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbTBTUH4>; Thu, 20 Feb 2003 15:07:56 -0500
Received: from mx2.elte.hu ([157.181.151.9]:58804 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S264730AbTBTUHy>;
	Thu, 20 Feb 2003 15:07:54 -0500
Date: Thu, 20 Feb 2003 21:14:36 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous
 reboots)
In-Reply-To: <Pine.LNX.4.44.0302202057020.2262-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0302202112480.2656-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Feb 2003, Ingo Molnar wrote:

> ie. something like:
> 
> (untested yet.)

tested it - works fine, but i was unable to reproduce the crash in the
past couple of hours, so this datapoint is of little value ATM.

	Ingo

