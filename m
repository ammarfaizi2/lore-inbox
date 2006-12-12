Return-Path: <linux-kernel-owner+w=401wt.eu-S932077AbWLLGiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWLLGiq (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 01:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWLLGiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 01:38:46 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:65072 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932077AbWLLGip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 01:38:45 -0500
Message-ID: <457E4E72.9040505@bx.jp.nec.com>
Date: Tue, 12 Dec 2006 15:38:42 +0900
From: Keiichi KII <k-keiichi@bx.jp.nec.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: mpm@selenic.com
CC: linux-kernel@vger.kernel.org
Subject: [RFC][PATCH 2.6.19 6/6] update modification history
References: <457E498C.1050806@bx.jp.nec.com>
In-Reply-To: <457E498C.1050806@bx.jp.nec.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Keiichi KII <k-keiichi@bx.jp.nec.com>

Update modification history.

Signed-off-by: Keiichi KII <k-keiichi@bx.jp.nec.com>
---
--- linux-2.6.19/drivers/net/netconsole.c	2006-12-12 14:57:45.588967500 +0900
+++ enhanced-netconsole/drivers/net/netconsole.c.sign	2006-12-12
14:54:49.541965250 +0900
@@ -15,6 +15,9 @@
  *               generic card hooks
  *               works non-modular
  * 2003-09-07    rewritten with netpoll api
+ * 2006-12-12    add extended features for
+ *               dynamic configurable netconsole
+ *               by Keiichi KII <k-keiichi@bx.jp.nec.com>
  */

 /****************************************************************

-- 
Keiichi KII
NEC Corporation OSS Promotion Center
E-mail: k-keiichi@bx.jp.nec.com
