Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbSIROHa>; Wed, 18 Sep 2002 10:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbSIROHa>; Wed, 18 Sep 2002 10:07:30 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:33417 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S266933AbSIROH3>; Wed, 18 Sep 2002 10:07:29 -0400
Subject: Re: [PATCH] BUG(): sched.c: Line 944
From: Steven Cole <elenstev@mesatop.com>
To: Robert Love <rml@tech9.net>
Cc: Ingo Molnar <mingo@elte.hu>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1032324294.4588.758.camel@phantasy>
References: <Pine.LNX.4.44.0209172055550.13829-100000@localhost.localdomain> 
	<1032290611.4592.206.camel@phantasy> 
	<1032292468.11907.44.camel@spc9.esa.lanl.gov> 
	<1032293199.4588.235.camel@phantasy> 
	<1032296284.12257.66.camel@spc9.esa.lanl.gov> 
	<1032324294.4588.758.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 18 Sep 2002 08:08:42 -0600
Message-Id: <1032358122.11913.94.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-09-17 at 22:44, Robert Love wrote:
> On Tue, 2002-09-17 at 16:58, Steven Cole wrote:
> 
> > Sorry, it hung so badly that it didn't respond to that.
> 
> I fixed the hang.  If you notice the problem, please do not laugh.
> 
> The attached patch, against 2.5.36, should work fine...
> 
> 	Robert Love

Thanks.  That works fine here.  Now that I can run with PREEMPT again,
I'll leave it enabled.  It does seem to improve interactive feel under
heavy load, but without an easily identifiable metric for that you know
what Rik would say.

Steven

