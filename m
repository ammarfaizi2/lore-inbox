Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVFKOSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVFKOSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 10:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVFKOSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 10:18:09 -0400
Received: from opersys.com ([64.40.108.71]:1028 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261705AbVFKOSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 10:18:04 -0400
Subject: Re: PREEMPT_RT vs ADEOS: the numbers, part 1
From: Kristian Benoit <kbenoit@opersys.com>
To: Sven-Thorsten Dietrich <sdietrich@mvista.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com, bhuey@lnxw.com, andrea@suse.de, tglx@linutronix.de,
       Karim Yaghmour <karim@opersys.com>, mingo@elte.hu,
       pmarques@grupopie.com, bruce@andrew.cmu.edu, ak@muc.de,
       dwalker@mvista.com, hch@infradead.org, akpm@osdl.org, rpm@xenomai.org
In-Reply-To: <1118481315.9519.39.camel@sdietrich-xp.vilm.net>
References: <42AA6A6B.5040907@opersys.com>  <42AA812D.2060701@yahoo.com.au>
	 <1118481315.9519.39.camel@sdietrich-xp.vilm.net>
Content-Type: text/plain
Date: Sat, 11 Jun 2005 10:15:55 -0400
Message-Id: <1118499356.5786.16.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-11 at 02:15 -0700, Sven-Thorsten Dietrich wrote:
> Its a good start, and its excellent that its being looked at. Thank
> you
> guys very much for taking the time to compare these 2 very different
> systems. 

Youre welcome !

> I think the comparison should absolutely compare identical community
> kernels. The comparison between two different release candidates is
> questionable. rc2 to rc4 doesn't seem like much, after all, how much
> code could go into a release candidate. (diff | wc -l) 

I agree with that, but as the results show, there does'nt seems to be
much difference impact the numbers in the tested field.

> Also, I question testing -rc code in the first place, except for
> regression purposes. 

I tested the -rc code in orther to be able to compare the patched
kernels against theird own source.

> How does that effort compare for porting ADEOS code? If several weeks
> of
> work are invested in a comparison of rc2 to rc4, how much additional
> work is needed to bring Adeos up to the base for the current RT
> kernel?

Philippe, I think that question is youre !

Kristian

