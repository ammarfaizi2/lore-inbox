Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292325AbSBPJCQ>; Sat, 16 Feb 2002 04:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292327AbSBPJCH>; Sat, 16 Feb 2002 04:02:07 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:26876 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S292325AbSBPJBw>; Sat, 16 Feb 2002 04:01:52 -0500
Message-ID: <3C6E1FED.2005E55A@mvista.com>
Date: Sat, 16 Feb 2002 01:01:33 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Johan.J.Vikerskog@telia.se
CC: linux-kernel@vger.kernel.org
Subject: Re: Compiling error which nobody has been able to help me with yet.
In-Reply-To: <H000297a0cbdc66d.1013593341.tms3.han.telia.se@MHS>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johan.J.Vikerskog@telia.se wrote:
> 
> I try to compile 2.2.16 om a celeron 433 and i get the following error
> message all the time even
> if i have SMP totally disabled.
> 
> `smp_num_cpus` undeclared (first use in this function)
> 
> And some similial rows.
> Nothing yet has managed to help me with this.
> 
> And please note that SMP is disabled. I DONT have several CPU's.
> 
> Any help would be HIGHLY appreciated.
> 
It might be that more help would be offered if you included more info,
like the console lines leading up to the error, or at the very least,
the source file being compiled at the time.


-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
