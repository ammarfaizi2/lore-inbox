Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVC0VTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVC0VTs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVC0VTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:19:48 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:51728 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261562AbVC0VTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:19:38 -0500
Date: Sun, 27 Mar 2005 23:19:36 +0200
From: Adrian Bunk <bunk@stusta.de>
To: oliver@neukum.name
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] MAINTAINERS: remove obsolete HPUSBSCSI entry
Message-ID: <20050327211936.GG4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems I forgot MAINTAINERS in my patch that removed this driver...

Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.6.12-rc1-mm3-full/MAINTAINERS.old	2005-03-27 23:17:59.000000000 +0200
+++ linux-2.6.12-rc1-mm3-full/MAINTAINERS	2005-03-27 23:18:07.000000000 +0200
@@ -998,11 +998,6 @@
 W:	http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
 S:	Maintained
 
-HPUSBSCSI
-P:	Oliver Neukum
-M:	oliver@neukum.name
-S:	Maintained
-
 HUGETLB FILESYSTEM
 P:	William Irwin
 M:	wli@holomorphy.com

