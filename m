Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265273AbTLRUFh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 15:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbTLRUFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 15:05:36 -0500
Received: from smtp.terra.es ([213.4.129.129]:49445 "EHLO tsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S265273AbTLRUFd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 15:05:33 -0500
From: Albert Astals Cid <tsdgeos@terra.es>
To: linux-kernel@vger.kernel.org
Subject: Spelling patch
Date: Thu, 18 Dec 2003 21:05:42 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312182105.42305.tsdgeos@terra.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know spelling is not that crucial, but it helps to have things spelled the 
right way.

--- drivers/char/drm/Kconfig.old        2003-12-18 20:51:29.000000000 +0100
+++ drivers/char/drm/Kconfig    2003-12-18 20:51:45.000000000 +0100
@@ -77,7 +77,7 @@
        tristate "SiS video cards"
        depends on DRM && AGP
        help
-         Choose this option if you have a SiS 630 or compatibel video
+         Choose this option if you have a SiS 630 or compatible video
           chipset. If M is selected the module will be called sis. AGP
           support is required for this driver to work.

