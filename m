Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269409AbRHHUw3>; Wed, 8 Aug 2001 16:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269520AbRHHUwU>; Wed, 8 Aug 2001 16:52:20 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:14313 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269409AbRHHUwG>;
	Wed, 8 Aug 2001 16:52:06 -0400
Message-ID: <3B71A6BB.6623B9BF@candelatech.com>
Date: Wed, 08 Aug 2001 13:53:15 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Donald Becker <becker@scyld.com>
CC: LKML <linux-kernel@vger.kernel.org>,
        "eepro100@scyld.com" <eepro100@scyld.com>
Subject: Re: [eepro100] Problem with Linux 2.4.7 and builtin eepro onIntel'sEEA2  
 motherboard. (Solved, kinda)
In-Reply-To: <Pine.LNX.4.10.10108071900340.976-100000@vaio.greennet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A kind Intel employee told me that the e100 would indeed work
on 2.4.7 kernels, so I downloaded the driver and gave it a shot.

So far, it seems to be working flawlessly.  Does anyone know how
to get mii-diag like information out of the e100?  (For instance,
I'd like to be able to query the card to see what it's current link
speed is, and force it to various speeds and advertise flags...)

Enjoy,
Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
