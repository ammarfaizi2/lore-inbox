Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274014AbRIVGqI>; Sat, 22 Sep 2001 02:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274162AbRIVGps>; Sat, 22 Sep 2001 02:45:48 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:24978 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S274014AbRIVGph>;
	Sat, 22 Sep 2001 02:45:37 -0400
Message-ID: <3BAC335E.121E5E98@candelatech.com>
Date: Fri, 21 Sep 2001 23:44:46 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Colin Frank <kernel@osafo.com>
CC: Abe Hayhurst <abe@avidsublimation.net>, linux-kernel@vger.kernel.org
Subject: Re: Best gigabit card for linux
In-Reply-To: <001a01c13fed$ef3806f0$6c01a8c0@ABEPC> <3BAC153A.4060700@osafo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Frank wrote:
> 
> In the following test. I was able to achieve close to 40 MegaBytes
> per second using the packet engines Hamachi driver.
> 
> http://www.linuxcare.com/labs/sol-val/3w-esc6800-web.epl
> Test done with:
>     Packet engines Hamachi card
>     3ware escalade 6800
>     2.2.16 kernel.
>     Cisco 6500
>     10 - 20 client machines each with eepro100 cards
> 
> Colin...

I've had good luck with the Netgear GA620, and it's very cheap
too...  I was testing on the 2.4.3 kernel and RH 7.0.  It worked
w/out problem.

It's a fiber NIC.

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
