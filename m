Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267189AbSKSSnw>; Tue, 19 Nov 2002 13:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267182AbSKSSmR>; Tue, 19 Nov 2002 13:42:17 -0500
Received: from air-2.osdl.org ([65.172.181.6]:14464 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267185AbSKSSmJ>;
	Tue, 19 Nov 2002 13:42:09 -0500
Date: Tue, 19 Nov 2002 10:49:10 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Remove unused variable from utdebug.c
Message-ID: <20021119184910.GF1986@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/acpi/utilities/utdebug.c b/drivers/acpi/utilities/utdebug.c
--- a/drivers/acpi/utilities/utdebug.c	Tue Nov 19 10:31:17 2002
+++ b/drivers/acpi/utilities/utdebug.c	Tue Nov 19 10:31:17 2002
@@ -27,7 +27,6 @@
 #include "acpi.h"
 
 #define _COMPONENT          ACPI_UTILITIES
-	 ACPI_MODULE_NAME    ("utdebug")
 
 
 #ifdef ACPI_DEBUG_OUTPUT

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
