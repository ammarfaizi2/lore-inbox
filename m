Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSKJDGZ>; Sat, 9 Nov 2002 22:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSKJDGZ>; Sat, 9 Nov 2002 22:06:25 -0500
Received: from mta06bw.bigpond.com ([139.134.6.96]:33787 "EHLO
	mta06bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S263215AbSKJDGZ> convert rfc822-to-8bit; Sat, 9 Nov 2002 22:06:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Solved 2.4.20pre11aa1/2.4.20rc1aa1 Agpgart/Radeon crash. [was: Re: 2.4.20pre11aa1]
Date: Sun, 10 Nov 2002 14:24:20 +1100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021018145204.GG23930@dualathlon.random> <200211092034.39100.harisri@bigpond.com> <20021110025008.GF2544@x30.random>
In-Reply-To: <20021110025008.GF2544@x30.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211101424.20996.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

On Sunday 10 November 2002 13:50, Andrea Arcangeli wrote:
> Great job! Many thanks! This reduces the bug a whole lot. I will think
> on Monday what could be going wrong with that patch, in the meantime
> just try to run (slower ;) with it backed out, to be sure it's really

I am running complete 2.4.20rc1aa1 minus 10_x86-fast-pte-2 at present. It has 
been very stable as mainline plus as snappy as -aa :).

On a related note, I had to apply 20_rcu-poll-7 for compiling 10* patch(es) 
(even for the10_ext3-o_direct-2 patch), so would it be a good idea to move it 
as the earliest 10* patch?

Thanks.
-- 
Hari
harisri@bigpond.com

