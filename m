Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131126AbRAaTac>; Wed, 31 Jan 2001 14:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131208AbRAaTaT>; Wed, 31 Jan 2001 14:30:19 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:55317 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S131126AbRAaTaH>; Wed, 31 Jan 2001 14:30:07 -0500
Message-ID: <3A786758.E607E63D@sgi.com>
Date: Wed, 31 Jan 2001 11:28:24 -0800
From: LA Walsh <law@sgi.com>
Organization: Trust Technology, SGI
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Rainer Wiener <rainer@konqui.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: seti@home and es1371
In-Reply-To: <20010131171130.A1664@mulder.konqui.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try "freeamp".  It uses darn close to 0 CPU and may not be affected by setiathome.
2nd -- renice setiathome to '19' -- you only want it to use up 'background' cputime
	anyway



Rainer Wiener wrote:
> 
> Hi,
> 
> I hope you can help me. I have a problem with my on board soundcard and
> seti. I have a Gigabyte GA-7ZX Creative 5880 sound chip. I use the kernel
> driver es1371 and it works goot. But when I run seti@home I got some noise
> in my sound when I play mp3 and other sound. But it is not every time 10s
> play good than for 2 s bad and than 10s good 2s bad and so on. When I kill
> seti@home every thing is ok. So what can I do?
> 
> I have a Athlon 800 Mhz and 128 MB RAM

-- 
Linda A Walsh                    | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
