Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbTKLIbA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 03:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbTKLIbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 03:31:00 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:43684 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S261796AbTKLIa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 03:30:59 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Typo in Documentation/eisa.txt
Date: Wed, 12 Nov 2003 09:33:04 +0100
User-Agent: KMail/1.5.4
Cc: Marc Zyngier <maz@wild-wind.fr.eu.org>, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311120933.04860@bilbo.math.uni-mannheim.de>
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
 
