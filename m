Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289727AbSBSEiz>; Mon, 18 Feb 2002 23:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289711AbSBSEip>; Mon, 18 Feb 2002 23:38:45 -0500
Received: from hibernia.clubi.ie ([212.17.32.129]:11149 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S289727AbSBSEi2>; Mon, 18 Feb 2002 23:38:28 -0500
Date: Tue, 19 Feb 2002 04:47:45 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Stephen Frost <sfrost@snowman.net>
cc: bert hubert <ahu@ds9a.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <20020218195813.O20319@ns>
Message-ID: <Pine.LNX.4.44.0202190435340.11396-100000@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
X-Dumb-Filters: aryan marijuiana cocaine heroin hardcore cum pussy porn teen tit sex lesbian group
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Stephen Frost wrote:

> Linux ns2 2.2.16 #1 Sun Jul 30 21:57:38 EDT 2000 i386 unknown
>  19:55:29 up 1 day, 15:06,  1 user,  load average: 0.00, 0.03, 0.00
> 
> -rw-r--r--    1 root     root         1569 Oct  8  2000 /var/log/dmesg
> 
> No problems here so far, just wrapped.  Processes seemed to all handle
> it okay though ps now shows some things started in 2003.. :)

[root@adelphi /root]# uptime 
  4:26am  up 273 days,  1:34, 17 users,  load average: 0.15, 0.18, 0.14

ie it wrapped 273 days ago. :) 734 days. it's the standard RH 2.2.16 
kernel from RH6.1.

hanvt noticed any funnies whatsoever. (except init and some other
long running procs seem to have a start time that varies whenever you
run ps, which isnt right.)

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
It's a recession when your neighbour loses his job; it's a depression
when you lose yours.
		-- Harry S. Truman

