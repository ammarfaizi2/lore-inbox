Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWAIRQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWAIRQO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWAIRQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:16:14 -0500
Received: from [81.2.110.250] ([81.2.110.250]:63631 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S964883AbWAIRQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:16:13 -0500
Subject: PATCH: Remove dead project
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Jan 2006 17:19:10 +0000
Message-Id: <1136827150.6659.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.15-mm2/MAINTAINERS linux-2.6.15-mm2/MAINTAINERS
--- linux.vanilla-2.6.15-mm2/MAINTAINERS	2006-01-09 14:33:47.000000000 +0000
+++ linux-2.6.15-mm2/MAINTAINERS	2006-01-09 14:51:00.000000000 +0000
@@ -2394,13 +2394,6 @@
 M:	nico@cam.org
 S:	Maintained
 
-SNA NETWORK LAYER
-P:	Jay Schulist
-M:	jschlst@samba.org
-L:	linux-sna@turbolinux.com
-W:	http://www.linux-sna.org
-S:	Supported
-
 SOFTWARE RAID (Multiple Disks) SUPPORT
 P:	Ingo Molnar
 M:	mingo@redhat.com

