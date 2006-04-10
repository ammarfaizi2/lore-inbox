Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWDJGy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWDJGy2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 02:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWDJGy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 02:54:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50138 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751045AbWDJGy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 02:54:27 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH rc1-mm 0/3] coredump: rfc
In-Reply-To: Oleg Nesterov's message of  Sunday, 9 April 2006 04:11:00 +0400 <20060409001059.GA95@oleg>
X-Windows: the first fully modular software disaster.
Message-Id: <20060410065422.881CE1809CB@magilla.sf.frob.com>
Date: Sun,  9 Apr 2006 23:54:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am unsure about this series. It adds some optimizations, but
> complicates the code.
> 
> So I am asking for yours opinion not only about correctness, but
> also about usefulness.

I think the optimizations are worthwhile, and with continuing cleanup we
can keep the complexity under control.  


Thanks,
Roland
