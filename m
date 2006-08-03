Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbWHCQ2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbWHCQ2r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWHCQ2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:28:47 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:47843 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964840AbWHCQ2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:28:46 -0400
Subject: [PATCH] Add stable branch to maintainers file
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chris Wright <chrisw@sous-sol.org>, stable@kernel.org
Content-Type: text/plain
Date: Thu, 03 Aug 2006 12:28:11 -0400
Message-Id: <1154622491.32264.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While helping someone to submit a patch to the stable branch, I noticed
that the stable branch is not listed in the MAINTAINERS file.  This was
after I went there to look for the email addresses for the stable branch
list (stable@kernel.org).

This patch adds the stable branch to the maintainers file so that people
can find where to send patches when they have a fix for the stable team.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

Index: linux-2.6.18-rc3/MAINTAINERS
===================================================================
--- linux-2.6.18-rc3.orig/MAINTAINERS	2006-08-03 11:40:39.000000000 -0400
+++ linux-2.6.18-rc3/MAINTAINERS	2006-08-03 12:18:03.000000000 -0400
@@ -2626,6 +2626,14 @@ M:	dbrownell@users.sourceforge.net
 L:	spi-devel-general@lists.sourceforge.net
 S:	Maintained
 
+STABLE BRANCH:
+P:	Greg Kroah-Hartman
+M:	greg@kroah.com
+P:	Chris Wright
+M:	chrisw@sous-sol.org
+L:	stable@kernel.org
+S:	Maintained
+
 TPM DEVICE DRIVER
 P:	Kylene Hall
 M:	kjhall@us.ibm.com


