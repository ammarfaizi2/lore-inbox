Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282222AbRLDG3s>; Tue, 4 Dec 2001 01:29:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282224AbRLDG3j>; Tue, 4 Dec 2001 01:29:39 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:2949 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S282232AbRLDG3c>;
	Tue, 4 Dec 2001 01:29:32 -0500
Date: Mon, 03 Dec 2001 22:32:47 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Larry McVoy <lm@bitmover.com>, hps@intermeta.de
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
Message-ID: <2396420267.1007418767@[10.10.1.2]>
In-Reply-To: <20011203193815.A7439@work.bitmover.com>
X-Mailer: Mulberry/2.0.5 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Larry McVoy <lm@bitmover.com> writes:
>> 
>> > then 4->8, etc.  By your logic, someone should be sitting down and saying
>> > here is how you get to 128.  Other than myself, noone is doing that and
>> > I'm not really a Linux kernel hack, so I don't count.  
>> 
>> "No one that you know". I'm always surprised that you're able to speak
>> with such confidence. There may be lots of things going on that don't
>> daily report to you.
> 
> Right you are, but...  There is also piles of information that I absorb
> on a daily basis, and I'm always willing to be educated.  For example,
> you could educate me about all those 128 processor Linux boxes in the
> world and fill in a hole in my knowledge.  I'm listening...

SGI has machines bigger than 128 (if memory serves, 1024??) that I thought
had booted Linux. The Sequent/IBM NUMA-Q archictecture now supports Linux 
and would go to 64 procs if we removed a few bitmap limitations from the kernel 
that have been patched out before (well, actually 60 is easy, 64 would require
some more apic modifications). 

Anyway, bigger than 8 way is no pipedream. I'll admit few people could afford
such machines, but they do exist.

Martin.

