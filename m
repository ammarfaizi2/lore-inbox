Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261281AbUKSHJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbUKSHJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 02:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbUKSHJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 02:09:57 -0500
Received: from fw.osdl.org ([65.172.181.6]:2797 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261281AbUKSHJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 02:09:55 -0500
Date: Thu, 18 Nov 2004 23:09:53 -0800
From: Chris Wright <chrisw@osdl.org>
To: Len Brown <len.brown@intel.com>
Cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
Message-ID: <20041118230948.W2357@build.pdx.osdl.net>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1100819685.987.120.camel@d845pe>; from len.brown@intel.com on Thu, Nov 18, 2004 at 06:14:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Len Brown (len.brown@intel.com) wrote:
> Chris,
> 
> Please apply this debug patch and boot with
> apic=debug acpi_dbg_level=1

Len, unfortunately the disk drive went south on my laptop.  So testing
will take a bit longer as I piece things back together.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
