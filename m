Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWJHSAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWJHSAe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 14:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWJHSAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 14:00:34 -0400
Received: from dev.mellanox.co.il ([194.90.237.44]:18048 "EHLO
	dev.mellanox.co.il") by vger.kernel.org with ESMTP id S1751301AbWJHSAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 14:00:33 -0400
Date: Sun, 8 Oct 2006 19:59:58 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Adrian Bunk <bunk@stusta.de>
Cc: Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org
Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
Message-ID: <20061008175958.GA30377@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20061008173809.GE6755@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061008173809.GE6755@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Adrian Bunk <bunk@stusta.de>:
> Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
> 
> On Sun, Oct 08, 2006 at 07:12:54AM +0000, Pavel Machek wrote:
> > 
> > On Sat 07-10-06 23:46:21, Adrian Bunk wrote:
> > > This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
> > > that are not yet fixed Linus' tree.
> > > 
> > ...
> > > Subject    : T60 stops triggering any ACPI events
> > > References : http://lkml.org/lkml/2006/10/4/425
> > > Submitter  : "Michael S. Tsirkin" <mst@mellanox.co.il>
> > > Status     : unknown

This was on a pre -rc1 git tree.
I've been using -rc1 since it's out and does not happen to me anymore.
So we probably can write this off as a memory corruption
issue that got fixed in between.

-- 
MST
