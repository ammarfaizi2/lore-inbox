Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261374AbTCaCpf>; Sun, 30 Mar 2003 21:45:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbTCaCpf>; Sun, 30 Mar 2003 21:45:35 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:35838
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261374AbTCaCpf>; Sun, 30 Mar 2003 21:45:35 -0500
Date: Sun, 30 Mar 2003 21:52:58 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Shawn Starr <spstarr@sh0n.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PANIC][2.5.66bk3+] run_timer_softirq - IRQ Mishandlings
In-Reply-To: <001c01c2f634$2e517da0$030aa8c0@unknown>
Message-ID: <Pine.LNX.4.50.0303302151020.14277-100000@montezuma.mastecende.com>
References: <001c01c2f634$2e517da0$030aa8c0@unknown>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Mar 2003, Shawn Starr wrote:

> Code: 89 50 04 89 02 c7 43 30 00 00 00 00 81 3d c0 8b 41 c0 3c 4b
>  <0>Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
>  kernel/timer.c:251: spin_lock(kernel/timer.c:c0418bc0) already locked by
> kernel/timer.
> c/389
> 
> ksymoops zwane debugged showed garbage, also poisioned ('6b').

Huh ?

-- 
function.linuxpower.ca
