Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270244AbTHGTKI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270338AbTHGTKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:10:08 -0400
Received: from [213.4.129.129] ([213.4.129.129]:38180 "EHLO tsmtp6.mail.isp")
	by vger.kernel.org with ESMTP id S270244AbTHGTKF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:10:05 -0400
Date: Thu, 7 Aug 2003 21:09:22 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <diegocg@teleline.es>
To: Hans Reiser <reiser@namesys.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: Filesystem Tests
Message-Id: <20030807210922.24c77cc9.diegocg@teleline.es>
In-Reply-To: <3F324C4D.9000008@namesys.com>
References: <3F306858.1040202@mrs.umn.edu>
	<20030805224152.528f2244.akpm@osdl.org>
	<3F310B6D.6010608@namesys.com>
	<20030806183410.49edfa89.diegocg@teleline.es>
	<3F324C4D.9000008@namesys.com>
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 07 Aug 2003 16:55:41 +0400 Hans Reiser <reiser@namesys.com> escribió:

> Run fsck on a 1 terabyte array while a department waits for their server 
> to come back up instead of having it back in 90 seconds and.....

To start, some people don't need data safety.

> 
> disk speeds have increased linearly while their capacity has increased 
> quadratically.

It's useful as you say to show how slow is ext3 compared with ext2, between
other things. Also, it looks that ext2 scales really well. Benchmarks are not
there to show how fast and nice your reiser4 is compared with others
(there's no doubt reiser4 is pretty nice BTW). People are developing other
filesystems, you know.


