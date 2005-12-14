Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbVLNWRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbVLNWRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbVLNWRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:17:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11791 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965022AbVLNWRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:17:17 -0500
Date: Wed, 14 Dec 2005 23:17:17 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adobriyan@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] Documentation/ioctl-mess.txt: remove entry for non-existing TIOCGDEV
Message-ID: <20051214221717.GF23349@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason for listing a non-existing ioctl.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.15-rc5-mm2-full/Documentation/ioctl-mess.txt.old	2005-12-14 23:14:24.000000000 +0100
+++ linux-2.6.15-rc5-mm2-full/Documentation/ioctl-mess.txt	2005-12-14 23:14:31.000000000 +0100
@@ -3860,7 +3860,6 @@
 TIOCCBRK
 TIOCCONS
 TIOCEXCL
-TIOCGDEV
 
 N: TIOCGETC
 I: -

