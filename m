Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262036AbTJJT4C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 15:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262062AbTJJT4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 15:56:02 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:29315 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S262036AbTJJT4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 15:56:00 -0400
Subject: Re: [2.6.0-test7] cpufreq longhaul trouble
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031010193434.GJ25856@redhat.com>
References: <1065784536.2071.3.camel@paragon.slim>
	 <20031010184241.GC32600@redhat.com> <1065813288.1861.4.camel@paragon.slim>
	 <20031010193434.GJ25856@redhat.com>
Content-Type: text/plain
Message-Id: <1065815651.1904.4.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-3) 
Date: Fri, 10 Oct 2003 21:54:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-10-10 at 21:34, Dave Jones wrote:
> On Fri, Oct 10, 2003 at 09:14:48PM +0200, Jurgen Kramer wrote:
>  > Some more details. Although this is an 800MHz CPU
>  > /sys/devices/system/cpu/cpu0/cpufreq gives:
>  > 
>  > [root@paradox cpufreq]# more *
>  > ::::::::::::::
>  > cpuinfo_max_freq
>  > ::::::::::::::
>  > 995
> 
> wtf, it still displays "Highestspeed=798MHz" on startup though right ?
> 
> 		Dave
Yep,

longhaul: VIA C3 'Ezra' [C5C] CPU detected. Longhaul v1 supported.
longhaul: MinMult=3.0x MaxMult=6.0x
longhaul: FSB: 133MHz Lowestspeed=399MHz Highestspeed=798MHz

With 2.4 I could choose 3 different speeds once (around Sept 
2002)...currently only two speeds are available, 400 and 800.

Jurgen


