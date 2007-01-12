Return-Path: <linux-kernel-owner+w=401wt.eu-S1751591AbXALENw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbXALENw (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 23:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751597AbXALENv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 23:13:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:26634 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588AbXALENu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 23:13:50 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:date:message-id:in-reply-to:references:subject;
        b=Ea51piqNgQ6eKnyWaJP+5qIKMqbTvp8Xp+HSg256gIbUEXvZsvvq0NoKTo5pXkjWldT1ylfpT3hih2pSdYHKDBgLbj3ivbqA82kZFoCoa5WhdIp5yx3cJjPX9eGREoWaPCXlAKTklWNDKuh8W5M05SY8vnYkyUHMjKnVq1Zw4+0=
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       linux-kernel@vger.kernel.org
Date: Fri, 12 Jan 2007 05:17:26 +0100
Message-Id: <20070112041726.28755.11371.sendpatchset@localhost.localdomain>
In-Reply-To: <20070112041720.28755.49663.sendpatchset@localhost.localdomain>
References: <20070112041720.28755.49663.sendpatchset@localhost.localdomain>
Subject: [PATCH 1/19] ide: update MAINTAINERS entry
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] ide: update MAINTAINERS entry

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 MAINTAINERS |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

Index: my-2.6/MAINTAINERS
===================================================================
--- my-2.6.orig/MAINTAINERS
+++ my-2.6/MAINTAINERS
@@ -1585,12 +1585,11 @@ M:	ipslinux@adaptec.com
 W:	http://www.developer.ibm.com/welcome/netfinity/serveraid.html
 S:	Supported 
 
-IDE DRIVER [GENERAL]
+IDE SUBSYSTEM
 P:	Bartlomiej Zolnierkiewicz
-M:	B.Zolnierkiewicz@elka.pw.edu.pl
-L:	linux-kernel@vger.kernel.org
+M:	bzolnier@gmail.com
 L:	linux-ide@vger.kernel.org
-T:	git kernel.org:/pub/scm/linux/kernel/git/bart/ide-2.6.git
+T:	quilt kernel.org/pub/linux/kernel/people/bart/pata-2.6/
 S:	Maintained
 
 IDE/ATAPI CDROM DRIVER
