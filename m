Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263948AbTCUT4m>; Fri, 21 Mar 2003 14:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263944AbTCUTzg>; Fri, 21 Mar 2003 14:55:36 -0500
Received: from magic-mail.adaptec.com ([208.236.45.100]:18313 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S263940AbTCUTzG>; Fri, 21 Mar 2003 14:55:06 -0500
Date: Fri, 21 Mar 2003 13:05:12 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Jos Hulzink <josh@stack.nl>, Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: aic7(censored) dying horribly in 2.5.65-mm2 (fwd)
Message-ID: <418110000.1048277112@aslan.btc.adaptec.com>
In-Reply-To: <200303211243.31104.josh@stack.nl>
References: <Pine.LNX.4.50.0303210217370.2133-100000@montezuma.mastecende.com> <200303211243.31104.josh@stack.nl>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi
> 
> Similar issues here., though I must say the Adaptec driver hasn't worked for 
> me on all kernels I tried since my first try with 2.5.44. I get almost the 
> same output with a plain 2.5.65 kernel, though my kernel locks up just before 
> the crash you get, I get no dmesg output.
> 
> Note that it takes ages to get trough the SCSI driver towards the lockup. I 
> guess some timeouts cause this.

What kind of MB are you using?  It sounds like interrupts aren't working
for you.

--
Justin

