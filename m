Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263087AbVFXEIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263087AbVFXEIM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263109AbVFXEFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:05:20 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263090AbVFXEEW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:22 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 01/14] IB/mthca: Add Sun copyright notice
In-Reply-To: <2005623214.eJuSN72mmScT1do9@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.8M2FOQ4JBL5cpK2n@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:20.0464 (UTC) FILETIME=[CC544700:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Duffy <tduffy@sun.com>

Add Sun copyright to files modified by Tom Duffy.

Signed-off-by: Tom Duffy <tduffy@sun.com>
Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_av.c       |    1 +
 linux.git/drivers/infiniband/hw/mthca/mthca_cq.c       |    1 +
 linux.git/drivers/infiniband/hw/mthca/mthca_dev.h      |    1 +
 linux.git/drivers/infiniband/hw/mthca/mthca_doorbell.h |    1 +
 linux.git/drivers/infiniband/hw/mthca/mthca_main.c     |    1 +
 linux.git/drivers/infiniband/hw/mthca/mthca_provider.c |    1 +
 6 files changed, 6 insertions(+)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_av.c	2005-06-23 13:03:02.393598985 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_av.c	2005-06-23 13:03:02.629547920 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-23 13:03:02.393598985 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_cq.c	2005-06-23 13:03:02.629547920 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-23 13:03:02.393598985 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_dev.h	2005-06-23 13:03:02.630547703 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_doorbell.h	2005-06-23 13:03:02.393598985 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_doorbell.h	2005-06-23 13:03:02.630547703 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-23 13:03:02.393598985 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_main.c	2005-06-23 13:03:02.630547703 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU
--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-23 13:03:02.393598985 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-23 13:03:02.629547920 -0700
@@ -1,5 +1,6 @@
 /*
  * Copyright (c) 2004, 2005 Topspin Communications.  All rights reserved.
+ * Copyright (c) 2005 Sun Microsystems, Inc. All rights reserved.
  *
  * This software is available to you under a choice of one of two
  * licenses.  You may choose to be licensed under the terms of the GNU

