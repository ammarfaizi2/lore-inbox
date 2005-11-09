Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161005AbVKIWsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbVKIWsL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 17:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161011AbVKIWsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 17:48:10 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62688 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161005AbVKIWsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 17:48:08 -0500
Date: Wed, 9 Nov 2005 14:48:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org,
       James.Bottomley@steeleye.com, len.brown@intel.com, jgarzik@pobox.com,
       tony.luck@intel.com, bcollins@debian.org, scjody@modernduck.com,
       dwmw2@infradead.org, rolandd@cisco.com, davej@codemonkey.org.uk,
       axboe@suse.de, shaggy@austin.ibm.com, sfrench@us.ibm.com
Subject: Re: merge status
Message-Id: <20051109144801.1acb53ad.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511092203320.19282@hermes-1.csi.cam.ac.uk>
References: <20051109133558.513facef.akpm@osdl.org>
	<Pine.LNX.4.64.0511092203320.19282@hermes-1.csi.cam.ac.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
> > -rw-r--r--    1 akpm     akpm         2435 Nov  9 11:19 git-ntfs.patch
> 
> Odd.  "git format-patch -n `cat 
> /pub/scm/linux/kernel/git/torvalds/linux-2.6.git/HEAD`" returns nothing so 
> I can only assume that it is empty, too.  No idea why the size is 2.4k...  
> Certainly I do not remember committing anything since I last pushed to 
> Linus...

Ah, sorry, that appears to be all changelog noise coming out of
`git log origin..git-ntfs'

GIT e3b48297a3d9a852887f76e82fa7de5348ac1d9e master.kernel.org:/pub/scm/linux/kernel/git/aia21/ntfs-2.6-devel.git

commit e3b48297a3d9a852887f76e82fa7de5348ac1d9e
Merge: 33eaa30ec348a6a1391f556dd6eeb3d27054df95 94b166a7cbc232df279e1f7d5a8acfb6b8d02d59
Author: Anton Altaparmakov <aia21@hera.kernel.org>
Date:   Tue Nov 1 07:58:27 2005 -0800

    Merge branch 'master' of /home/aia21/ntfs-2.6

commit 33eaa30ec348a6a1391f556dd6eeb3d27054df95
Merge: b05576b308efcd07a295a89b2b1a08fae0811ce0 1f04c0a24b2f3cfe89c802a24396263623e3512d
Author: Anton Altaparmakov <aia21@hera.kernel.org>
Date:   Mon Oct 31 02:39:42 2005 -0800

    Merge branch 'master' of /home/aia21/ntfs-2.6



etcetera.  
