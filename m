Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267470AbSLSAqf>; Wed, 18 Dec 2002 19:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267473AbSLSAqf>; Wed, 18 Dec 2002 19:46:35 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:7857 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267470AbSLSAqc>;
	Wed, 18 Dec 2002 19:46:32 -0500
Date: Wed, 18 Dec 2002 16:47:35 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Till Immanuel Patzschke <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] 15000+ processes -- poor performance ?!
Message-ID: <25840000.1040258855@flay>
In-Reply-To: <3E0116D6.35CA202A@inw.de>
References: <3E0116D6.35CA202A@inw.de>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> as part of my project I need to run a very high number of processes/threads on a
> linux machine.  Right now I have a Dual-PIII 1.4G w/ 8GB RAM -- I am running
> 4000 processes w/ 2-3 threads each totaling in a process count of 15000+
> processes (since Linux doesn't really distinguish between threads and
> processes...).
> Once I pass the 10000 (+/-) pocesses load increases drastically (on startup,
> although it returns to normal), however the system time (on one processor)
> reaches for 54% (12061 procs) while the only non sleeping process is top -- the
> system is basically doing nothing (except scheduling the "nothing" which
> consumes significant system time).
> Is there anything I can do to reduce that system load/time?  (I haven't been
> able to exactly define the "line" but it definitly gets worse the more processes
> need to be handled.)

You don't even specify what kernel you're using ...

> Does any of the patchsets address this particular problem?

Read the linux-kernel archives.

M.

