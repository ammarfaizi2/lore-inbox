Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTEUWaJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 18:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTEUWaJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 18:30:09 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:64067 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262284AbTEUWaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 18:30:08 -0400
Date: Wed, 21 May 2003 15:41:41 -0700
From: Andrew Morton <akpm@digeo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: must-fix list, v5
Message-Id: <20030521154141.2ede1e91.akpm@digeo.com>
In-Reply-To: <20030521152255.4aa32fba.akpm@digeo.com>
References: <20030521152255.4aa32fba.akpm@digeo.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2003 22:43:10.0732 (UTC) FILETIME=[5B1384C0:01C31FEA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@digeo.com> wrote:
>
>  o O(1) scheduler starvation, poor behaviour seems unresolved.
>  
>    Jens: "I've been running 2.5.67-mm3 on my workstation for two days, and
>    it still doesn't feel as good as 2.4.  It's not a disaster like some
>    revisisons ago, but it still has occasional CPU "stalls" where it feels
>    like a process waits for half a second of so for CPU time.  That's is very
>    noticable."
>  
>     Also see Mike Galbraith's work.
>  
>    Conclusion: the scheduler has issues, lots of people working on it.  Rick
>    Lindsley, Andrew Theurer.

Actually this part should have been deleted.

There have been a lot of sporadic CPU scheduler problem reports and a lot
of fixes, some in just the past day or two.

So apart from David MT's discoveries we shall be wiping the slate clean and
awaiting new reports.

