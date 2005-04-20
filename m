Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVDTRSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVDTRSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 13:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVDTRSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 13:18:43 -0400
Received: from ns1.coraid.com ([65.14.39.133]:20648 "EHLO coraid.com")
	by vger.kernel.org with ESMTP id S261746AbVDTRRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 13:17:32 -0400
To: linux-kernel@vger.kernel.org
CC: ecashin@coraid.com, Greg K-H <greg@kroah.com>
References: <874qe1pejv.fsf@coraid.com>
Subject: [PATCH 2.6.12-rc2] aoe [6/6]: update version number to 10
From: Ed L Cashin <ecashin@coraid.com>
Date: Wed, 20 Apr 2005 13:06:08 -0400
Message-ID: <877jixnzsv.fsf@coraid.com>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


update version number to 10

Signed-off-by: Ed L. Cashin <ecashin@coraid.com>

--- b/drivers/block/aoe/aoe.h	2005-04-20 11:42:19.000000000 -0400
+++ b/drivers/block/aoe/aoe.h	2005-04-20 11:42:22.000000000 -0400
@@ -1,5 +1,5 @@
 /* Copyright (c) 2004 Coraid, Inc.  See COPYING for GPL terms. */
-#define VERSION "6"
+#define VERSION "10"
 #define AOE_MAJOR 152
 #define DEVICE_NAME "aoe"
 


-- 
  Ed L. Cashin <ecashin@coraid.com>

