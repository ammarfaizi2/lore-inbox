Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129337AbQKHGrl>; Wed, 8 Nov 2000 01:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129459AbQKHGrb>; Wed, 8 Nov 2000 01:47:31 -0500
Received: from rigel.cs.pdx.edu ([131.252.208.59]:38038 "EHLO rigel.cs.pdx.edu")
	by vger.kernel.org with ESMTP id <S129337AbQKHGrQ>;
	Wed, 8 Nov 2000 01:47:16 -0500
Date: Tue, 7 Nov 2000 22:47:13 -0800 (PST)
From: Naren Devaiah <naren@cs.pdx.edu>
To: linux-kernel@vger.kernel.org
Subject: Purpose of inode->i_atomic_write in 2.2.x
Message-ID: <Pine.GSO.4.21.0011072243270.25929-100000@antares.cs.pdx.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could somebody tell me why inode->i_atomic_write is used in 2.2.x?
And also why this is absent in 2.4.x (actually replaced by ->i_zombie)?

Thanks,
Naren


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
