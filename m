Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292595AbSCDRpv>; Mon, 4 Mar 2002 12:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292594AbSCDRpn>; Mon, 4 Mar 2002 12:45:43 -0500
Received: from ip68-3-107-226.ph.ph.cox.net ([68.3.107.226]:43141 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S292632AbSCDRpS>;
	Mon, 4 Mar 2002 12:45:18 -0500
Message-ID: <3C83B2A6.2010200@candelatech.com>
Date: Mon, 04 Mar 2002 10:45:10 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Hirling Endre <endre@interware.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: recommended gigabit card for dot1q?
In-Reply-To: <Pine.LNX.4.44.0203041827430.1157-100000@dusk.interware.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Check out the VLAN mailing list archives...there have
been some success stories there with gigabit nics:

http://www.candelatech.com/~greear/vlan.html

Hirling Endre wrote:

> Hello,
> 
> I have to upgrade one of our linux-based routers to gigabit. What GE
> card do you recommend for using with dot1q vlans? I tried a D-Link one
> (DGE550SX, based on a Level1 chip) and an Intel one that works with the
> e1000 driver, but I couldn't set up vlans properly with either of these.
> 
> thanks in advance
> endre
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


