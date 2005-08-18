Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750855AbVHRUU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750855AbVHRUU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 16:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbVHRUU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 16:20:27 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:8672 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1750855AbVHRUU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 16:20:26 -0400
Date: Thu, 18 Aug 2005 22:20:24 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add PCI ID for GeForce 6200 TurboCache(TM)
Message-ID: <20050818202024.GK18386@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	LKML <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] Add PCI ID for GeForce 6200 TurboCache(TM)

This adds the PCI ID for GeForce 6200 TurboCache(TM) as pointed out in
ftp://download.nvidia.com/XFree86/Linux-x86/1.0-7676/README.txt

Signed-off-by: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>

--- a/drivers/pci/pci.ids
+++ b/drivers/pci/pci.ids
@@ -3567,6 +3567,7 @@
 	0152  NV15BR [GeForce2 Ultra, Bladerunner]
 		1048 0c56  GLADIAC Ultra
 	0153  NV15GL [Quadro2 Pro]
+	0161  NV43 [GeForce 6200 TurboCache(TM)]
 	0170  NV17 [GeForce4 MX 460]
 	0171  NV17 [GeForce4 MX 440]
 		10b0 0002  Gainward Pro/600 TV
