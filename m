Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268409AbTCFWN1>; Thu, 6 Mar 2003 17:13:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268443AbTCFWN1>; Thu, 6 Mar 2003 17:13:27 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:31392 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268409AbTCFWN1>; Thu, 6 Mar 2003 17:13:27 -0500
Date: Thu, 06 Mar 2003 14:14:07 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Dimitrie O. Paun" <dimi@intelliware.ca>, Ingo Molnar <mingo@elte.hu>
cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Andrew Morton <akpm@digeo.com>, Robert Love <rml@tech9.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
Message-ID: <13680000.1046988847@flay>
In-Reply-To: <Pine.LNX.4.44.0303061304230.23356-100000@dimi.dssd.ca>
References: <Pine.LNX.4.44.0303061304230.23356-100000@dimi.dssd.ca>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> yes, an ELF flag might work, or my suggestion to allow applications to
>> increase their priority (up until a certain degree).
> 
> An ELF flag might be better, as it's declarative -- it allows the kernel
> to implement 'interactivity' in various ways, so we can keep tweeking it.
> Priority might prove to be a bit different than interactivity, so we
> better not overload the two just yet.

Difficult to see how this would work. For instance, is bash interactive 
or a batch job?

M.

