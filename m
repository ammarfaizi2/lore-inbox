Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbUKDT1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbUKDT1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 14:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262317AbUKDTZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 14:25:32 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:18308 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262372AbUKDTVT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 14:21:19 -0500
Message-ID: <418A81D8.5050605@tmr.com>
Date: Thu, 04 Nov 2004 14:24:08 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: gheskett@wdtv.com
CC: linux-kernel@vger.kernel.org, Valdis.Kletnieks@vt.edu,
       DervishD <lkml@dervishd.net>,
       =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411031933.iA3JXfAL020148@turing-police.cc.vt.edu><200411031933.iA3JXfAL020148@turing-police.cc.vt.edu> <200411031509.50740.gheskett@wdtv.com>
In-Reply-To: <200411031509.50740.gheskett@wdtv.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> On Wednesday 03 November 2004 14:33, Valdis.Kletnieks@vt.edu wrote:
> 
>>On Wed, 03 Nov 2004 14:26:23 EST, Gene Heskett said:
>>
>>>Well, since the "device", a bt878 based Haupagge tv card is
>>>sitting in a pci socket, thats even more drastic than a reboot.
>>
>>Not if you have a good hot-swap PCI cage. ;)
>>
>>Anyhow, that points even more at a driver issue for the bt878 -
>>if you can get Sysrq-T output, where does it say the hung process is
>>inside the kernel?
> 
> 
> Thats another thing I've had compiled in since forever, but it so 
> seldom actually *works*, I've tended to forget about it.
> 
You have it enabled as well as compiled in, I'm sure.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
