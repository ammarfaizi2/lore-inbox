Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWAIPEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWAIPEZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWAIPEZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:04:25 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:18860 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S964787AbWAIPEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:04:25 -0500
Date: Mon, 09 Jan 2006 10:04:17 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: 64 bit kernel
In-reply-to: <001c01c61520$2cbba6b0$6d0ea8c0@LoJackOne.LoJack.com>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200601091004.17918.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <1136780835.6695.37.camel@falklands.home.pc>
 <001c01c61520$2cbba6b0$6d0ea8c0@LoJackOne.LoJack.com>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 January 2006 08:25, Mike McCarthy, W1NR wrote:
>I saw a similar issue many years ago that turned out to be a chipset
> bug. This was a PII system that used 16 bit wide modules.  When using
> only one module, the chipset "fooled" the OS into thinking that it
> was doing 32 bit wide operations.  However, it failed at full speed. 
> Reducing the memory bus speed or installing modules in pairs "fixed"
> the problem.  I suspect a bus or memory controller issue rather than
> the kernel.
>
>The failure mode was exactly as you describe.  It manifested itself as
> disk errors or DMA failures.  Unfortunately the chipset vendor
> determined that it was a silicon bug and said that they would NOT fix
> it!
>
And that sucks the big one, Mike.  Will you share that vendors name so 
we can bypass them in future purchase thinking?

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
