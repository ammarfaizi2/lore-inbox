Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261792AbVAHFr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbVAHFr6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261811AbVAHFr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:47:58 -0500
Received: from mail.kroah.org ([69.55.234.183]:14725 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261792AbVAHFrw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:47:52 -0500
Subject: Re: [PATCH] USB and Driver Core patches for 2.6.10
In-Reply-To: <1105163269703@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 7 Jan 2005 21:47:49 -0800
Message-Id: <11051632693187@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2251, 2005/01/07 15:19:51-08:00, greg@kroah.com

Fix up udev url in Documentation/Changes file

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/Changes |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)


diff -Nru a/Documentation/Changes b/Documentation/Changes
--- a/Documentation/Changes	2005-01-07 15:33:42 -08:00
+++ b/Documentation/Changes	2005-01-07 15:33:42 -08:00
@@ -223,10 +223,10 @@
 version v0.99.0 or higher. Running old versions may cause problems
 with programs using shared memory.
 
-Udev
+udev
 ----
-Udev is a userspace application for populating /dev dynamically with
-only entries for devices actually present. Udev replaces devfs.
+udev is a userspace application for populating /dev dynamically with
+only entries for devices actually present. udev replaces devfs.
 
 Networking
 ==========
@@ -373,9 +373,9 @@
 ----------
 o  <http://powertweak.sourceforge.net/>
 
-Udev
+udev
 ----
-o <http://www.kernel.org/pub/linux/utils/kernel/hotplug/>
+o <http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html>
 
 Networking
 **********

