Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130645AbRAXPFQ>; Wed, 24 Jan 2001 10:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132382AbRAXPFG>; Wed, 24 Jan 2001 10:05:06 -0500
Received: from zeus.kernel.org ([209.10.41.242]:3038 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130645AbRAXPEw>;
	Wed, 24 Jan 2001 10:04:52 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: aviro@redhat.com
Cc: linux-kernel@vger.rutgers.edu
Subject: S_DEAD
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 24 Jan 2001 15:01:19 +0000
Message-ID: <10840.980348479@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What does IS_DEADDIR give us that (!(inode)->i_nlink) doesn't?

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
