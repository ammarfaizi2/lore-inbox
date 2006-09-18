Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbWIRUhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbWIRUhE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWIRUhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:37:04 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:22995 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S964950AbWIRUhB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:37:01 -0400
Date: Mon, 18 Sep 2006 22:32:15 +0200
From: Andreas Herrmann <aherrman@de.ibm.com>
To: James Bottomley <jejb@steeleye.com>
Cc: Linux SCSI <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 6/6] zfcp: update maintainers file
Message-ID: <20060918203215.GA10519@lion28.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zfcp: update maintainers file

Removed myself as maintainer of the s390 zfcp driver --
I will not maintain it any longer.

Signed-off-by: Andreas Herrmann <aherrman@de.ibm.com>
---
 MAINTAINERS |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25cd707..aef694a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2459,8 +2459,6 @@ W:	http://www.ibm.com/developerworks/lin
 S:	Supported
 
 S390 ZFCP DRIVER
-P:	Andreas Herrmann
-M:	aherrman@de.ibm.com
 M:	linux390@de.ibm.com
 L:	linux-390@vm.marist.edu
 W:	http://www.ibm.com/developerworks/linux/linux390/
-- 
1.4.2.1.g80823

