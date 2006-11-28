Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935873AbWK1Llo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935873AbWK1Llo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 06:41:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935874AbWK1Llo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 06:41:44 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:56081 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S935873AbWK1Lln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 06:41:43 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-rc6-mm2
Date: Tue, 28 Nov 2006 12:41:10 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <20061128020246.47e481eb.akpm@osdl.org> <200611281235.45087.m.kozlowski@tuxland.pl>
In-Reply-To: <200611281235.45087.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611281241.10693.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

	Agrrh ... tab/spaces thing again. Sorry. Second try:
 
Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

--- linux-2.6.19-rc6-mm2-a/kernel/module.c	2006-11-28 12:17:09.000000000 +0100
+++ linux-2.6.19-rc6-mm2-b/kernel/module.c	2006-11-28 12:05:01.000000000 +0100
@@ -849,8 +849,8 @@ static inline void module_unload_init(st
 static struct module_attribute *modinfo_attrs[] = {
 	&modinfo_version,
 	&modinfo_srcversion,
-	&initstate,
 #ifdef CONFIG_MODULE_UNLOAD
+	&initstate,
 	&refcnt,
 #endif
 	NULL,

-- 
Regards,

	Mariusz Kozlowski
