Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbUBWNXR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 08:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbUBWNXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 08:23:16 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59830 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261846AbUBWNXN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 08:23:13 -0500
Date: Thu, 19 Feb 2004 19:34:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: Hod McWuff <hod@wuff.dhs.org>
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: HT CPU handling - 2.6.2
Message-ID: <20040219183410.GF467@openzaurus.ucw.cz>
References: <BF1FE1855350A0479097B3A0D2A80EE0023E8B98@hdsmsx402.hd.intel.com> <1076391435.4103.730.camel@dhcppc4> <1076395641.2246.5.camel@siberian.wuff.dhs.org> <1076397803.4105.900.camel@dhcppc4> <1076402910.2577.3.camel@siberian.wuff.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076402910.2577.3.camel@siberian.wuff.dhs.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> OK then the heck with the flag... am I to understand that there is in
> fact a partial CPU on the die? (LAPIC but no other logic?) Or is the
> second CPU instance there and real but administratively disabled?
> 

If I read it correctly, you have two logical CPUs there,
but one of them is administratively disabled. You can't enable
it without some serious tools.

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

