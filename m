Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263105AbUCZDOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUCZDOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:14:52 -0500
Received: from fmr02.intel.com ([192.55.52.25]:51864 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263105AbUCZDOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:14:51 -0500
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
From: Len Brown <len.brown@intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Cheney <ccheney@cheney.cx>, linux-kernel@vger.kernel.org,
       acpi-devel-request@lists.sourceforge.net, patches@x86-64.org,
       Andi Kleen <ak@suse.de>, pavel@ucw.cz
In-Reply-To: <20040326030809.GQ7967@atomide.com>
References: <20040325033434.GB8139@atomide.com>
	 <20040326030458.GZ9248@cheney.cx>  <20040326030809.GQ7967@atomide.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080270832.757.116.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2004 22:13:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-25 at 22:11, Tony Lindgren wrote:
> * Chris Cheney <ccheney@cheney.cx> [040325 19:06]:
> > On Wed, Mar 24, 2004 at 07:34:34PM -0800, Tony Lindgren wrote:
> > 
> > Is this actually a "VIA" fix or a just workaround for the broken Arima
> > bios? I noticed that the Arima bios seems to be pretty buggy in some
> > other aspects as well.
> 
> VIA fix, not a BIOS thing.

Actually it is VIA as presented by the BIOS,
so technically these disabled interrupt link devices
are a BIOS bug.

-Len


