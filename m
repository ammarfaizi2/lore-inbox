Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317536AbSHHNQI>; Thu, 8 Aug 2002 09:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317559AbSHHNQI>; Thu, 8 Aug 2002 09:16:08 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:60142 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S317536AbSHHNQH>; Thu, 8 Aug 2002 09:16:07 -0400
Message-ID: <3D52701E.2050500@snapgear.com>
Date: Thu, 08 Aug 2002 23:20:30 +1000
From: gerg <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.0.0) Gecko/20020530
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Amol Lad <dal_loma@yahoo.com>
Subject: Re: uclinux on MMU platforms - query
References: <3D50B42B.8000200@snapgear.com> <1028719830.18156.238.camel@irongate.swansea.linux.org.uk> <3D51BC64.4030704@snapgear.com> <20020808114244.GX259@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Weinehall wrote:
> On Thu, Aug 08, 2002 at 10:33:40AM +1000, Greg Ungerer wrote:
>>Alan Cox wrote:
>>
>>>On Wed, 2002-08-07 at 06:46, Greg Ungerer wrote:
>>>
>>>
>>>>> Can I run uClinux on platforms that has MMU
>>>>
>>>>You could, but why would you want to?
>>>
>>>
>>>Being able to run true ucLinux on i386 makes debugging and verification
>>>of software so much less painful sometimes. 
>>
>>For some things yes. But it is a real pain trying to track
>>down memory corruption and stack overflow problems in
>>applications. They have a tendency to take your the whole system...
> 
> 
> Wouldn't an ucLinux-version of uml be a good idea? :-)

Yeah :-)

We sort of have better than that now. There are quite a few
emulators that run under standard Linux that will quite happliy
run uClinux. There is xcopilot (m68328), coldfire (5206),
ARMulator (ARM), tsim (SPARC leon) and or1ksim (OPENcores OR1000).
I am sure there is more!

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
Snapgear Pty Ltd                               PHONE:    +61 7 3279 1822
825 Stanley St,                                  FAX:    +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

