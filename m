Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030509AbVKWXtE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbVKWXtE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 18:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVKWXrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 18:47:41 -0500
Received: from mail.kroah.org ([69.55.234.183]:33730 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751335AbVKWXqf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 18:46:35 -0500
Date: Wed, 23 Nov 2005 15:43:57 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       jwboyer@gmail.com
Subject: [patch 02/22] MTD git tree location added to MAINTAINERS
Message-ID: <20051123234357.GC527@kroah.com>
References: <20051123225156.624397000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="mtd-git-tree-location-added-to-maintainers.patch"
In-Reply-To: <20051123234335.GA527@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Boyer <jwboyer@gmail.com>

Here's the MTD one.  More later as I find them.

Signed-off-by: Josh Boyer <jwboyer@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

diff --git a/MAINTAINERS b/MAINTAINERS
index c5cf7d7..1e84be3 100644
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

--- usb-2.6.orig/MAINTAINERS
+++ usb-2.6/MAINTAINERS
@@ -1695,6 +1695,7 @@ P:	David Woodhouse
 M:	dwmw2@infradead.org
 W:	http://www.linux-mtd.infradead.org/
 L:	linux-mtd@lists.infradead.org
+T:	git kernel.org:/pub/scm/linux/kernel/git/tglx/mtd-2.6.git
 S:	Maintained
 
 MICROTEK X6 SCANNER

--
