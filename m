Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261486AbUJXOIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbUJXOIR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 10:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbUJXOIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 10:08:17 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:3857 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261486AbUJXOIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 10:08:06 -0400
Date: Sun, 24 Oct 2004 16:07:34 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>, jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch] add SCSI_SATA_ULI help text
Message-ID: <20041024140734.GE4216@stusta.de>
References: <20041022185953.GA4886@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022185953.GA4886@logos.cnet>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 04:59:53PM -0200, Marcelo Tosatti wrote:
>...
> Summary of changes from v2.4.28-pre4 to v2.4.28-rc1
> ============================================
>...
> Jeff Garzik:
>...
>   o [libata] add sata_uli driver for ULi (formerly ALi) SATA
>...


#include <no/help/text.h>


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.4.28-rc1-full/Documentation/Configure.help.old	2004-10-24 16:03:07.000000000 +0200
+++ linux-2.4.28-rc1-full/Documentation/Configure.help	2004-10-24 16:04:11.000000000 +0200
@@ -9354,6 +9354,11 @@
 
   If unsure, say N.
 
+CONFIG_SCSI_SATA_ULI
+  This option enables support for ULi Electronics SATA.
+
+  If unsure, say N.
+
 CONFIG_SCSI_SATA_VIA
   This option enables support for VIA Serial ATA.
 

