Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265207AbUGOAqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265207AbUGOAqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 20:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUGOAgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 20:36:03 -0400
Received: from mail.kroah.org ([69.55.234.183]:32640 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266052AbUGOAUB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 20:20:01 -0400
X-Donotread: and you are reading this why?
Subject: Re: [PATCH] Driver Core patches for 2.6.8-rc1
In-Reply-To: <10898507023964@kroah.com>
X-Patch: quite boring stuff, it's just source code...
Date: Wed, 14 Jul 2004 17:18:23 -0700
Message-Id: <10898507032528@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1757.22.7, 2004/06/30 09:59:10-07:00, greg@kroah.com

Driver Core: remove extra space in Kconfig file.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/base/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/base/Kconfig b/drivers/base/Kconfig
--- a/drivers/base/Kconfig	2004-07-14 17:12:26 -07:00
+++ b/drivers/base/Kconfig	2004-07-14 17:12:26 -07:00
@@ -18,7 +18,7 @@
 	  the kernel tree does.
 
 config DEBUG_DRIVER
-	 bool "Driver Core verbose debug messages"
+	bool "Driver Core verbose debug messages"
 	depends on DEBUG_KERNEL
 	help
 	  Say Y here if you want the Driver core to produce a bunch of

