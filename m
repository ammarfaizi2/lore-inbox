Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265403AbTLRXlB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265406AbTLRXlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:41:01 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:7810
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S265403AbTLRXk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:40:59 -0500
Date: Thu, 18 Dec 2003 18:40:11 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Karim Yaghmour <karim@opersys.com>
cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Updating real-time and nanokernel maintainers
In-Reply-To: <3FE23966.7060001@opersys.com>
Message-ID: <Pine.LNX.4.58.0312181836360.19491@montezuma.fsmlabs.com>
References: <3FE234E4.8020500@opersys.com> <Pine.LNX.4.58.0312181821270.19491@montezuma.fsmlabs.com>
 <3FE23966.7060001@opersys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Dec 2003, Karim Yaghmour wrote:

>
> Zwane Mwaikambo wrote:
> > On Thu, 18 Dec 2003, Karim Yaghmour wrote:
> > I'd say take them both out, neither have code in the kernel.
>
> RTLinux has never had code in the kernel, but it still had
> a mention in the maintainers file for quite a number of years.
> I think that these entries are really pointers for those who
> are interested in this area of Linux's use. As such, RTAI is
> the only real free software real-time Linux extension and I
> think it deserves mention. Nowadays, rtlinux.org is only an
> alias for fsmlabs.com, which I think pretty much sums up the
> situation.

But you're forgetting what the MAINTAINERS file is for. I can't but help
thinking that this is linked with the email you sent earlier, but that's
just me. Frankly i reckon this particular case could be settled by
removing both from MAINTAINERS as neither has code in the 2.6 linux
kernel. Anybody looking for realtime Linux kernel capabilities can just do
a Google.

Thanks
