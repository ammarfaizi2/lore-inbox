Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUJKNsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUJKNsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 09:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUJKNsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 09:48:01 -0400
Received: from cmail.srv.hcvlny.cv.net ([167.206.112.40]:3794 "EHLO
	cmail.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268955AbUJKNr7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 09:47:59 -0400
Date: Mon, 11 Oct 2004 08:45:26 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
Subject: [PATCH] Add mailing lists for Orinoco driver
X-X-Sender: proski@portland.hansa.lan
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Cc: David Gibson <hermes@gibson.dropbear.id.au>
Message-id: <Pine.LNX.4.61.0410110839190.4537@portland.hansa.lan>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch adds mailing lists for Orinoco driver and updates the homepage 
address.  Please apply.

Signed-off-by: Pavel Roskin <proski@gnu.org>

===============================================
--- MAINTAINERS
+++ MAINTAINERS
@@ -1646,7 +1646,9 @@
  M:	proski@gnu.org
  P:	David Gibson
  M:	hermes@gibson.dropbear.id.au
-W:	http://www.ozlabs.org/people/dgibson/dldwd
+L:	orinoco-devel@lists.sourceforge.net
+L:	orinoco-users@lists.sourceforge.net
+W:	http://www.nongnu.org/orinoco/
  S:	Maintained

  PARALLEL PORT SUPPORT
===============================================

-- 
Regards,
Pavel Roskin
