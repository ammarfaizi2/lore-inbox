Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269739AbRHII4q>; Thu, 9 Aug 2001 04:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269740AbRHII4g>; Thu, 9 Aug 2001 04:56:36 -0400
Received: from www.grips.com ([62.144.214.31]:27153 "EHLO grips_nts2.grips.com")
	by vger.kernel.org with ESMTP id <S269739AbRHII4Z>;
	Thu, 9 Aug 2001 04:56:25 -0400
Message-ID: <3B72510C.2020503@grips.com>
Date: Thu, 09 Aug 2001 10:59:56 +0200
From: gjury <gjury@grips.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010803
X-Accept-Language: de-at, en
MIME-Version: 1.0
To: Mark Hahn <hahn@physics.mcmaster.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Athlon/MSI mobo combo broken?
In-Reply-To: <Pine.LNX.4.10.10108082057430.10284-100000@coffee.psychology.mcmaster.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I did not say chipset at all.
You seem to miss the fact, that >= 40 % of the SDRAM modules are not 
even close to the spec.
The german magazin ct can sing a song about it. http://www.heise.de/ct
Software has nothing to do with this.
The windows installation on my PC suffert from the same effects.
It was just harder to spot there below ... .
Every memory tester i tried was showing no problems at all.
It may be triggered more likely or not, but bad SDRAM cannot be fixed in 
software.
Thats my own only plausible theory.

regards
gerold

Mark Hahn wrote:

>>If you have PC100 SDRAM try to replace it with PC133.
>>
>
>ugh, this is the same (mistaken) approach as turning off CONFIG_MK7:
>cripple performance enough that your system works.  turning off 
>CONFIG_MK7 disables Arjan's nice code in mmx.c which delivers 
>2-4x the copy/zero-page bandwidth...
>
>there *are* stable via/athlon systems, and that indicates that the 
>problem is not inherent to the chipset.  I have a gigabyte ga-7zx,
>duron/600, pc133 system that has always been rock-solid.  and I 
>recently built an Asus a7v-133, tbird/1199, pc133 system that is
>also entirely stable.  both run cas2 pc133, CONFIG_MK7 kernels, etc.
>both have fairly generous power supplies.
>
>so far, the only plausible theory is that some individual factor(s)
>(MB, bios settings, power quality, dram quality, etc) causes 
>the instability that some people report.
>
>regards, mark hahn.
>


