Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291203AbSAaRzF>; Thu, 31 Jan 2002 12:55:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291206AbSAaRyz>; Thu, 31 Jan 2002 12:54:55 -0500
Received: from ip68-3-104-241.ph.ph.cox.net ([68.3.104.241]:31397 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S291203AbSAaRyl>;
	Thu, 31 Jan 2002 12:54:41 -0500
Message-ID: <3C5984C9.20104@candelatech.com>
Date: Thu, 31 Jan 2002 10:54:17 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: Robbert Kouprie <robbert@jvb.tudelft.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: NIC lockup in 2.4.17 (SMP/APIC/Intel 82557)
In-Reply-To: <Pine.LNX.4.44.0201311741430.5601-100000@flubber.jvb.tudelft.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Robbert Kouprie wrote:

> The box is an Abit BP6 with Dual Celerons 433 and 192 Mb RAM. No
> PCI-Riser cards. It is connected at 100 Mbit full duplex to a 100
> Mbit switch. APIC is enabled. No kind of power management is enabled.


The only lockup problems I have run into are connecting some eepro nics to
a 10bt hub, and using (cheap arsed, it appears) PCI riser cards.  I have
heard of some SMP related issues, but nothing concrete, and I don't
have any SMP systems personally.  You could try the e100, but I have
no idea if it will be better or worse for your particular problem.


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


