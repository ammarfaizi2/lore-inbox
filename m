Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261935AbVDOThX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbVDOThX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 15:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbVDOThX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 15:37:23 -0400
Received: from smtp1.poczta.interia.pl ([217.74.65.44]:41044 "EHLO
	smtp.poczta.interia.pl") by vger.kernel.org with ESMTP
	id S261935AbVDOThD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 15:37:03 -0400
Message-ID: <426017DC.1080801@interia.pl>
Date: Fri, 15 Apr 2005 21:37:00 +0200
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SATA] status reports updated
References: <42600375.9080108@pobox.com> <42600E12.8020304@interia.pl> <42601474.5010008@tomt.net>
In-Reply-To: <42601474.5010008@tomt.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-EMID: 9145eacc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:
> Tomasz Chmielewski wrote:
> <
> 
>> [1] although my drive is blacklisted (Seagate barracuda - 
>> ST3200822AS), I "unblacklisted" it to get full performance - it's 
>> under heavy stress for 12th hour, and still no error.
> 
> 
> It could be that your drive has newer firmware. Too bad firmware 
> upgrades for HD's are hard to come by nowadays.

Is there a way to check what firmware a drive has (either by using some 
software - which would be the best option, or by reading a label on a 
drive)?

If so, we might compile some list to be put in the FAQ?


There was also a post on the list - 
http://www.uwsg.iu.edu/hypermail/linux/kernel/0503.1/0827.html - 
suggesting that upgrading Silicon Image BIOS helped resolving these 
problems.

So it might be newer drive firmware, or newer SATA card BIOS (or both) 
that makes my "sil + seagate" combination usable.


Tomek

----------------------------------------------------------------------
Startuj z INTERIA.PL! >>> http://link.interia.pl/f186c 

