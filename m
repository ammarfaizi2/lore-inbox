Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbUCDNmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 08:42:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261900AbUCDNli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 08:41:38 -0500
Received: from mail.math.uni-mannheim.de ([134.155.89.179]:14798 "EHLO
	mail.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261903AbUCDNk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 08:40:59 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix typo in Documentation/eisa.txt
Date: Thu, 4 Mar 2004 09:27:38 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403040927.38701.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.0-test9/Documentation/eisa.txt	2003-10-25 20:43:59.000000000 +0200
+++ linux-2.6.0-test9-eike/Documentation/eisa.txt	2003-11-12 09:29:47.000000000 +0100
@@ -171,7 +171,7 @@
 virtual_root.force_probe :
 
 Force the probing code to probe EISA slots even when it cannot find an
-EISA compliant mainboard (nothing appears on slot 0). Defaultd to 0
+EISA compliant mainboard (nothing appears on slot 0). Default to 0
 (don't force), and set to 1 (force probing) when either
 CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING are set.
 
