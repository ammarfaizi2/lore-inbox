Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262104AbSIYUOb>; Wed, 25 Sep 2002 16:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262108AbSIYUOb>; Wed, 25 Sep 2002 16:14:31 -0400
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262104AbSIYUOa>;
	Wed, 25 Sep 2002 16:14:30 -0400
Date: Wed, 25 Sep 2002 20:51:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: ACPI: kill extra whitespace
Message-ID: <20020925185108.GA765@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Tiny patch..
							Pavel

--- clean/include/linux/acpi.h	2002-09-22 23:47:01.000000000 +0200
+++ linux-swsusp/include/linux/acpi.h	2002-09-22 23:53:34.000000000 +0200
@@ -365,9 +365,7 @@
 extern int acpi_mp_config;
 
 #else
-
 #define acpi_mp_config	0
-
 #endif
 
 

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
