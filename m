Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265073AbUFVSHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbUFVSHQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 14:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265058AbUFVSFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 14:05:51 -0400
Received: from mail.kroah.org ([65.200.24.183]:39349 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265057AbUFVRnY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:43:24 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.7
In-Reply-To: <10879261103670@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Tue, 22 Jun 2004 10:41:50 -0700
Message-Id: <10879261104131@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1722.89.55, 2004/06/04 16:48:04-07:00, greg@kroah.com

Driver core: finally add a MAINTAINERS entry for it.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+)


diff -Nru a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS	Tue Jun 22 09:48:00 2004
+++ b/MAINTAINERS	Tue Jun 22 09:48:00 2004
@@ -689,6 +689,12 @@
 L:	blinux-list@redhat.com
 S:	Maintained
 
+DRIVER CORE, KOBJECTS, AND SYSFS
+P:	Greg Kroah-Hartman
+M:	greg@kroah.com
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+
 DRM DRIVERS
 L:	dri-devel@lists.sourceforge.net
 S:	Supported

