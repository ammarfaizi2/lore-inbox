Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290829AbSARVRB>; Fri, 18 Jan 2002 16:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290824AbSARVQx>; Fri, 18 Jan 2002 16:16:53 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.1.197.194]:12520 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S290827AbSARVQZ>;
	Fri, 18 Jan 2002 16:16:25 -0500
Message-ID: <3C4890A0.3050505@candelatech.com>
Date: Fri, 18 Jan 2002 14:16:16 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tulip driver bug in 2.4.17 (fwd)
In-Reply-To: <Pine.LNX.4.40.0201181251310.27656-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Lang wrote:

> On Fri, 18 Jan 2002, Ben Greear wrote:
> 
> 
>>It might also be interesting to see if the working driver still works
>>if you forward port it into 2.4.17....
>>
>>
> 
> I copied the drivers/net directory from 2.4.4 (tulip driver 0.4.14e) and
> it results in the same lockup on 2.4.17 as the new driver.
> 
> what can I do to turn on more logging here?
> 
> David Lang


Maybe some very verbose PCI debug info??



-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


