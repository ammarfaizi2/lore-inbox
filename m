Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267142AbSKSSje>; Tue, 19 Nov 2002 13:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267152AbSKSSje>; Tue, 19 Nov 2002 13:39:34 -0500
Received: from air-2.osdl.org ([65.172.181.6]:12160 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267142AbSKSSin>;
	Tue, 19 Nov 2002 13:38:43 -0500
Date: Tue, 19 Nov 2002 10:45:44 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Remove unused variable from nsxfname.c
Message-ID: <20021119184544.GC1986@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -Nru a/drivers/acpi/namespace/nsxfname.c b/drivers/acpi/namespace/nsxfname.c
--- a/drivers/acpi/namespace/nsxfname.c	Tue Nov 19 10:31:17 2002
+++ b/drivers/acpi/namespace/nsxfname.c	Tue Nov 19 10:31:17 2002
@@ -30,7 +30,6 @@
 
 
 #define _COMPONENT          ACPI_NAMESPACE
-	 ACPI_MODULE_NAME    ("nsxfname")
 
 
 /****************************************************************************
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
