Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbTCGWxE>; Fri, 7 Mar 2003 17:53:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbTCGWxE>; Fri, 7 Mar 2003 17:53:04 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:33540 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261837AbTCGWxC>; Fri, 7 Mar 2003 17:53:02 -0500
Message-ID: <3E6925AF.607@aitel.hist.no>
Date: Sat, 08 Mar 2003 00:05:19 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Martin Josefsson <gandalf@wlug.westbo.se>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] "interactivity changes", sched-2.5.64-B2
References: <Pine.LNX.4.44.0303071301500.1933-100000@dlang.diginsite.com> <1047071612.29990.13.camel@tux.rsn.bth.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Josefsson wrote:

> Wouldn't surprise me if it's an X problem... I can't say that I feel
> like going digging into X sources...
> 
> I can get the same problem in sawfish if I press the key a few times
> quite rapidly as well, without any background load at all. This problem
> has never occured before on 2.4 or 2.5, with or without load. It could
> be that the scheduler changes exposes some bug in X but I'm not really
> sure how to start investigating...

You could perhaps rule out sawfish bugs by testing this with
another window manager?

Helge Hafting


