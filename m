Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932592AbWHCVmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932592AbWHCVmV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 17:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932590AbWHCVmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 17:42:21 -0400
Received: from cantor2.suse.de ([195.135.220.15]:7401 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932592AbWHCVmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 17:42:20 -0400
Subject: patch add-stable-branch-to-maintainers-file.patch added to gregkh-2.6 tree
To: rostedt@goodmis.org, akpm@osdl.org, chrisw@sous-sol.org, greg@kroah.com,
       gregkh@suse.de, linux-kernel@vger.kernel.org
From: <gregkh@suse.de>
Date: Thu, 03 Aug 2006 14:37:40 -0700
In-Reply-To: <1154622491.32264.37.camel@localhost.localdomain>
Message-Id: <20060803214211.71CD581B866@imap.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: Add stable branch to maintainers file

to my gregkh-2.6 tree.  Its filename is

     add-stable-branch-to-maintainers-file.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


>From stable-bounces@linux.kernel.org Thu Aug  3 09:28:46 2006
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 03 Aug 2006 12:28:11 -0400
Message-Id: <1154622491.32264.37.camel@localhost.localdomain>
Cc: Chris Wright <chrisw@sous-sol.org>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Add stable branch to maintainers file

From: Steven Rostedt <rostedt@goodmis.org>

While helping someone to submit a patch to the stable branch, I noticed
that the stable branch is not listed in the MAINTAINERS file.  This was
after I went there to look for the email addresses for the stable branch
list (stable@kernel.org).

This patch adds the stable branch to the maintainers file so that people
can find where to send patches when they have a fix for the stable team.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

--- gregkh-2.6.orig/MAINTAINERS
+++ gregkh-2.6/MAINTAINERS
@@ -2641,6 +2641,14 @@ M:	dbrownell@users.sourceforge.net
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


Patches currently in gregkh-2.6 which might be from rostedt@goodmis.org are

driver/add-stable-branch-to-maintainers-file.patch
