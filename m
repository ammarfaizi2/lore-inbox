Return-Path: <linux-kernel-owner+w=401wt.eu-S1751400AbWLLOyA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWLLOyA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 09:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWLLOyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 09:54:00 -0500
Received: from mx1.redhat.com ([66.187.233.31]:52215 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400AbWLLOx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 09:53:59 -0500
Date: Tue, 12 Dec 2006 09:53:57 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: corbet@lwn.net
Subject: Jon needs a new shift key.
Message-ID: <20061212145357.GA32217@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>, corbet@lwn.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.19.noarch/drivers/media/video/ov7670.c~	2006-12-12 09:53:10.000000000 -0500
+++ linux-2.6.19.noarch/drivers/media/video/ov7670.c	2006-12-12 09:53:18.000000000 -0500
@@ -18,7 +18,7 @@
 #include <linux/i2c.h>
 
 
-MODULE_AUTHOR("Jonathan Corbet <corbet@lwn.net.");
+MODULE_AUTHOR("Jonathan Corbet <corbet@lwn.net>");
 MODULE_DESCRIPTION("A low-level driver for OmniVision ov7670 sensors");
 MODULE_LICENSE("GPL");
 
-- 
http://www.codemonkey.org.uk
