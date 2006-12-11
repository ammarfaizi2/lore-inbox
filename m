Return-Path: <linux-kernel-owner+w=401wt.eu-S1762749AbWLKKTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762749AbWLKKTQ (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 05:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762751AbWLKKTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 05:19:15 -0500
Received: from il.qumranet.com ([62.219.232.206]:45735 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762749AbWLKKTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 05:19:15 -0500
Subject: [PATCH 5/5] KVM: Add MAINTAINERS entry
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 11 Dec 2006 10:19:13 -0000
To: kvm-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
References: <457D2F6B.8070809@qumranet.com>
In-Reply-To: <457D2F6B.8070809@qumranet.com>
Message-Id: <20061211101913.DC0BB2500CF@il.qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Avi Kivity <avi@qumranet.com>

Index: linux-2.6/MAINTAINERS
===================================================================
--- linux-2.6.orig/MAINTAINERS
+++ linux-2.6/MAINTAINERS
@@ -1745,6 +1745,13 @@ W:	http://nfs.sourceforge.net/
 W:	http://www.cse.unsw.edu.au/~neilb/patches/linux-devel/
 S:	Maintained
 
+KERNEL VIRTUAL MACHINE (KVM)
+P:	Avi Kivity
+M:	avi@qumranet.com
+L:	kvm-devel@lists.sourceforge.net
+W:	kvm.sourceforge.net
+S:	Supported
+
 KEXEC
 P:	Eric Biederman
 M:	ebiederm@xmission.com
