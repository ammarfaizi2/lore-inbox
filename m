Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263368AbTC2BMJ>; Fri, 28 Mar 2003 20:12:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263370AbTC2BMJ>; Fri, 28 Mar 2003 20:12:09 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:39383 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S263368AbTC2BMJ>; Fri, 28 Mar 2003 20:12:09 -0500
Subject: Re: 3c59x gives HWaddr FF:FF:...
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Andrew Morton <akpm@digeo.com>
Cc: jamagallon@able.es, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030328164419.0fe82430.akpm@digeo.com>
References: <20030328145159.GA4265@werewolf.able.es>
	 <20030328124832.44243f83.akpm@digeo.com>
	 <20030328230510.GA5124@werewolf.able.es> <1048897765.601.5.camel@teapot>
	 <20030328164419.0fe82430.akpm@digeo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1048900997.597.19.camel@teapot>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 29 Mar 2003 02:23:17 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-29 at 01:44, Andrew Morton wrote:
> > I had exactly the same issue as you, but this time it was on my laptop
> > when using a 3CCFE575CT CardBus 10/100 NIC.
> 
> Don't think so.  You were getting 0xff when reading all PCI registers.  In
> this case it is only the MAC address (which comes from an external eeprom)
> which is coming up as 0xff.

Nah! The problem I described in this mail happened a long, long time ago
(in a galaxy far, far away) and was exactly a "no command response"
(IIRC) error logged continuously to the console. Now, the problem I'm
experiencing is the slowdown-when-sending you may have read about which,
unfortunately, doesn't throw any kind of errors to the console ;-)

Thanks for your support, Andrew.

________________________________________________________________________
        Felipe Alfaro Solana
   Linux Registered User #287198
http://counter.li.org

