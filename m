Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264805AbSJaIWG>; Thu, 31 Oct 2002 03:22:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264855AbSJaIWG>; Thu, 31 Oct 2002 03:22:06 -0500
Received: from SNAP.THUNK.ORG ([216.175.175.173]:52195 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S264805AbSJaIWG>;
	Thu, 31 Oct 2002 03:22:06 -0500
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: [PATCH] [BK] 0/11  Ext2/3 Updates: Extended attributes, ACL, etc.
From: tytso@mit.edu
Message-Id: <E187Agn-0003b9-00@snap.thunk.org>
Date: Thu, 31 Oct 2002 03:28:29 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I've updated the ext2/3 patches for 2.5.45.  All of these changes can
also be grabbed by pulling from:

	bk://extfs.bkbits.net/extfs-2.5-update

Linus, please pull; these patches have been tested as part of Andrew
Morton's mm tree, and have minimal risks if the relevant config turned
off.  (People have also been using the ACL and Extended Attributes
patches enabled for quite some time as well.  :-)

A complete set of all of these patches can also be found at:

        http://thunk.org/tytso/linux/extfs-2.5

						- Ted





