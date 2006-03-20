Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbWCTQLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbWCTQLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWCTQLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:11:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:19608 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S966278AbWCTPOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 10:14:17 -0500
From: mchehab@infradead.org
To: linux-kernel@vger.kernel.org
Cc: linux-dvb-maintainer@linuxtv.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: [PATCH 038/141] V4L/DVB (3453a): Alters MAINTAINERS file to point
	to newer v4l-dvb email
Date: Mon, 20 Mar 2006 12:08:43 -0300
Message-id: <20060320150843.PS345453000038@infradead.org>
In-Reply-To: <20060320150819.PS760228000000@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 7bit
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab@infradead.org>
Date: 1138386722 -0200

- V4L/DVB Maintainers list changed. This patch alters the email to the
  new address.

Signed-off-by: Mauro Carvalho Chehab <mchehab@infradead.org>
# Acked-By: Johannes Stezenbach <js@linuxtv.org>
---

diff --git a/MAINTAINERS b/MAINTAINERS
diff --git a/MAINTAINERS b/MAINTAINERS
index 3f8a90a..7374be0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -540,7 +540,8 @@ S:	Supported
 
 BTTV VIDEO4LINUX DRIVER
 P:	Mauro Carvalho Chehab
-M:	mchehab@brturbo.com.br
+M:	mchehab@infradead.org
+M:	v4l-dvb-maintainer@linuxtv.org
 L:	video4linux-list@redhat.com
 W:	http://linuxtv.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
@@ -836,11 +837,12 @@ S:	Maintained
 
 DVB SUBSYSTEM AND DRIVERS
 P:	LinuxTV.org Project
-M: 	linux-dvb-maintainer@linuxtv.org
+M:	mchehab@infradead.org
+M:	v4l-dvb-maintainer@linuxtv.org
 L: 	linux-dvb@linuxtv.org (subscription required)
 W:	http://linuxtv.org/
 T:	git kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
-S:	Supported
+S:	Maintained
 
 EATA-DMA SCSI DRIVER
 P:	Michael Neuffer
@@ -2946,7 +2948,8 @@ S:      Maintained
 
 VIDEO FOR LINUX
 P:	Mauro Carvalho Chehab
-M:	mchehab@brturbo.com.br
+M:	mchehab@infradead.org
+M:	v4l-dvb-maintainer@linuxtv.org
 L:	video4linux-list@redhat.com
 W:	http://linuxtv.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git

