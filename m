Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317422AbSIELrg>; Thu, 5 Sep 2002 07:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317457AbSIELrg>; Thu, 5 Sep 2002 07:47:36 -0400
Received: from dp.samba.org ([66.70.73.150]:1518 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S317422AbSIELrb>;
	Thu, 5 Sep 2002 07:47:31 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
Cc: Andi Kleen <ak@suse.de>, Harald Welte <laforge@gnumonks.org>,
       Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Schaaf <bof@bof.de>
Subject: Re: ip_conntrack_hash() problem 
In-reply-to: Your message of "05 Sep 2002 09:19:01 +0200."
             <1031210342.9785.159.camel@biker.pdb.fsc.net> 
Date: Thu, 05 Sep 2002 21:15:07 +1000
Message-Id: <20020905115208.4D0A02C064@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1031210342.9785.159.camel@biker.pdb.fsc.net> you write:
> Am Don, 2002-09-05 um 02.39 schrieb Rusty Russell:
> 
> > This work is already done:
> > http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Netfilter/connt
rack_hashing.patch.gz
> 
> Well, beautiful.
> Will this go into the main line kernel any time soon?
> (I'd be for that).
> 
> If there's still need for discussion regarding this patch, as the thread
> suggests, I'd propose to go for an intermediate, less intrusive fix like
> mine first.

I'll feed this through 2.5, once it's had some more testing (hint
hint!).  Then Harald will make a call on 2.4.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
