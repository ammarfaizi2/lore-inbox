Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261418AbUKSNsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261418AbUKSNsV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 08:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbUKSNsU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 08:48:20 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:49424 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261408AbUKSNr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 08:47:58 -0500
Date: Fri, 19 Nov 2004 14:47:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Len Brown <len.brown@intel.com>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc2 doesn't boot (if no floppy device)
Message-ID: <20041119134754.GA5390@stusta.de>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1100819685.987.120.camel@d845pe>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 06:14:46PM -0500, Len Brown wrote:

> Chris,
 
Hi Len,

I have the same problem Chris has.

> Please apply this debug patch and boot with
> apic=debug acpi_dbg_level=1
>...

It doesn't compile since I don't have APIC support enabled.

> thanks,
> -Len
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

