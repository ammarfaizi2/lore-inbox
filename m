Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319424AbSILDhs>; Wed, 11 Sep 2002 23:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319425AbSILDhs>; Wed, 11 Sep 2002 23:37:48 -0400
Received: from avocet.mail.pas.earthlink.net ([207.217.120.50]:55533 "EHLO
	avocet.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S319424AbSILDhs>; Wed, 11 Sep 2002 23:37:48 -0400
Date: Wed, 11 Sep 2002 23:45:21 -0400
To: reiser@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Performance differences in recent kernels
Message-ID: <20020912034521.GA5984@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you test on equal partitions too?

Tonight I updated the scripts so all filesystem types 
will use the same partition.

> We need to get Chris's patches into the tree

> Can we ask you to test again with these patches applied?

> ftp://ftp.suse.com/pub/people/mason/patches/data-logging

If you have patches against a current tree, I can apply
them before testing a kernel.  I'll start paying more
attention to reiserfs-list.  It's probably best to test
patches when the -rc series starts.  

> AIM is a proprietary benchmark, yes?

It's gpl.  i only running aim7 on ext2 atm.

> If we send you a copy of reiser4
> next month, would you be willing to give it a run?

Will there be a choice of mounting reiserfs
or reiser4?  (like ext2 or ext3), or will there
be a complete departure?  

-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

