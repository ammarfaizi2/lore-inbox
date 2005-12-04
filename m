Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVLDRAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVLDRAv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 12:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVLDRAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 12:00:50 -0500
Received: from unthought.net ([212.97.129.88]:59913 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S932301AbVLDRAu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 12:00:50 -0500
Date: Sun, 4 Dec 2005 18:00:49 +0100
From: Jakob Oestergaard <jakob@unthought.net>
To: Greg KH <greg@kroah.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051204170049.GA4179@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Greg KH <greg@kroah.com>, Jesper Juhl <jesper.juhl@gmail.com>,
	Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
References: <20051203135608.GJ31395@stusta.de> <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com> <20051203201945.GA4182@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051203201945.GA4182@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2005 at 12:19:45PM -0800, Greg KH wrote:
> On Sat, Dec 03, 2005 at 03:29:54PM +0100, Jesper Juhl wrote:
> > 
> > Why can't this be done by distributors/vendors?
> 
> It already is done by these people, look at the "enterprise" Linux
> distributions and their 5 years of maintance (or whatever the number
> is.)
> 
> If people/customers want stability, they already have this option.

If the kernel was stable (reliability wise - as in "not crashing") then
you'd be perfectly right.

In the real world, however, admins currently need to pick out specific
versions of the kernel for specific workloads (try running a large
fileserver on anything but 2.6.11.11 for example - any earlier or later
kernel will barf reliably. For web serving it's another kernel that's
golden, I forgot which).

There are very very good reasons for offering a 'stable series' in plain
source-tree form - lots of admins of real-world systems need this.

Adrian, I like the idea :)

-- 

 / jakob

