Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267164AbSKSSlk>; Tue, 19 Nov 2002 13:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbSKSSlj>; Tue, 19 Nov 2002 13:41:39 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13696 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267164AbSKSSlM>;
	Tue, 19 Nov 2002 13:41:12 -0500
Date: Tue, 19 Nov 2002 10:48:15 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Remove unused variable from rsdump.c
Message-ID: <20021119184815.GE1986@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/acpi/resources/rsdump.c b/drivers/acpi/resources/rsdump.c
--- a/drivers/acpi/resources/rsdump.c	Tue Nov 19 10:31:17 2002
+++ b/drivers/acpi/resources/rsdump.c	Tue Nov 19 10:31:17 2002
@@ -28,7 +28,6 @@
 #include "acresrc.h"
 
 #define _COMPONENT          ACPI_RESOURCES
-	 ACPI_MODULE_NAME    ("rsdump")
 
 
 #if defined(ACPI_DEBUG_OUTPUT) || defined(ACPI_DEBUGGER)

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
