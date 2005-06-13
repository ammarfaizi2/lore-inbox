Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbVFMBCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbVFMBCk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 21:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVFMBCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 21:02:40 -0400
Received: from opersys.com ([64.40.108.71]:39430 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261301AbVFMBCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 21:02:38 -0400
Message-ID: <42ACDD92.60408@opersys.com>
Date: Sun, 12 Jun 2005 21:12:50 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: randy_dunlap <rdunlap@xenotime.net>
CC: Sven-Thorsten Dietrich <sdietrich@mvista.com>, andrea@suse.de,
       mingo@elte.hu, kbenoit@opersys.com, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, tglx@linutronix.de,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, nickpiggin@yahoo.com.au,
       ak@muc.de, dwalker@mvista.com, hch@infradead.org, akpm@osdl.org,
       rpm@xenomai.org
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
References: <42AA6A6B.5040907@opersys.com>	<20050611191448.GA24152@elte.hu>	<42AB662B.4010104@opersys.com>	<20050612222011.GG5796@g5.random>	<1118617421.12889.71.camel@sdietrich-xp.vilm.net> <20050612175317.1fa416e6.rdunlap@xenotime.net>
In-Reply-To: <20050612175317.1fa416e6.rdunlap@xenotime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


randy_dunlap wrote:
> Wouldn't the company's attorney/lawyer/counsel be considered too?
> After all, in-kernel would likely have some legal ramifications...

Sure, but I guess what Sven is trying to say here is that this
stuff is done in kernel-space for benchmarking purposes. How
it's actually used later (user-space vs. kernel-space) is a
separate issue.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
