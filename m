Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbTFSX0o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 19:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTFSX0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 19:26:43 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:63875 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261932AbTFSXZn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 19:25:43 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10560659723370@kroah.com>
Subject: Re: [PATCH] PCI changes and fixes for 2.5.72
In-Reply-To: <10560659721049@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 19 Jun 2003 16:39:32 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1362, 2003/06/19 16:12:34-07:00, greg@kroah.com

PCI: well, everyone is treating me like the maintainer...

And Martin has said he doesn't want to do it for 2.5/2.6


 MAINTAINERS |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Thu Jun 19 16:31:59 2003
+++ b/MAINTAINERS	Thu Jun 19 16:31:59 2003
@@ -1429,10 +1429,10 @@
 S:	Maintained
 
 PCI SUBSYSTEM
-P:	Martin Mares
-M:	mj@ucw.cz
+P:	Greg Kroah-Hartman
+M:	greg@kroah.com
 L:	linux-kernel@vger.kernel.org
-S:	Odd Fixes
+S:	Supported
 
 PCI HOTPLUG CORE
 P:	Greg Kroah-Hartman

