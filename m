Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133111AbRDRMmo>; Wed, 18 Apr 2001 08:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133110AbRDRMme>; Wed, 18 Apr 2001 08:42:34 -0400
Received: from mail.intrex.net ([209.42.192.246]:59144 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S133109AbRDRMmO>;
	Wed, 18 Apr 2001 08:42:14 -0400
Date: Wed, 18 Apr 2001 08:44:20 -0400
From: James Lewis Nance <jlnance@intrex.net>
To: Alexander Viro <viro@math.psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][CFT] ext2 directories in pagecache
Message-ID: <20010418084420.A857@bessie.dyndns.org>
In-Reply-To: <Pine.GSO.4.21.0104121217580.19944-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0104121217580.19944-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Apr 12, 2001 at 12:33:42PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2001 at 12:33:42PM -0400, Alexander Viro wrote:
> 	Folks, IMO ext2-dir-patch got to the stable stage. Currently
> it's against 2.4.4-pre2, but it should apply to anything starting with
> 2.4.2 or so.

Have you had any feedback about this patch?  I applied it last night to
2.4.3.  It seemed to work.  When I booted my computer this morning fsck
complained about problems with the directory on one of my ext2 file systems.
Since fsck does not run on every boot I dont really have a way of knowing if
this has anything to do with your patch or not.  I'm running the patched
kernel again right now.  Ill shutdown and force an fsck later today to see
if anything shows up.

Thanks,

Jim
