Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271045AbTGVXOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 19:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271050AbTGVXOh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 19:14:37 -0400
Received: from straightnochaser.mr.itd.umich.edu ([141.211.125.39]:46025 "EHLO
	straightnochaser.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S271045AbTGVXOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 19:14:31 -0400
Subject: Very High Latency
From: Mohamed El Ayouty <melayout@umich.edu>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1058916330.4012.5.camel@syKr0n.mine.nu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 22 Jul 2003 19:25:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using the latest Gnome, 2.3.4 with Mozilla and Xmms, and 2.6.0-test1 I
experience hangups and very high latency when Mozilla is retrieving a
page and XMMS is playing, which is evident from the pauses in music.
This gets worse when I'm compiling something in the background.

But once I switch back to 2.4.20-ck6, everything runs normal even under
5 minute compiles.

Also, I have low latency on in 2.6.0-test1.

Am I missing a setting or is the scheduler still buggy?

If you need more info, email me.

-- 
Mohamed El Ayouty

***********************
* melayout@umich.edu  *
***********************


