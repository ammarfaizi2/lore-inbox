Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266458AbUGJWoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUGJWoh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 18:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266459AbUGJWoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 18:44:37 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:4506
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S266458AbUGJWoe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 18:44:34 -0400
Date: Sat, 10 Jul 2004 18:47:03 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org, hants@mailman.lug.org.uk
Subject: Re: 1000 days uptime.
Message-ID: <20040710224703.GA19378@animx.eu.org>
References: <Pine.LNX.4.44.0407102122060.21103-100000@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407102122060.21103-100000@linicks.net>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a 486 box serving web pages from a home base (via NFS to gateway).  
> No UPS, no special treatment expect dust and usual day-to-day abuse stuck
> under two other boxes in a 'stack' of sorts I done a long time ago...
> 
> [nick@486Linux nick]$ uptime
>   9:29pm  up 6 days,  1:40,  1 user,  load average: 0.15, 0.05, 0.10
> 
> [nick@486Linux nick]$ last -xf /var/run/utmp runlevel
> runlevel (to lvl 3)                    Sun Oct 14 16:07 - 21:29 
> (1000+05:22)
> 
> [nick@486Linux nick]$ uname -a
> Linux 486Linux 2.2.13-7mdk #1 Wed Sep 15 18:02:18 CEST 1999 i486 unknown

Show off...

[wakko@rod:/home/wakko] uptime ; last -xf /var/run/utmp runlevel 
  6:56pm  up 204 days, 14:40h,  3 users,  load average: 0.00, 0.00, 0.00
  runlevel (to lvl 5)                    Thu Nov 18 22:36 - 18:56
(1695+19:20)

utmp begins Thu Nov 18 22:36:07 1999
[wakko@rod:/home/wakko] uname -a
Linux rod 2.2.13 #1 Thu Nov 18 20:59:01 EST 1999 i586 unknown
[wakko@rod:/home/wakko] 


However, I do have mine on a UPS (literally =)

Kinda funny that it's basically the same kernel (Just yours is from mandrake
and mine is self compiled)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
