Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWJWUlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWJWUlJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 16:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbWJWUlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 16:41:09 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:61615 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751274AbWJWUlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 16:41:07 -0400
Subject: Re: -rt7 announcement? (was Re: 2.6.18-rt6)
From: Lee Revell <rlrevell@joe-job.com>
To: sergio@sergiomb.no-ip.org
Cc: tglx@linutronix.de, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>, Mike Galbraith <efault@gmx.de>,
       Daniel Walker <dwalker@mvista.com>,
       Manish Lachwani <mlachwani@mvista.com>, bastien.dugue@bull.net
In-Reply-To: <1161635161.2948.12.camel@localhost.portugal>
References: <20061018083921.GA10993@elte.hu>
	 <1161356444.15860.327.camel@mindpipe>  <1161621286.2835.3.camel@mindpipe>
	 <1161628539.22373.36.camel@localhost.localdomain>
	 <1161635161.2948.12.camel@localhost.portugal>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 16:40:49 -0400
Message-Id: <1161636049.3982.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 21:26 +0100, Sergio Monteiro Basto wrote:
> rt7 should be to be applied on 2.6.18.1 
> still for 2.6.18 
> 

The -rt patch has always been against the most recent base kernel.  It
could be rebased against -stable but that would be more work for the
maintainers...

Lee

