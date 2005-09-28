Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbVI1K6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbVI1K6d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 06:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVI1K6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 06:58:33 -0400
Received: from ppsw-1.csi.cam.ac.uk ([131.111.8.131]:46300 "EHLO
	ppsw-1.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751214AbVI1K6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 06:58:33 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Date: Wed, 28 Sep 2005 11:58:04 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Greg KH <greg@kroah.com>
cc: Roland Dreier <rolandd@cisco.com>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [git pull] InfiniBand fixes for 2.6.14
In-Reply-To: <20050928093633.GA12757@kroah.com>
Message-ID: <Pine.LNX.4.60.0509281156510.2224@hermes-1.csi.cam.ac.uk>
References: <524q85on6e.fsf@cisco.com> <20050928093633.GA12757@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Greg KH wrote:
> On Tue, Sep 27, 2005 at 09:01:45PM -0700, Roland Dreier wrote:
> > Linus, please pull from
> > 
> >     master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband.git for-linus
> 
> Hm, I complained about this last time, with no response...
> 
> I didn't think that git pulls were going to be allowed from subsystem
> maintainers after -rc1 came out.  After that, patches by email were
> required to be sent, not git pulls.  This does cause a bit more work
> for the maintainer, but it ensures that they only send the patches they
> really want to get in.
> 
> At least that was what I thought we decided on at the kernel summit...

That is not what Linus said on LKML only a week or two ago.  He said git 
pulls are just fine.  It is the content of the git pull that matters.  It 
has to be bug fixes only.  As Linus said, and I couldn't agree more, it 
would be silly to limit the method of patch submission given only the 
content is meant to be limited.

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/
