Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262476AbUKWCGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262476AbUKWCGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 21:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbUKWCG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 21:06:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:21703 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262548AbUKWB5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:57:20 -0500
Date: Mon, 22 Nov 2004 17:57:03 -0800
From: Chris Wright <chrisw@osdl.org>
To: Len Brown <len.brown@intel.com>
Cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
Message-ID: <20041122175703.H2357@build.pdx.osdl.net>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1100819685.987.120.camel@d845pe>; from len.brown@intel.com on Thu, Nov 18, 2004 at 06:14:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the record...

* Len Brown (len.brown@intel.com) wrote:
> Please apply this debug patch and boot with
> apic=debug acpi_dbg_level=1

acpi_dbg_level=1 boots as expected.  w/out it, irq6 interrupt storm.
I have dmesg if you're still interested.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
