Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932408AbVLUNd5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932408AbVLUNd5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932409AbVLUNd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:33:57 -0500
Received: from pop-siberian.atl.sa.earthlink.net ([207.69.195.71]:22519 "EHLO
	pop-siberian.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S932408AbVLUNd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:33:57 -0500
Message-ID: <43A958CF.2080908@earthlink.net>
Date: Wed, 21 Dec 2005 08:29:51 -0500
From: Stephen Clark <stephen.clark@earthlink.net>
Reply-To: sclark46@earthlink.net
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16-22smp i686; en-US; m18) Gecko/20010110 Netscape6/6.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Linus Torvalds <torvalds@osdl.org>,
       James Courtier-Dutton <James@superbug.co.uk>,
       Adrian Bunk <bunk@stusta.de>, Sergey Vlasov <vsu@altlinux.ru>,
       Ricardo Cerqueira <v4l@cerqueira.org>, mchehab@brturbo.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com, perex@suse.cz, alsa-devel@alsa-project.org
Subject: Re: [Alsa-devel] 2.6.15-rc6: boot failure in saa7134-alsa.c
References: <Pine.LNX.4.64.0512181641580.4827@g5.osdl.org>	 <20051220131810.GB6789@stusta.de>	 <20051220155216.GA19797@master.mivlgu.local>	 <Pine.LNX.4.64.0512201018000.4827@g5.osdl.org>	 <20051220191412.GA4578@stusta.de>	 <Pine.LNX.4.64.0512201156250.4827@g5.osdl.org>	 <43A86B20.1090104@superbug.co.uk>	 <Pine.LNX.4.64.0512201248481.4827@g5.osdl.org> <1135117067.27101.5.camel@mindpipe>
In-Reply-To: <1135117067.27101.5.camel@mindpipe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:

>On Tue, 2005-12-20 at 13:03 -0800, Linus Torvalds wrote:
>  
>
>>Forcing (or even just encouraging) people to use loadable modules is
>>just horrible. I personally run a kernel with no modules at all: it
>>makes for a simpler bootup, and in some situations (embedded) it has
>>both security and size advantages. 
>>    
>>
>
>With modules it's possible to test a new ALSA version without
>recompiling the kernel or even rebooting.  Encouraging people to build
>it into the kernel would create a problematic barrier to entry for
>debugging.  With the amount of poorly documented hardware we support,
>it's essential for preventing driver regressions for users to be able to
>easily test the latest ALSA version.  
>
>Lee
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>
Users don't want to be testers when they report problems and no on 
responds to the problem
report!

My $.02
Steve
