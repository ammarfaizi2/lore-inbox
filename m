Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267603AbUHXMaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267603AbUHXMaX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 08:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267648AbUHXMaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 08:30:23 -0400
Received: from painless.aaisp.net.uk ([217.169.20.17]:60051 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S267603AbUHXMaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 08:30:18 -0400
Subject: XFS compilation warning in 2.6.9-rc1
From: Andrew Clayton <andrew@digital-domain.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1093350616.2237.8.camel@alpha.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 24 Aug 2004 13:30:16 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just got the following warning when compiling a 2.6.9-rc1, this is using
gcc version: 

	gcc (GCC) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)

from Fedora Core 2.


 
  CC      fs/xfs/xfs_bmap.o
fs/xfs/xfs_bmap.c: In function `xfs_bmap_do_search_extents':
fs/xfs/xfs_bmap.c:3434: warning: integer constant is too large for
"long" type
fs/xfs/xfs_bmap.c:3435: warning: integer constant is too large for
"long" type
  CC      fs/xfs/xfs_bmap_btree.o




Cheers,

Andrew Clayton



