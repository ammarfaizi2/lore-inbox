Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262620AbTELUIF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 16:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbTELUIF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 16:08:05 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:26083 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262620AbTELUIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 16:08:04 -0400
Date: Mon, 12 May 2003 22:18:49 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: typo in acpi thermal managment
Message-ID: <20030512201849.GA10034@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I hope it is not too trivial. It certainly looks ugly.

								Pavel

Index: linux/drivers/acpi/thermal.c
===================================================================
--- linux.orig/drivers/acpi/thermal.c	2003-05-06 19:31:11.000000000 +0200
+++ linux/drivers/acpi/thermal.c	2003-04-18 16:13:58.000000000 +0200
@@ -430,7 +430,7 @@
 	ACPI_FUNCTION_TRACE("acpi_thermal_call_usermode");
 
 	if (!path)
-		return_VALUE(-EINVAL);;
+		return_VALUE(-EINVAL);
 
 	argv[0] = path;
 


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
