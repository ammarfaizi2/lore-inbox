Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289583AbSAVXry>; Tue, 22 Jan 2002 18:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289589AbSAVXrq>; Tue, 22 Jan 2002 18:47:46 -0500
Received: from [65.188.226.101] ([65.188.226.101]:63496 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S289583AbSAVXre>; Tue, 22 Jan 2002 18:47:34 -0500
From: dank@trellisinc.com
To: linux-kernel@vger.kernel.org
Subject: Re: When will CLONE_THREAD be available in a thread package?
In-Reply-To: <3C4C9122.384C675C@mvista.com>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.2.19ext3 (i686))
Message-Id: <20020122234717.D63BDA3EA2@fancypants.trellisinc.com>
Date: Tue, 22 Jan 2002 18:47:17 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C4C9122.384C675C@mvista.com> you wrote:
> A bit off topic, but....

> CLONE_THREAD has been in the kernel for a bit, but is their a threads
> package for user land that uses it?  If not when?

look at ibm's next-generation posix threading:
http://oss.software.ibm.com/pthreads/

i've been keeping up patches (most recent:  2.4.16) at:
http://gtf.org/~dank/ngpt/

-- 
nicholas black (dank@trellisinc.com)
"c has types for a reason.  c++ improved the type system for a reason.  perl
 and php programs have run-time failures for a reason." - lkml
