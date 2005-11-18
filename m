Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161016AbVKRRr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161016AbVKRRr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 12:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbVKRRrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 12:47:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:48362 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161016AbVKRRqu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 12:46:50 -0500
Date: Fri, 18 Nov 2005 09:31:15 -0800
From: Greg Kroah-Hartman <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [patch 3/3] update Documentation/00-INDEX
Message-ID: <20051118173115.GD20860@kroah.com>
References: <20051118173930.270902000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="update-docs-index.patch"
In-Reply-To: <20051118173054.GA20860@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg Kroah-Hartman <gregkh@suse.de>

Update the index file with descriptions of the stable_api_nonsense.txt
and stable_kernel_rules.txt files.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 Documentation/00-INDEX |    4 ++++
 1 file changed, 4 insertions(+)

--- usb-2.6.orig/Documentation/00-INDEX
+++ usb-2.6/Documentation/00-INDEX
@@ -258,6 +258,10 @@ specialix.txt
 	- info on hardware/driver for specialix IO8+ multiport serial card.
 spinlocks.txt
 	- info on using spinlocks to provide exclusive access in kernel.
+stable_api_nonsense.txt
+	- info on why the kernel does not have a stable in-kernel api or abi.
+stable_kernel_rules.txt
+	- rules and procedures for the -stable kernel releases.
 stallion.txt
 	- info on using the Stallion multiport serial driver.
 svga.txt

--
