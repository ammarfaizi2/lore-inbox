Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbUJXV5l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbUJXV5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 17:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUJXV5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 17:57:40 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:2312 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261598AbUJXV5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 17:57:36 -0400
Date: Sun, 24 Oct 2004 14:52:24 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jon Masters <jonathan@jonmasters.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, karim@opersys.com
Subject: Re: [RFC][PATCH] Restricted hard realtime
Message-ID: <20041024215224.GB1258@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041023194721.GB1268@us.ibm.com> <1098562921.3306.182.camel@thomas> <20041023212421.GF1267@us.ibm.com> <35fb2e5904102315066c6892aa@mail.gmail.com> <20041024153204.GA1262@us.ibm.com> <417C19D5.7050802@jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417C19D5.7050802@jonmasters.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 10:08:37PM +0100, Jon Masters wrote:
> | So, again, if there was a way to make this approach work on
> | single-threaded single core CPUs, would that be of interest?
> 
> I guess it would. But then we've just had a slew of RT implementations
> crawl out of the woodwork and wave at us over the past few weeks and
> there are three other major RT implementations which combine Linux with
> a Microkernel or other external support (RTLinux, RTAI, KURT, etc.).
> Perhaps it's worth working on one of the Linux patch projects
> (Monta/Ingo/etc.) rather than going all out to implement it all again.

Fair enough!

						Thanx, Paul
