Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279292AbRJWG5m>; Tue, 23 Oct 2001 02:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279295AbRJWG5c>; Tue, 23 Oct 2001 02:57:32 -0400
Received: from cx552039-a.elcjn1.sdca.home.com ([24.177.44.17]:8905 "EHLO
	tigger.unnerving.org") by vger.kernel.org with ESMTP
	id <S279292AbRJWG5N>; Tue, 23 Oct 2001 02:57:13 -0400
Date: Mon, 22 Oct 2001 23:57:40 -0700 (PDT)
From: Gregory Ade <gkade@bigbrother.net>
X-X-Sender: <gkade@tigger.unnerving.org>
To: Alan Cox <laughing@shared-source.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Linux 2.4.12-ac5 typo
In-Reply-To: <20011022004549.A32210@lightning.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0110222342200.9744-100000@tigger.unnerving.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure why i haven't seen a patch for this one yet, or why it seems
nobody else has said anything, but here's a typo fix for 2.4.12-ac5.

-- 
Gregory K. Ade <gkade@unnerving.org>
http://unnerving.org/~gkade
OpenPGP Key ID: EAF4844B  keyserver: pgpkeys.mit.edu



diff -u --new-file --recursive linux-2.4.12-ac5.orig/net/ipv4/ipconfig.c linux-2.4.12-ac5/net/ipv4/ipconfig.c
--- linux-2.4.12-ac5.orig/net/ipv4/ipconfig.c	Mon Oct 22 23:26:32 2001
+++ linux-2.4.12-ac5/net/ipv4/ipconfig.c	Mon Oct 22 23:53:11 2001
@@ -53,7 +53,7 @@

 #include <asm/uaccess.h>
 #include <asm/checksum.h>
-#inclued <asm/processor.h>
+#include <asm/processor.h>

 /* Define this to allow debugging output */
 #undef IPCONFIG_DEBUG

