Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262416AbTJXQ7s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 12:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbTJXQ7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 12:59:48 -0400
Received: from smtp2.libero.it ([193.70.192.52]:5785 "EHLO smtp2.libero.it")
	by vger.kernel.org with ESMTP id S262416AbTJXQ7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 12:59:44 -0400
Date: Fri, 24 Oct 2003 18:55:53 +0200
From: "M. Fioretti" <m.fioretti@inwind.it>
To: linux-kernel@vger.kernel.org
Subject: Re: Unbloating the kernel, was: :mem=16MB laptop testing
Message-ID: <20031024165553.GB933@inwind.it>
Reply-To: "M. Fioretti" <m.fioretti@inwind.it>
References: <HMQWM7$61FA432C2B793029C11F4F77EEAABD1F@libero.it> <Pine.LNX.4.44.0310140917540.3754-100000@chimarrao.boston.redhat.com> <20031014143047.GA6332@ncsu.edu> <3F8CE3EB.8040907@storm.ca> <bnbi95$3qn$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnbi95$3qn$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 15:59:33 at 03:59:33PM +0000, bill davidsen (davidsen@tmr.com) wrote:

> | > If we can ensure that Linux keeps working on these machines, it
> | > will be a good thing.
> 
> Agreed, until you start to talk cluster. If you pay for electricity,
> newer machines use less per MHz. One of those $200 "Lindows" boxen
> from Wal-Mart starts to look good about the 2nd old Pentium!

May I ask you to elaborate on this? Less per MHz doesn't matter much
if the frequency is much higher, or it does? I mean, if you put, say,
a 133 MHz pentium and a 1 GB pentium to do the same thing with the
same SW (mail server, for example), the 1GB system may use less per
MHz (newer silicon, lower voltage, etc...) and its flip-flops toggle
for a smaller percentage of time, but its electricity bill will still
be the higher one, or not?

In general: has anybody ever done *this* kind of benchmarks? Comparing
electricity consumption among different systems doing just the same
task?

TIA,
	Marco Fioretti

-- 
Marco Fioretti                 m.fioretti, at the server inwind.it
Red Hat for low memory         http://www.rule-project.org/en/

A good man is intelligent, and a bad man is also an idiot. Moral and
intellectual characteristics go together - Jorge Luis Borges

