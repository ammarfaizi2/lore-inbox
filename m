Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267466AbTBIWXR>; Sun, 9 Feb 2003 17:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267467AbTBIWXR>; Sun, 9 Feb 2003 17:23:17 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:13171
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267466AbTBIWXR>; Sun, 9 Feb 2003 17:23:17 -0500
Date: Sun, 9 Feb 2003 17:31:58 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Glen Kaukola <glen@earthlink.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Attempted to kill the idle task
In-Reply-To: <200302090500.21193.glen@earthlink.net>
Message-ID: <Pine.LNX.4.50.0302091728140.2812-100000@montezuma.mastecende.com>
References: <200302090500.21193.glen@earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Feb 2003, Glen Kaukola wrote:

> Hi,
> 
> On my Gentoo system, I installed a 2.5.59 kernel, and when I boot it, it tells 
> me this:
> 
> Kernel panic: Attempted to kill the idle task
> In idle task - not syncing
>  Stuck ??
> CPU #1 not responding - cannot use it
> 
> But then it goes ahead and boots anyway, and I just have one cpu missing from 
> programs like top.  My system is a supermicro P4DC6+ motherboard with two 2.2 
> Ghz pentium 4 xeons.  I've attached the output of dmesg.  If you need 
> anything else from me that would be of help then let me know.

Please decode that oops on the system after it has booted. or perhaps even 
turn on CONFIG_KALLSYMS. Does it boot 2.5.59-vanilla fine? or even with 
http://www.kernel.org/pub/linux/kernel/v2.5/snapshots/patch-2.5.59-bk3.bz2?

	Zwane
-- 
function.linuxpower.ca
