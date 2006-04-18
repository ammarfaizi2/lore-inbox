Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWDRPRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWDRPRv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWDRPRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:17:51 -0400
Received: from rwcrmhc12.comcast.net ([204.127.192.82]:43736 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932094AbWDRPRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:17:51 -0400
Date: Tue, 18 Apr 2006 10:17:49 -0500
From: Corey Minyard <minyard@acm.org>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] Add myself as the IPMI maintainer
Message-ID: <20060418151749.GA14220@i2.minyard.local>
Reply-To: minyard@acm.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as the IPMI maintainer.

Signed-off-by: Corey Minyard <minyard@acm.org>

Index: linux-2.6.16/MAINTAINERS
===================================================================
--- linux-2.6.16.orig/MAINTAINERS
+++ linux-2.6.16/MAINTAINERS
@@ -1405,6 +1405,13 @@ P:	Juanjo Ciarlante
 M:	jjciarla@raiz.uncu.edu.ar
 S:	Maintained
 
+IPMI SUBSYSTEM
+P:	Corey Minyard
+M:	minyard@acm.org
+L:	openipmi-developer@lists.sourceforge.net
+W:	http://openipmi.sourceforge.net/
+S:	Supported
+
 IPX NETWORK LAYER
 P:	Arnaldo Carvalho de Melo
 M:	acme@conectiva.com.br
