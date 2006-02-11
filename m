Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWBKQcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWBKQcl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 11:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932150AbWBKQcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 11:32:41 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:42507 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932096AbWBKQck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 11:32:40 -0500
Date: Sat, 11 Feb 2006 17:32:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Scott_Kilau@digi.com, wendyx@us.ltcfwd.linux.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/serial/Kconfig: remove reference to non-existing Documentation/jsm.txt
Message-ID: <20060211163238.GB30922@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's no reason pointing users to non-existing documentation.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.16-rc2-mm1-full/drivers/serial/Kconfig.old	2006-02-11 17:29:34.000000000 +0100
+++ linux-2.6.16-rc2-mm1-full/drivers/serial/Kconfig	2006-02-11 17:29:50.000000000 +0100
@@ -902,8 +902,6 @@
 	  something like this to connect more than two modems to your Linux
 	  box, for instance in order to become a dial-in server. This driver
 	  supports PCI boards only.
-	  If you have a card like this, say Y here and read the file
-	  <file:Documentation/jsm.txt>.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called jsm.

