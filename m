Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWJHTac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWJHTac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 15:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWJHTaa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 15:30:30 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:9488 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751365AbWJHTaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 15:30:10 -0400
Date: Sun, 8 Oct 2006 21:30:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org
Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
Message-ID: <20061008193005.GJ6755@stusta.de>
References: <20061008173809.GE6755@stusta.de> <20061008175958.GA30377@mellanox.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008175958.GA30377@mellanox.co.il>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2006 at 07:59:58PM +0200, Michael S. Tsirkin wrote:
> Quoting r. Adrian Bunk <bunk@stusta.de>:
> > Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
> > 
> > On Sun, Oct 08, 2006 at 07:12:54AM +0000, Pavel Machek wrote:
> > > 
> > > On Sat 07-10-06 23:46:21, Adrian Bunk wrote:
> > > > This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
> > > > that are not yet fixed Linus' tree.
> > > > 
> > > ...
> > > > Subject    : T60 stops triggering any ACPI events
> > > > References : http://lkml.org/lkml/2006/10/4/425
> > > > Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> > > > Status     : unknown
> 
> This was on a pre -rc1 git tree.
> I've been using -rc1 since it's out and does not happen to me anymore.
> So we probably can write this off as a memory corruption
> issue that got fixed in between.

Thanks for the information, I've removed it from the list.

> MST

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

