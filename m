Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262926AbUJ1K2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262926AbUJ1K2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 06:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262887AbUJ1K1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 06:27:23 -0400
Received: from sd291.sivit.org ([194.146.225.122]:52630 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262898AbUJ1KJB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 06:09:01 -0400
Date: Thu, 28 Oct 2004 12:10:28 +0200
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 8/8] sonypi: bump up the version number
Message-ID: <20041028101027.GI3893@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
References: <20041028100525.GA3893@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028100525.GA3893@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2198, 2004-10-28 10:54:14+02:00, stelian@popies.net
  sonypi: bump up the version number

  Signed-off-by: Stelian Pop <stelian@popies.net>
  
===================================================================

 sonypi.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/char/sonypi.h b/drivers/char/sonypi.h
--- a/drivers/char/sonypi.h	2004-10-28 11:20:55 +02:00
+++ b/drivers/char/sonypi.h	2004-10-28 11:20:55 +02:00
@@ -36,7 +36,7 @@
 
 #ifdef __KERNEL__
 
-#define SONYPI_DRIVER_VERSION	 "1.23"
+#define SONYPI_DRIVER_VERSION	 "1.24"
 
 #define SONYPI_DEVICE_MODEL_TYPE1	1
 #define SONYPI_DEVICE_MODEL_TYPE2	2
