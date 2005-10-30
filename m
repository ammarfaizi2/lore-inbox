Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbVJ3Vcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbVJ3Vcu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVJ3Vcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:32:50 -0500
Received: from cantor2.suse.de ([195.135.220.15]:39299 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932105AbVJ3Vcs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:32:48 -0500
From: Neil Brown <neilb@suse.de>
To: Greg KH <greg@kroah.com>
Date: Mon, 31 Oct 2005 08:32:39 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17253.15351.332298.116824@cse.unsw.edu.au>
Cc: Daniele Orlandi <daniele@orlandi.com>, linux-kernel@vger.kernel.org
Subject: Re: An idea on devfs vs. udev
In-Reply-To: message from Greg KH on Sunday October 30
References: <200510301907.11860.daniele@orlandi.com>
	<17253.14484.653996.225212@cse.unsw.edu.au>
	<20051030222309.GA9423@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday October 30, greg@kroah.com wrote:
> On Mon, Oct 31, 2005 at 08:18:12AM +1100, Neil Brown wrote:
> > But then to make matters worse, there is this "sample.sh" file.  UGH!
> > It's a bit of shell code exported by the kernel.
> >    #!/bin/sh
> >    mknod /dev/hda  b 3 0
> 
> That's just a "joke" patch that is only in the -mm tree, as it gets
> pulled in from my tree.  It's not in mainline, and will never go there.

That's a relief,
thanks,
NeilBrown
