Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbVC0T7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbVC0T7Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 14:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVC0T7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 14:59:25 -0500
Received: from mail.sf-mail.de ([62.27.20.61]:17363 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S261497AbVC0T7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 14:59:21 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [PATCH] typo fix in Documentation/eisa.txt
Date: Sun, 27 Mar 2005 22:01:33 +0200
User-Agent: KMail/1.8
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
References: <200503271554.44382.eike-kernel@sf-tec.de> <200503272145.10266.eike-kernel@sf-tec.de> <42470E99.7010304@osdl.org>
In-Reply-To: <42470E99.7010304@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503272201.36092.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Typo fixes.

Thanks to Randy Dunlap and Jean Delvare.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

--- linux-2.6.11/Documentation/eisa.txt	2005-03-02 08:38:12.000000000 +0100
+++ linux-2.6.12-rc1/Documentation/eisa.txt	2005-03-27 21:58:04.000000000 +0200
@@ -171,9 +171,9 @@
 virtual_root.force_probe :
 
 Force the probing code to probe EISA slots even when it cannot find an
-EISA compliant mainboard (nothing appears on slot 0). Defaultd to 0
-(don't force), and set to 1 (force probing) when either
-CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING are set.
+EISA compliant mainboard (nothing appears on slot 0). Defaults to 0
+(don't force) and set to 1 (force probing) when either
+CONFIG_ALPHA_JENSEN or CONFIG_EISA_VLB_PRIMING is set.
 
 ** Random notes :
 
