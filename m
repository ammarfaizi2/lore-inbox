Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266640AbUGVHUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266640AbUGVHUk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 03:20:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUGVHUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 03:20:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:18128 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266640AbUGVHUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 03:20:35 -0400
Date: Thu, 22 Jul 2004 03:19:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: bunk@fs.tum.de, corbet@lwn.net, bgerst@didntduck.org,
       linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-Id: <20040722031923.654258e3.akpm@osdl.org>
In-Reply-To: <20040722070453.GA21907@kroah.com>
References: <40FEEEBC.7080104@quark.didntduck.org>
	<20040721231123.13423.qmail@lwn.net>
	<20040721235228.GZ14733@fs.tum.de>
	<20040722025539.5d35c4cb.akpm@osdl.org>
	<20040722070453.GA21907@kroah.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <greg@kroah.com> wrote:
>
> On Thu, Jul 22, 2004 at 02:55:39AM -0700, Andrew Morton wrote:
> > Adrian Bunk <bunk@fs.tum.de> wrote:
> > >
> > > Changes that remove functionally like Greg's patch are hopefully 
> > > still 2.7 stuff - 2.6 is a stable kernel series and smooth upgrades 
> > > inside a stable kernel series are a must for many users.
> > 
> > I don't necessarily agree that such changes in the userspace interface
> > should be tied to the kernel version number, really.  That's a three or
> > four year warning period, which is unreasonably long.  Six to twelve months
> > should be long enough for udev-based replacements to stabilise and
> > propagate out into distributions.
> 
> Users have had the 6-12 month warning about devfs for a while now :)

No, they had a three year warning.  "It'll be gone in 2.8".

> Ok, if people think that would really change anything, I'll wait a year.
> I'm patient :)

Delete 100 lines per week ;)

