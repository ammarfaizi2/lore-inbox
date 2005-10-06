Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVJIHwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVJIHwT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 03:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVJIHwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 03:52:19 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50118 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932236AbVJIHwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 03:52:19 -0400
Date: Thu, 6 Oct 2005 10:20:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: Lorenzo Colitti <lorenzo@colitti.com>, Pavel Machek <pavel@ucw.cz>,
       Nigel Cunningham <ncunningham@cyclades.com>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [swsusp] separate snapshot functionality to separate file
Message-ID: <20051006082050.GA10865@openzaurus.ucw.cz>
References: <20051004205334.GC18481@elf.ucw.cz> <1128465272.6611.75.camel@localhost> <20051005084141.GB22034@elf.ucw.cz> <434443D9.3010501@colitti.com> <20051005224418.GA22781@elf.ucw.cz> <4344599B.7060308@colitti.com> <20051005225727.GE22781@elf.ucw.cz> <20051005230045.GA22906@elf.ucw.cz> <43445F51.7090403@colitti.com> <4344F820.6010701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4344F820.6010701@gmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>"Cool, so you have done 100% of work and now it is stable, fast and
> >>tested. You only need to do 200% more work to get it merged".
> >>
> >>Merging into kernel is not easy, sorry.
> >> 
> >It works, it's fast, it's stable, and it does what users want. 
> >That's a strong combination. It would be really good if you could 
> >work together to merge it.

> I've read this thread...
> And I want to join this request...
> 
> It might be that suspend2 is not the best solution, but 
> maybe if you merge it and then work together in order to 
> maximize the use of user space at next version, it will be 

Merge 10000 lines of code, only to drop them in next version?

Better not.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

