Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbUJ0Xmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbUJ0Xmo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbUJ0XiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 19:38:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:64976 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262683AbUJ0ULb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 16:11:31 -0400
Date: Wed, 27 Oct 2004 13:09:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: rlrevell@joe-job.com, kr@cybsft.com, linux-kernel@vger.kernel.org,
       rncbc@rncbc.org, Mark_H_Johnson@Raytheon.com, bhuey@lnxw.com,
       doogie@debian.org, mista.tapas@gmx.net, tglx@linutronix.de,
       xschmi00@stud.feec.vutbr.cz, nando@ccrma.Stanford.EDU
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Message-Id: <20041027130919.1a1175f5.akpm@osdl.org>
In-Reply-To: <20041027151701.GA11736@elte.hu>
References: <20041025104023.GA1960@elte.hu>
	<417D4B5E.4010509@cybsft.com>
	<20041025203807.GB27865@elte.hu>
	<417E2CB7.4090608@cybsft.com>
	<20041027002455.GC31852@elte.hu>
	<417F16BB.3030300@cybsft.com>
	<20041027132926.GA7171@elte.hu>
	<417FB7F0.4070300@cybsft.com>
	<20041027150548.GA11233@elte.hu>
	<1098889994.1448.14.camel@krustophenia.net>
	<20041027151701.GA11736@elte.hu>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> > Here is a more up to date version of the rtc-debug patch:
>  > 
>  > http://lkml.org/lkml/2004/9/9/307
>  > 
>  > There is still a bit of 2.4 cruft in there but it works well.  Maybe
>  > this could be included in future patches.
> 
>  the most natural point of inclusion would be Andrew's -mm tree i think
>  :-)

It's 'orrid.  And iirc it breaks normal use of the RTC.
