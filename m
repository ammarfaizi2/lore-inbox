Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbVCYWlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbVCYWlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 17:41:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVCYWhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 17:37:55 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20203 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261864AbVCYWdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 17:33:32 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-10
From: Lee Revell <rlrevell@joe-job.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>
In-Reply-To: <20050325145908.GA7146@elte.hu>
References: <20050325145908.GA7146@elte.hu>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 17:33:28 -0500
Message-Id: <1111790009.23430.19.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-03-25 at 15:59 +0100, Ingo Molnar wrote:
> i have released the -V0.7.41-10 Real-Time Preemption patch, which can be 
> downloaded from the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/

I get zillions of "return type defaults to int" warnings trying to
compile this with PREEMPT_DESKTOP.

Lee

