Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319274AbSIKSsP>; Wed, 11 Sep 2002 14:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319275AbSIKSsO>; Wed, 11 Sep 2002 14:48:14 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:58639
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319274AbSIKSsO>; Wed, 11 Sep 2002 14:48:14 -0400
Subject: Re: [PATCH] Read-Copy Update 2.5.34
From: Robert Love <rml@tech9.net>
To: dipankar@in.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@transmeta.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Andrea Arcangeli <andrea@suse.de>,
       Paul McKenney <paul.mckenney@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020911195939.E28198@in.ibm.com>
References: <20020911164940.C28198@in.ibm.com>
	<Pine.LNX.4.44.0209111323360.12332-100000@localhost.localdomain>
	<20020911175011.D28198@in.ibm.com> <1031753011.950.106.camel@phantasy> 
	<20020911195939.E28198@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 11 Sep 2002 14:52:46 -0400
Message-Id: <1031770371.4693.113.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-11 at 10:29, Dipankar Sarma wrote:

> Sorry, I should have been more careful labelling them - those are 2.5.34-preempt
> vs 2.5.34-preempt-rcu numbers. I did them first because rcu-poll-preempt
> kernel has a conditinal branch in fast path and hence more interesting. 
> I will publish the vanilla vs rcu_poll reflex numbers in a few minutes 
> from now.

Ahh OK.  Results are OK, then - thanks :-)


> Our OLS paper and presentation too deals with preemption -
> 
> http://www.rdrop.com/users/paulmck/rclock/rcu.2002.07.08.pdf
> http://www.rdrop.com/users/paulmck/rclock/rclock.OLS.2002.07.08a.pdf

Yep.  Was there, saw the talk, got the t-shirt.

	Robert Love

