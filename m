Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932169AbWDYJ0D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932169AbWDYJ0D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWDYJ0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:26:03 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:9088 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932169AbWDYJ0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:26:01 -0400
Subject: Re: [PATCH 02/02] Process Events - License Change
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Nguyen Anh Quynh <aquynh@gmail.com>
In-Reply-To: <1145956109.28976.133.camel@stark>
References: <1145956109.28976.133.camel@stark>
Content-Type: text/plain
Date: Tue, 25 Apr 2006 02:12:30 -0700
Message-Id: <1145956350.28976.141.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the license on the process event structure passed between kernel and
userspace.

Signed-off-by: Matt Helsley <matthltc@us.ibm.com>

--

Index: linux-2.6.17-rc2/include/linux/cn_proc.h
===================================================================
--- linux-2.6.17-rc2.orig/include/linux/cn_proc.h
+++ linux-2.6.17-rc2/include/linux/cn_proc.h
@@ -1,27 +1,20 @@
 /*
  * cn_proc.h - process events connector
  *
  * Copyright (C) Matt Helsley, IBM Corp. 2005
  * Based on cn_fork.h by Nguyen Anh Quynh and Guillaume Thouvenin
- * Original copyright notice follows:
  * Copyright (C) 2005 Nguyen Anh Quynh <aquynh@gmail.com>
  * Copyright (C) 2005 Guillaume Thouvenin <guillaume.thouvenin@bull.net>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of version 2.1 of the GNU Lesser General Public License
+ * as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  */
 
 #ifndef CN_PROC_H
 #define CN_PROC_H
 


