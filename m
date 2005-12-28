Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbVL1SYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbVL1SYZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 13:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVL1SYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 13:24:24 -0500
Received: from mxsf01.cluster1.charter.net ([209.225.28.201]:23446 "EHLO
	mxsf01.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S964863AbVL1SYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 13:24:24 -0500
X-IronPort-AV: i="3.99,304,1131339600"; 
   d="scan'208"; a="1664132363:sNHT33819412"
Message-ID: <43B2D7A5.2080906@cybsft.com>
Date: Wed, 28 Dec 2005 12:21:25 -0600
From: "K.R. Foley" <kr@cybsft.com>
Organization: Cybersoft Solutions, Inc.
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.15-rc7-rt1
References: <20051228172643.GA26741@elte.hu>
In-Reply-To: <20051228172643.GA26741@elte.hu>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i have released the 2.6.15-rc7-rt1 tree, which can be downloaded from 
> the usual place:
> 
>    http://redhat.com/~mingo/realtime-preempt/
> 
> this release mainly includes fixes from Steven Rostedt, for various 
> problems with -rc5-rt4 - while i'm over in mutex-land ;)
> 
> Please re-report any bugs that remain.

This one got all of the outstanding issues that I had run into thus far
with previous patches. Compiled and booted on the old dual 933.

> 
> to build a 2.6.15-rc7-rt1 tree, the following patches should be applied:
> 
>   http://kernel.org/pub/linux/kernel/v2.6/linux-2.6.14.tar.bz2
>   http://kernel.org/pub/linux/kernel/v2.6/testing/patch-2.6.15-rc7.bz2
>   http://redhat.com/~mingo/realtime-preempt/patch-2.6.15-rc7-rt1
> 
> 	Ingo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
   kr
