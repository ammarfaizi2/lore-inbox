Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262569AbUKWBxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbUKWBxf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 20:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbUKWBx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 20:53:26 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:20498 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262548AbUKWBwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 20:52:55 -0500
Date: Tue, 23 Nov 2004 02:52:51 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>, Len Brown <len.brown@intel.com>,
       Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: why use ACPI (Re: 2.6.10-rc2 doesn't boot (if no floppy device))
Message-ID: <20041123015251.GA2927@stusta.de>
References: <20041115152721.U14339@build.pdx.osdl.net> <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net> <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de> <1101148138.20008.6.camel@d845pe> <20041123004619.GQ19419@stusta.de> <1101172056.20006.153.camel@d845pe> <20041123012333.GK17249@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123012333.GK17249@redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 08:23:33PM -0500, Dave Jones wrote:
>...
> I don't think I've ever seen a desktop without APM.
> (modulo broken biosen).
>...

For my old computer (bought 1998) this was true.

Unfortunately, my new computer (bought early this year) says:
  kernel: apm: BIOS not found.

I don't know whether it's a hardware problem or "only" a BIOS problem, 
but it forces me to use ACPI to power off my computer.  :-(

> 		Dave

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

