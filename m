Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261550AbSJURGA>; Mon, 21 Oct 2002 13:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261541AbSJURGA>; Mon, 21 Oct 2002 13:06:00 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8856 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261550AbSJURFu>;
	Mon, 21 Oct 2002 13:05:50 -0400
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@muc.de>
Cc: Andrea Arcangeli <andrea@suse.de>, Jeff Dike <jdike@karaya.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>
In-Reply-To: <20021019044556.GA22201@averell>
References: <20021019031002.GA16404@averell>
	<200210190450.XAA06161@ccure.karaya.com>
	<20021019041019.GI23930@dualathlon.random>  <20021019044556.GA22201@averell>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Oct 2002 10:10:33 -0700
Message-Id: <1035220236.26332.10.camel@laptop.cornchips.homelinux.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-18 at 21:45, Andi Kleen wrote:
> For the locked TSC code we will need something like that anyways,
> so that locked TSC can force a syscall.

Andi, 

Can you further explain what this locked TSC issue is that you're
mentioning (this is why vsyscalls are disabled in x86-64, right?). I'm
not sure I'm following you completely. I apologize if I'm just being
daft.

thanks
-john

