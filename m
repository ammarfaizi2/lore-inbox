Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUKDLjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUKDLjk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 06:39:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbUKDLh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 06:37:27 -0500
Received: from sd291.sivit.org ([194.146.225.122]:27353 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S262165AbUKDLSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 06:18:06 -0500
Date: Thu, 4 Nov 2004 12:18:22 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 11/12] meye: bump up the version number
Message-ID: <20041104111822.GQ3472@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041104111231.GF3472@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104111231.GF3472@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

===================================================================

ChangeSet@1.2350, 2004-11-02 16:34:21+01:00, stelian@popies.net
  meye: bump up the version number
  
  Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

 meye.h |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

===================================================================

diff -Nru a/drivers/media/video/meye.h b/drivers/media/video/meye.h
--- a/drivers/media/video/meye.h	2004-11-04 11:36:28 +01:00
+++ b/drivers/media/video/meye.h	2004-11-04 11:36:28 +01:00
@@ -31,7 +31,7 @@
 #define _MEYE_PRIV_H_
 
 #define MEYE_DRIVER_MAJORVERSION	 1
-#define MEYE_DRIVER_MINORVERSION	10
+#define MEYE_DRIVER_MINORVERSION	11
 
 #define MEYE_DRIVER_VERSION __stringify(MEYE_DRIVER_MAJORVERSION) "." \
 			    __stringify(MEYE_DRIVER_MINORVERSION)
