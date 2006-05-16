Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWEPPuu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWEPPuu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWEPPuu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:50:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:25535 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751273AbWEPPut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:50:49 -0400
Subject: PATCH: Clarify maintainers and include linux-security info
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@osdl.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 16 May 2006 17:03:41 +0100
Message-Id: <1147795421.2151.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

--- linux-2.6.17-rc4/MAINTAINERS~	2006-05-16 16:38:42.034901424 +0100
+++ linux-2.6.17-rc4/MAINTAINERS	2006-05-16 16:38:42.034901424 +0100
@@ -44,7 +44,11 @@
 	do changes at work you may find your employer owns the patch
 	not you.
 
-7.	Happy hacking.
+7.	When sending security related changes or reports to a maintainer
+	please Cc: linux-security@kernel.org, especially if the maintainer
+	does not respond.
+
+8.	Happy hacking.
 
  		-----------------------------------
 

