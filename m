Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUCZDMC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUCZDMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:12:02 -0500
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:28686
	"EHLO muru.com") by vger.kernel.org with ESMTP id S262974AbUCZDMA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:12:00 -0500
Date: Thu, 25 Mar 2004 19:11:45 -0800
From: Tony Lindgren <tony@atomide.com>
To: Chris Cheney <ccheney@cheney.cx>
Cc: linux-kernel@vger.kernel.org, acpi-devel-request@lists.sourceforge.net,
       patches@x86-64.org, ak@suse.de, len.brown@intel.com, pavel@ucw.cz
Subject: Re: [PATCH] x86_64 VIA chipset IOAPIC fix
Message-ID: <20040326030809.GQ7967@atomide.com>
References: <20040325033434.GB8139@atomide.com> <20040326030458.GZ9248@cheney.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040326030458.GZ9248@cheney.cx>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chris Cheney <ccheney@cheney.cx> [040325 19:06]:
> On Wed, Mar 24, 2004 at 07:34:34PM -0800, Tony Lindgren wrote:
> 
> Is this actually a "VIA" fix or a just workaround for the broken Arima
> bios? I noticed that the Arima bios seems to be pretty buggy in some
> other aspects as well.

VIA fix, not a BIOS thing.

> BTW - Does this also solve the problem with needing USB to be compiled
> directly into the kernel in 64bit mode?

Hmmm, let me try, I'm recompiling right now anyways, just a sec.

Tony


