Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263124AbTDRQAI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263129AbTDRQAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:00:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:50135 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263124AbTDRQAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:00:07 -0400
Date: Fri, 18 Apr 2003 09:12:17 -0700
From: Dave Olien <dmo@osdl.org>
To: John v/d Kamp <john@connectux.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] DAC960_Release bug (2.4.x)
Message-ID: <20030418161217.GA7456@osdl.org>
References: <Pine.LNX.4.53.0304161136270.18523@fratser> <20030416224013.GA11514@osdl.org> <Pine.LNX.4.53.0304171004160.10181@fratser> <20030417202714.GA30622@osdl.org> <Pine.LNX.4.53.0304181052230.3981@fratser>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0304181052230.3981@fratser>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for testing this patch and the rpm pointer!
I'll look over the rpm this week end, and probably send this patch to
marcello next week. Then, generate a patch for 2.5.


On Fri, Apr 18, 2003 at 11:20:01AM +0200, John v/d Kamp wrote:
> The libhd can be found here:
> ftp://ftp.suse.com/pub/suse/i386/8.1/suse/src/hwinfo-5.39-2.src.rpm
> We use a somewhat older version, but that probably doesn't matter.
> 
> I've compiled the module, and our install software ran just fine.
> Repartitioning the drive was no problem. Using the driver on a normal
> system was no problem either (never was).
> 
