Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSBRVSc>; Mon, 18 Feb 2002 16:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286590AbSBRVSW>; Mon, 18 Feb 2002 16:18:22 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:57287 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S287306AbSBRVSQ>;
	Mon, 18 Feb 2002 16:18:16 -0500
Message-ID: <3C716F8F.7060705@candelatech.com>
Date: Mon, 18 Feb 2002 14:18:07 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Petro <petro@auctionwatch.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Eepro100 driver.
In-Reply-To: <20020213211639.GB2742@auctionwatch.com> <3C6B2277.CA9A0BF8@mandrakesoft.com> <3C6B406E.1010706@candelatech.com> <3C6B4B20.FE4AE960@mandrakesoft.com> <20020218015234.GA6113@auctionwatch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Petro wrote:

> On Thu, Feb 14, 2002 at 12:29:04AM -0500, Jeff Garzik wrote:
> 
>>Ben Greear wrote:
>>
>>>Jeff Garzik wrote:
>>>
>>>>Long term, it is going to be replaced with e100 from Intel, as soon as
>>>>that driver is in good shape.
>>>>
>>>Any ETA on that?  (Make them really support the ethtool IOCTLs first :))
>>>
>>Soon but not terribly soon.  Intel has been responsive to feedback from
>>Andrew Morton and myself.  Once it passes our review and Intel's
>>testing, it will go in.  eepro100 will live on for a while, until we are
>>certain e100 is stable, though.  (and eepro100 won't disappear from 2.4
>>at all)
>>
> 
>     So what do you suggest people like Mr. Greear and I do in the mean
>     time?


It's easy enough to download the e100 from Intel's site if you
want to use it.  I will continue to try to use the eepro100 unless
I find problems with my particular hardware NICS.  The eepro100
still supports MII-IOCTLS better than the e100 supports ethtool
interfaces, and I like to know all those twisty little bits!

Ben


> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


