Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130406AbQLTXzG>; Wed, 20 Dec 2000 18:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbQLTXy4>; Wed, 20 Dec 2000 18:54:56 -0500
Received: from host212-140-202-8.btinteractive.net ([212.140.202.8]:58294 "EHLO
	argo.dyndns.org") by vger.kernel.org with ESMTP id <S130406AbQLTXyw>;
	Wed, 20 Dec 2000 18:54:52 -0500
X-test: X
To: linux-kernel@vger.kernel.org
From: lk@mailandnews.com
Subject: CPRM copy protection for ATA drives
Date: 20 Dec 2000 23:23:48 +0000
Message-ID: <m3lmtazngb.fsf@fork.man2.dom>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I read this article on theregister today:
http://www.theregister.co.uk/content/2/15620.html
Does anyone have any details on this? I presume that the drive
firmware is capable of identifying copy-protected data during
a write. I also presume that nobody on lkml would condone
such a terrible idea. I imagine that this system is pretty
easy to defeat if you can modify the filesystem. Perhaps even
a ROT13 modification to ext2 would be sufficient?

The consequences of being able to corrupt other people's backups
by introducing "copy-protected" data are intriguing...

Paul
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
