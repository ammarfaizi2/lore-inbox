Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVKJHUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVKJHUJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 02:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751263AbVKJHUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 02:20:09 -0500
Received: from mail.dvmed.net ([216.237.124.58]:747 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751166AbVKJHUH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 02:20:07 -0500
Message-ID: <4372F4A3.5090704@pobox.com>
Date: Thu, 10 Nov 2005 02:20:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       "Brown, Len" <len.brown@intel.com>, "Luck, Tony" <tony.luck@intel.com>,
       Ben Collins <bcollins@debian.org>,
       Jody McIntyre <scjody@modernduck.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Roland Dreier <rolandd@cisco.com>, Dave Jones <davej@codemonkey.org.uk>,
       Jens Axboe <axboe@suse.de>, Dave Kleikamp <shaggy@austin.ibm.com>,
       Steven French <sfrench@us.ibm.com>
Subject: Re: merge status
References: <20051109133558.513facef.akpm@osdl.org>
In-Reply-To: <20051109133558.513facef.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> We're at day 12 of the two-week window, time for a quick peek at
> outstanding patches in the subsystem trees.
> 
> -rw-r--r--    1 akpm     akpm       151205 Nov  9 11:19 git-libata-all.patch

For my stuff, libata and netdev, the 2.6.15 code has been upstream for a 
while.

Whatever holdovers there are are definitely waiting for 2.6.16 (and 
beyond, for stuff like Alan's libata PATA drivers).

	Jeff


