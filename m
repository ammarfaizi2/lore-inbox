Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266640AbUBFXUw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266988AbUBFXUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:20:51 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:3248 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266640AbUBFXUZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:20:25 -0500
Date: Sat, 7 Feb 2004 00:17:56 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Michael Neuffer <neuffer@neuffer.info>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, shuchen@realtek.com.tw
Subject: Re: of 2.6.2-rc2-mm2 and r8169
Message-ID: <20040207001756.A26645@electric-eye.fr.zoreil.com>
References: <20040130014108.09c964fd.akpm@osdl.org> <20040201100340.GA12436@neuffer.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040201100340.GA12436@neuffer.info>; from neuffer@neuffer.info on Sun, Feb 01, 2004 at 11:03:40AM +0100
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Neuffer <neuffer@neuffer.info> :
[...]
> After many tests I was finally able to capture an Oops:
> Oops: 0000 [#1]
> PREEMPT

If you need to see it work better, I would suggest to disable PREEMPT/SMP.

Could you send me the faulty r8169.o module off-list as well as an lsmod, an
output of the /proc/interrupts and a dmesg from boot ?

--
Ueimor
