Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbVC0TJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbVC0TJt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbVC0TJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:09:28 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:30648 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261456AbVC0TJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:09:02 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] typo fix in Documentation/eisa.txt
Date: Sun, 27 Mar 2005 15:54:43 +0200
User-Agent: KMail/1.8
Cc: Trivial Patch Monkey <trivial@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503271554.44382.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial typo fix.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.0-test9/Documentation/eisa.txt	2003-10-25 20:43:59.000000000 +0200
+++ linux-2.6.0-test9-eike/Documentation/eisa.txt	2003-11-12 09:29:47.000000000 +0100
@@ -171,7 +171,7 @@
 virtual_root.force_probe :
 
 Force the probing code to probe EISA slots even when it cannot find an
-EISA compliant mainboard (nothing appears on slot 0). Defaultd to 0
+EISA compliant mainboard (nothing appears on slot 0). Default to 0
 (don't force), and set to 1 (force probing) when either
 CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING are set.
 
