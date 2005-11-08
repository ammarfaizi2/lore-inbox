Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVKHSmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVKHSmB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 13:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVKHSmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 13:42:01 -0500
Received: from waste.org ([216.27.176.166]:2200 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1030294AbVKHSmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 13:42:01 -0500
Date: Tue, 8 Nov 2005 10:41:32 -0800
From: Matt Mackall <mpm@selenic.com>
To: Greg KH <greg@kroah.com>
Cc: Neil Brown <neilb@suse.de>, Daniele Orlandi <daniele@orlandi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: An idea on devfs vs. udev
Message-ID: <20051108184132.GC8126@waste.org>
References: <200510301907.11860.daniele@orlandi.com> <17253.14484.653996.225212@cse.unsw.edu.au> <20051030222309.GA9423@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030222309.GA9423@kroah.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 02:23:09PM -0800, Greg KH wrote:
> On Mon, Oct 31, 2005 at 08:18:12AM +1100, Neil Brown wrote:
> > But then to make matters worse, there is this "sample.sh" file.  UGH!
> > It's a bit of shell code exported by the kernel.
> >    #!/bin/sh
> >    mknod /dev/hda  b 3 0
> 
> That's just a "joke" patch that is only in the -mm tree, as it gets
> pulled in from my tree.  It's not in mainline, and will never go there.

Perhaps you can drop this horror now that Halloween has passed.

-- 
Mathematics is the supreme nostalgia of our time.
