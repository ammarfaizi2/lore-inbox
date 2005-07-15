Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbVGOTYV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVGOTYV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbVGOTYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:24:21 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:44029 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261179AbVGOTYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:24:10 -0400
Date: Fri, 15 Jul 2005 14:24:05 -0500
From: Lee <linuxtwidler@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Bug Report
Message-ID: <20050715142405.0117dc21@localhost>
In-Reply-To: <1121455191.12420.40.camel@mindpipe>
References: <20050715140411.28a30e55@localhost>
	<1121455191.12420.40.camel@mindpipe>
Reply-To: linuxtwidler@gmail.com
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > [20975.978911] PREEMPT SMP DEBUG_PAGEALLOC
> > [20976.029194] Modules linked in: vmnet vmmon nvidia
> > [20976.090907] CPU:    695757158
> > [20976.090909] EIP:    0060:[<c0119ed8>]    Tainted: P      VLI
>
> Please reproduce the bug without these proprietary modules loaded.  And
> make sure to include the stack trace.

My current setup has the kernel and metalog logging to the serial port, which I am monitoring using kermit rom another machine.

Would you mind explaining to me how to generate the strace track and/or how to do "proper" debugging when this crash occurs?

ATM, the machine writes the report to the serial console, and completely freezes.  I imagine that gdb would be involved here, but Im not sure how to go about setting that up.



-- 
Lee
linuxtwidler@gmail.com

 14:21:30 up  5:40,  0 users,  load average: 0.29, 0.20, 0.10
