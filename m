Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132179AbQKSDkY>; Sat, 18 Nov 2000 22:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132252AbQKSDkO>; Sat, 18 Nov 2000 22:40:14 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:58887 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S132179AbQKSDkE>; Sat, 18 Nov 2000 22:40:04 -0500
Message-ID: <3A175226.3A9C3180@holly-springs.nc.us>
Date: Sat, 18 Nov 2000 23:08:06 -0500
From: Michael Rothwell <rothwell@holly-springs.nc.us>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext2 sparse superblocks
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for documentation on Ext2's support for sparse superblocks.
Canvasing search engines gets me the same two references to tune2fs and
the dac960. I've also looked in /usr/doc and
/usr/src/linux/Documentation without success.

What it the method uses to reduce the number of superblocks? How are
they laid out before vs after sparse_super is enabled? Any caveats?

Thanks.

-M
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
