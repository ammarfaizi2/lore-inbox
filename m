Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUCNSf6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 13:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261942AbUCNSf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 13:35:58 -0500
Received: from mail1.kontent.de ([81.88.34.36]:28359 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261939AbUCNSf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 13:35:56 -0500
Date: Sun, 14 Mar 2004 19:35:58 +0100
From: Sascha Wilde <wilde@sha-bang.de>
To: Len Brown <len.brown@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.2 reboot hangs on AMD Athlon System
Message-ID: <20040314183558.GA563@kenny.sha-bang.local>
References: <A6974D8E5F98D511BB910002A50A6647615F4EB9@hdsmsx402.hd.intel.com> <1079244503.2173.142.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079244503.2173.142.camel@dhcppc4>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, 2004 at 01:08:25AM -0500, Len Brown wrote:
> Curious that this happens
> 1. only on 2.6

yes, but true: any other reboot code I've come across (including
those of the other Linux kernel versions) work as expected on the box.

> 2. with acpi=off and "acpi=on"

yust retested it with the latest (2.6.4) kernel -- yes, regardless of
which (or none) powermanagement is used, the reboot freezes the mashine.

> Would be good to know that the system is running the latest BIOS.

afaik I'm using the latest available BIOS for the board.

btw. the toppic is false, that should be 
"Kernel 2.6.x reboot hangs on AMD Athlon System"

cheers
sascha
-- 
Sascha Wilde
"Gimme about 10 seconds to think for a minute..."
