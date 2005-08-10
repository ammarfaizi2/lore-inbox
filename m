Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbVHJStH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbVHJStH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbVHJStH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:49:07 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:29451 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S965257AbVHJStG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:49:06 -0400
Message-ID: <42FA4C45.1020304@tmr.com>
Date: Wed, 10 Aug 2005 14:49:41 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Crilly <jim@why.dont.jablowme.net>
CC: James Bruce <bruce@andrew.cmu.edu>, Lee Revell <rlrevell@joe-job.com>,
       Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu> <20050731211020.GB27433@elf.ucw.cz> <20050731220754.GE7362@voodoo>
In-Reply-To: <20050731220754.GE7362@voodoo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Crilly wrote:
> On 07/31/05 11:10:20PM +0200, Pavel Machek wrote:
> 
>>>I really like having 250HZ as an _option_, but what I don't see is why 
>>>it should be the _default_.  I believe this is Lee's position as
>>>Last I checked, ACPI and CPU speed scaling were not enabled by default; 
>>
>>Kernel defaults are irelevant; distros change them anyway. [But we
>>probably want to enable ACPI and cpufreq by default, because that
>>matches what 99% of users will use.]
>>
> 
> 
> If the kernel defaults are irrelevant, then it would make more sense to
> leave the default HZ as 1000 and not to enable the cpufreq and ACPI in
> order to keep with the principle of least surprise for people who do use
> kernel.org kernels.
> 
> Jim.

Thank you Jim, Plauger's "law of least astonishment."

