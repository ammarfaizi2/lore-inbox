Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750823AbWFZQuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750823AbWFZQuT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 12:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWFZQq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 12:46:59 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:32229 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1750811AbWFZQqo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 12:46:44 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 3/4] [Suspend2] Correct kernel/power/smp.c credit.
Date: Tue, 27 Jun 2006 02:46:48 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060626164647.10641.37727.stgit@nigel.suspend2.net>
In-Reply-To: <20060626164637.10641.63979.stgit@nigel.suspend2.net>
References: <20060626164637.10641.63979.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Modify kernel/power/smp.c credit to my current address.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/power/smp.c b/kernel/power/smp.c
index 5957312..c102e7c 100644
--- a/kernel/power/smp.c
+++ b/kernel/power/smp.c
@@ -2,7 +2,7 @@
  * drivers/power/smp.c - Functions for stopping other CPUs.
  *
  * Copyright 2004 Pavel Machek <pavel@suse.cz>
- * Copyright (C) 2002-2003 Nigel Cunningham <ncunningham@clear.net.nz>
+ * Copyright (C) 2002-2003 Nigel Cunningham <nigel@suspend2.net>
  *
  * This file is released under the GPLv2.
  */

--
Nigel Cunningham		nigel at suspend2 dot net
