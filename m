Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932553AbWF0Ep7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbWF0Ep7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 00:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933430AbWF0Ems
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 00:42:48 -0400
Received: from cust9421.vic01.dataco.com.au ([203.171.70.205]:53723 "EHLO
	nigel.suspend2.net") by vger.kernel.org with ESMTP id S1030694AbWF0Emb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 00:42:31 -0400
From: Nigel Cunningham <nigel@suspend2.net>
Subject: [Suspend2][ 01/13] [Suspend2] Suspend2 version header.
Date: Tue, 27 Jun 2006 14:42:29 +1000
To: linux-kernel@vger.kernel.org
Message-Id: <20060627044228.15066.27529.stgit@nigel.suspend2.net>
In-Reply-To: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
References: <20060627044226.15066.7403.stgit@nigel.suspend2.net>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Header declaring the suspend2 version.

Signed-off-by: Nigel Cunningham <nigel@suspend2.net>

 kernel/power/version.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/kernel/power/version.h b/kernel/power/version.h
new file mode 100644
index 0000000..4a8b6c4
--- /dev/null
+++ b/kernel/power/version.h
@@ -0,0 +1,10 @@
+/*
+ * kernel/power/version.h
+ *
+ * Copyright 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ */
+
+#define SUSPEND_CORE_VERSION "2.2.6.1"
+#define name_suspend "Suspend2 " SUSPEND_CORE_VERSION ": "

--
Nigel Cunningham		nigel at suspend2 dot net
