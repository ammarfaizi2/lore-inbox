Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132623AbRDUOBu>; Sat, 21 Apr 2001 10:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132625AbRDUOBk>; Sat, 21 Apr 2001 10:01:40 -0400
Received: from tomts14.bellnexxia.net ([209.226.175.35]:32219 "EHLO
	tomts14-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132623AbRDUOBY>; Sat, 21 Apr 2001 10:01:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [BUG] lvm beta7 and ac11 problems
Date: Sat, 21 Apr 2001 10:00:22 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-openlvm@nl.linux.org, linux-lvm@sistina.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Message-Id: <01042110002200.00707@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

building a kernel with 2.4.3-ac11 and lvm beta7 + vfs_locking_patch-2.4.2 yields:

oscar# depmod -ae 2.4.3-ac11 
depmod: *** Unresolved symbols in /lib/modules/2.4.3-ac11/kernel/drivers/md/lvm-mod.o
depmod:         get_hardblocksize

ideas?

Ed Tomlinson
