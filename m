Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315734AbSHNUbl>; Wed, 14 Aug 2002 16:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315746AbSHNUbl>; Wed, 14 Aug 2002 16:31:41 -0400
Received: from donkeykong.gpcc.itd.umich.edu ([141.211.2.163]:42967 "EHLO
	donkeykong.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S315734AbSHNUbk>; Wed, 14 Aug 2002 16:31:40 -0400
Date: Wed, 14 Aug 2002 16:35:28 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST: nfsv4 patches
Message-ID: <Pine.SOL.4.44.0208141629110.1653-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Due to a boneheaded mistake in a script I wrote, I accidently
posted NFSv4 patches against 2.5.28 yesterday instead of 2.5.31!

Therefore, with my tail between my legs, I'm reposting the
patchset, against 2.5.31 this time.

Since I have to repost, I went ahead and implemented two
changes suggested by Christoph Hellwig:
 - reorder patchset: put changes to fs/Config.in last
 - remove noisy printk from nfsd_svc()

Instructions for running NFSv4 can still be found at
  www.citi.umich.edu/projects/nfsv4/patches-2.5

Sorry for the inconvenience,
 Kendrick

