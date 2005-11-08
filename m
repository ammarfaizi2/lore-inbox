Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbVKHSvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVKHSvh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbVKHSvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:51:37 -0500
Received: from mail.kroah.org ([69.55.234.183]:64671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030305AbVKHSvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:51:36 -0500
Date: Tue, 8 Nov 2005 10:51:01 -0800
From: Greg KH <greg@kroah.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Neil Brown <neilb@suse.de>, Daniele Orlandi <daniele@orlandi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: An idea on devfs vs. udev
Message-ID: <20051108185101.GA16011@kroah.com>
References: <200510301907.11860.daniele@orlandi.com> <17253.14484.653996.225212@cse.unsw.edu.au> <20051030222309.GA9423@kroah.com> <20051108184132.GC8126@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051108184132.GC8126@waste.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2005 at 10:41:32AM -0800, Matt Mackall wrote:
> On Sun, Oct 30, 2005 at 02:23:09PM -0800, Greg KH wrote:
> > On Mon, Oct 31, 2005 at 08:18:12AM +1100, Neil Brown wrote:
> > > But then to make matters worse, there is this "sample.sh" file.  UGH!
> > > It's a bit of shell code exported by the kernel.
> > >    #!/bin/sh
> > >    mknod /dev/hda  b 3 0
> > 
> > That's just a "joke" patch that is only in the -mm tree, as it gets
> > pulled in from my tree.  It's not in mainline, and will never go there.
> 
> Perhaps you can drop this horror now that Halloween has passed.

Heh.  But why?  Is it causing problems for anyone?

thanks,

greg k-h
