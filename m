Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030334AbWFUW5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030334AbWFUW5z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 18:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751517AbWFUW5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 18:57:55 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:27915 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751509AbWFUW5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 18:57:54 -0400
Date: Thu, 22 Jun 2006 00:57:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: urban@teststation.com, samba@samba.org
Subject: [2.6 patch] smb is no onger maintained
Message-ID: <20060621225753.GR9111@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The smb filesystem in the Linux kernel is unmaintained for years.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm1-full/MAINTAINERS.old	2006-06-22 00:55:48.000000000 +0200
+++ linux-2.6.17-mm1-full/MAINTAINERS	2006-06-22 00:56:05.000000000 +0200
@@ -2591,13 +2591,6 @@
 W:	http://www.winischhofer.at/linuxsisusbvga.shtml
 S:	Maintained
 
-SMB FILESYSTEM
-P:	Urban Widmark
-M:	urban@teststation.com
-W:	http://samba.org/
-L:	samba@samba.org
-S:	Maintained
-
 SMC91x ETHERNET DRIVER
 P:	Nicolas Pitre
 M:	nico@cam.org

