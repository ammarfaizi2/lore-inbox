Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265261AbSJRSmK>; Fri, 18 Oct 2002 14:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265278AbSJRSmK>; Fri, 18 Oct 2002 14:42:10 -0400
Received: from SNAP.THUNK.ORG ([216.175.175.173]:456 "EHLO snap.thunk.org")
	by vger.kernel.org with ESMTP id <S265261AbSJRSmJ>;
	Fri, 18 Oct 2002 14:42:09 -0400
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] Extended Attributes for ext 2/3 filesystems
From: tytso@MIT.EDU
From: tytso@mit.edu
Message-Id: <E182cA0-0000vT-00@snap.thunk.org>
Date: Fri, 18 Oct 2002 14:47:48 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This is a resend of the extended attributes and ACL patches for ext2/3.
They are updated against bk-current, with a minor fix in fs/Config.in.
No comments were made against the last time I submitted these patches,
and the patches are relatively low risk, as they don't significantly
change the code paths if the extended attribute and ACL configs are not
defined.

I believe they are ready to be applied to the main tree.

						- Ted
