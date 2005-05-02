Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVECNnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVECNnd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 09:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVECNnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 09:43:32 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:31680 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261524AbVECNnb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 09:43:31 -0400
Date: Mon, 2 May 2005 23:19:39 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, torvalds@osdl.org,
       mingo@elte.hu, linux-kernel@vger.kernel.org, rajesh.shah@intel.com,
       johnstul@us.ibm.com, ak@suse.de, asit.k.mallick@intel.com
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-ID: <20050502211939.GB2390@openzaurus.ucw.cz>
References: <88056F38E9E48644A0F562A38C64FB60049EE97A@scsmsx403.amr.corp.intel.com> <20050429200631.45616043.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429200631.45616043.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >  Is there way to get the all the patches in mm, so that I can try same
> >  Kernel and reproduce this failure?
> 
> I'm reluctant to do that, because the -mm lineup is usually a hysterical
> pile of crap - you wouldn't believe what people send me.  I actually do a
> lot of testing, despite appearances ;)

Actually having -mm tree available in near realtime would be quite nice. I don't
think I'd run it reguraly, and "other patches from you are ..." in commit confirmation
is very usefull, but seeing patches from other people, too, seems interesting.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

