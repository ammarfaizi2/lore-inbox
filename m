Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbTCCRlZ>; Mon, 3 Mar 2003 12:41:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265396AbTCCRlZ>; Mon, 3 Mar 2003 12:41:25 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:2331
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265373AbTCCRlY>; Mon, 3 Mar 2003 12:41:24 -0500
Date: Mon, 3 Mar 2003 12:49:18 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: ChristopherHuhn <c.huhn@gsi.de>
cc: root@chaos.analogic.com, "" <linux-kernel@vger.kernel.org>,
       linux-smp <linux-smp@vger.kernel.org>, "" <support-gsi@credativ.de>
Subject: Re: Kernel Bug at spinlock.h ?!
In-Reply-To: <3E637CDC.3030409@GSI.de>
Message-ID: <Pine.LNX.4.50.0303031248220.29455-100000@montezuma.mastecende.com>
References: <Pine.LNX.3.95.1030303103332.22802A-100000@chaos> <3E637CDC.3030409@GSI.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Mar 2003, ChristopherHuhn wrote:

> Feb 27 20:51:37 lxb039 kernel: Unable to handle kernel NULL pointer 
> dereference at virtual address 00000000
> Feb 27 20:51:37 lxb039 kernel:  printing eip:
> Feb 27 20:51:37 lxb039 kernel: 00000000
> Feb 27 20:51:38 lxb039 kernel: Code:  Bad EIP value.
> 
> 
> Looks like a NFS problem, huh?

Is that absolutely the first oops? Looks valid, could you, if possible, 
try running a newer 2.4 and we can debug from there.

Cheers,
	Zwane
-- 
function.linuxpower.ca
