Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290809AbSAYVYy>; Fri, 25 Jan 2002 16:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290811AbSAYVYj>; Fri, 25 Jan 2002 16:24:39 -0500
Received: from flrtn-4-m1-156.vnnyca.adelphia.net ([24.55.69.156]:59523 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S290809AbSAYVYZ>;
	Fri, 25 Jan 2002 16:24:25 -0500
Date: Fri, 25 Jan 2002 13:24:09 -0800 (PST)
From: jjs@mirai.cx
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Uptime again?
In-Reply-To: <Pine.LNX.3.95.1020125134800.1544A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44.0201251320270.12771-100000@jyro.mirai.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a data point, I have several Red Hat 7.1 boxes installed in various 
production environments, uptimes of 150-200 days so far with no end in 
sight... most are running the official 2.4.3-12, but I have been installing 
either the RH 2.4.9 update or 2.4.18pre2-aa2 on servers whenever there is 
occasion to reboot.

Joe

 On Fri, 25 Jan 2002, Richard B. Johnson wrote:

> 
> Uptime, when using Linux-2.4.1 doesn't seem to go past 128 days!
> This is a RedHat distrubution, 7.x
> 
> These are the last three days:
> 
>  11:59am  up 128 days, 21:24,  2 users,  load average: 1.03, 1.01, 1.00
>  10:06am  up 128 days, 12:31,  2 users,  load average: 1.02, 1.00, 1.00
>   1:06pm  up 128 days, 22:31,  2 users,  load average: 1.00, 1.00, 1.00
> Linux boneserver 2.4.1 #15 SMP Thu Aug 9 16:03:49 EDT 2001 i686
>   1:10pm  up 128 days, 22:35,  2 users,  load average: 1.08, 1.02, 1.01
> USER     TTY      FROM              LOGIN@  IDLE   JCPU   PCPU  WHAT
> root     ttyp1    chaos.analogic.com 1:05pm  0.00s  0.12s  0.02s  w 
> 
> 
> My Sun, which did NOT reboot several days ago, shows:
> 
>   1:11pm  up 2 day(s), 22:30,  1 user,  load average: 0.00, 0.00, 0.01
> 
> So it looks like it just 'wrapped'.
>  
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
> 
>     I was going to compile a list of innovations that could be
>     attributed to Microsoft. Once I realized that Ctrl-Alt-Del
>     was handled in the BIOS, I found that there aren't any.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

