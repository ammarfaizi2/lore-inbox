Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273515AbRJDSDh>; Thu, 4 Oct 2001 14:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273534AbRJDSD2>; Thu, 4 Oct 2001 14:03:28 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:44224 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S273515AbRJDSDT>;
	Thu, 4 Oct 2001 14:03:19 -0400
Message-ID: <3BBCA47A.FE108239@candelatech.com>
Date: Thu, 04 Oct 2001 11:03:38 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: hps@intermeta.de
CC: linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <Pine.GSO.4.30.0110032057000.8016-100000@shell.cyberus.ca> <3BBC05EC.AA9BFB4F@candelatech.com> <9ph3qu$g9b$1@forge.intermeta.de> <3BBC89CC.D791C8FA@candelatech.com> <9pi6em$itf$1@forge.intermeta.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Henning P. Schmiedehausen" wrote:

> >several 2-port EEPRO based NICs out there that work really well
> >too, but they are expensive...
> 
> Hm. If I really need more NICs than PCI slots, I normally use a
> Router. And I've even toyed a little with a Gigabit card linked to a
> Cisco C3524XL using a certain 802.1q unofficial extension to the Linux
> kernel to try and provide 24 100 MBit Ethernet Interfaces from a
> single Linux Box [2].

I wrote (one of) the VLAN patch, and I've brought up 4k
VLAN interfaces.  Let me or the vlan@scry.wanfear.com mailing list
know if you have trouble with my VLAN patch...  My vlan patch
can be found:
http://www.candelatech.com/~greear/vlan.html


Enjoy,
Ben

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
