Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268442AbRHAWQU>; Wed, 1 Aug 2001 18:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268450AbRHAWQL>; Wed, 1 Aug 2001 18:16:11 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:60664 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S268442AbRHAWP4>; Wed, 1 Aug 2001 18:15:56 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200108012215.f71MFq7n007433@webber.adilger.int>
Subject: Re: 2.4.2 ext2fs corruption status
In-Reply-To: <3B687E41.D969FCC3@gxt.com> "from Mohamed DOLLIAZAL at Aug 1, 2001
 05:10:09 pm"
To: Mohamed DOLLIAZAL <mhd@gxt.com>
Date: Wed, 1 Aug 2001 16:15:52 -0600 (MDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL87 (25)]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mohammed DOLLIAZAL writes:
> I am using RH 7.1 with the stock 2.4.2-2 kernel, I got several times my
> disk corrupted and even lost the superblock. I have seen a lot messages
> about the ext2fs corruption in kernel 2.4.2 but I didn't find what was
> causing this problem (hardware or sofware). And if was bug, What kernel
> should I use to avoid this problem.

It could be the VIA chipset, but I'm not sure.  One rule with the Linux
kernel is you should (almost) always be running the most recent kernel
before reporting a bug.  This saves a lot of effort in tracking down
bugs that have alreay been fixed.

It may be that Red Hat has already released a new kernel RPM since that
time, or maybe you need to compile a new kernel.

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

