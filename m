Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269481AbRHGWYo>; Tue, 7 Aug 2001 18:24:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269801AbRHGWYf>; Tue, 7 Aug 2001 18:24:35 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:58336 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S269481AbRHGWYR>;
	Tue, 7 Aug 2001 18:24:17 -0400
Message-ID: <3B706ACE.CCF9148E@candelatech.com>
Date: Tue, 07 Aug 2001 15:25:18 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Robottom Reis <kiko@async.com.br>
CC: LKML <linux-kernel@vger.kernel.org>,
        "eepro100@scyld.com" <eepro100@scyld.com>
Subject: Re: [eepro100] Problem with Linux 2.4.7 and builtin eepro on Intel'sEEA2 
 motherboard.
In-Reply-To: <Pine.LNX.4.32.0108071910120.379-100000@blackjesus.async.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Robottom Reis wrote:
> 
> Had the same board, and the same sort of problems with both drivers. Had
> to roll back to 2.2 and intel's e100. :(

Intel's e100 works with kernels up to 2.4.4, according to their page
(which I can't seem to access from a 2.4.7 machine, interestingly
enough!)

I didn't try that kernel because in that kernel the tulip driver is
busted for my NIC, so I'm caught between a rock and a huge amount of risky
patching/hacking that I don't have time for!

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
