Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266943AbUAXOo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 09:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266946AbUAXOo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 09:44:29 -0500
Received: from ms-smtp-01-smtplb.ohiordc.rr.com ([65.24.5.135]:13234 "EHLO
	ms-smtp-01-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S266943AbUAXOo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 09:44:27 -0500
Message-ID: <401284CD.7080006@borgerding.net>
Date: Sat, 24 Jan 2004 09:44:29 -0500
From: Mark Borgerding <mark@borgerding.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC]   "smack the penguin"
References: <401177DB.8010901@nortelnetworks.com> <20040124095208.GA20489@zombie.inka.de>
In-Reply-To: <20040124095208.GA20489@zombie.inka.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eduard Bloch wrote:

>#include <hallo.h>
>* Chris Friesen [Fri, Jan 23 2004, 02:36:59PM]:
>  
>
>>Diversion for friday afternoon...how far can you get?
>>
>>Personal best is 586
>>    
>>
>
>Which means that you are playing it either on a Windows box (what a
>shame) or cheating somehow or you have a 5Ghz box or something else is
>wrong on regular Linux systems. I do not any Linux user who got
>more than 325.5 with the Linux version of the Shockwave plugin.
>  
>

Sounds like 3/4 of the programmers I've ever worked with --  if they 
can't figure out how to do it, then it can't be done and anyone who says 
otherwise must be lying or cheating.


Still, it does seem like the game is much less predictable on some 
systems.  I have a linux laptop that plays it quite nicely (thus the 
593.4 I reported earlier).  I tried it on my desktop at home, and it was 
very jerky.

The two systems are pretty comparable.

For anyone who cares: here's the main differences with laptop (good) on 
the left and the desktop (bad) on the right:

Mozilla: 1.5 on both, build dates 20031107 vs 20031007
Flash Version:    6.0.79.0   vs   6.0.69.0
CPU:   Pent M 1700   vs Athlon XP 2100+
Video: ATI Radeon M9 vs Matrox G400      <=== I think this is the problem
Kernel: 2.4.21 (debian) vs 2.6.1

I am going to reboot to check against the 2.4 kernel. Who knows? Maybe 
there will be a pingu bug report against the 2.6 kernel series.



