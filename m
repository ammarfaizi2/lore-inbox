Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbTEWGqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 02:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTEWGqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 02:46:13 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:62872 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S263658AbTEWGqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 02:46:12 -0400
Date: Thu, 22 May 2003 23:59:17 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] net/sunrpc/svcauth.c trivial header fix
Message-ID: <20030522235917.A18236@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

not used

--- linux-2.5.69/net/sunrpc/svcauth.c.orig	Thu May 22 23:57:04 2003
+++ linux-2.5.69/net/sunrpc/svcauth.c	Thu May 22 23:57:29 2003
@@ -15,7 +15,6 @@
 #include <linux/sunrpc/xdr.h>
 #include <linux/sunrpc/svcsock.h>
 #include <linux/sunrpc/svcauth.h>
-#include <linux/err.h>
 #include <linux/hash.h>
 
 #define RPCDBG_FACILITY	RPCDBG_AUTH
