Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbUKWCAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUKWCAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUKWCAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:00:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:28359 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262455AbUKWB6l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:58:41 -0500
Date: Mon, 22 Nov 2004 17:58:38 -0800
From: Chris Wright <chrisw@osdl.org>
To: Len Brown <len.brown@intel.com>
Cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
Message-ID: <20041122175838.I2357@build.pdx.osdl.net>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1100941324.987.238.camel@d845pe>; from len.brown@intel.com on Sat, Nov 20, 2004 at 04:02:04AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the record...

* Len Brown (len.brown@intel.com) wrote:
> Please try this updated debug patch.
> 
> It clears the ELCR on Linux boot.

This boots as expected (no irq6 storm).  I have dmesg if you're still
interested.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
