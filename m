Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266344AbUHNKUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266344AbUHNKUj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 06:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUHNKUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 06:20:35 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:47016 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S266344AbUHNKUd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 06:20:33 -0400
Date: Sat, 14 Aug 2004 12:19:19 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: [patch 2.6.8-rc4-mm1] via-velocity: wrong module name in Kconfig documentation
Message-ID: <20040814101919.GA18040@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408132303090.5277@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Copy/paste abuse.

diff -puN drivers/net/Kconfig~via-velocity-kconfig-copy-paste-abuse drivers/net/Kconfig
--- linux-2.6.8-rc4/drivers/net/Kconfig~via-velocity-kconfig-copy-paste-abuse	2004-08-14 12:11:16.000000000 +0200
+++ linux-2.6.8-rc4-fr/drivers/net/Kconfig	2004-08-14 12:11:16.000000000 +0200
@@ -1752,7 +1752,7 @@ config VIA_VELOCITY
 	  If you have a VIA "Velocity" based network card say Y here.
 
 	  To compile this driver as a module, choose M here. The module
-	  will be called via-rhine.
+	  will be called via-velocity.
 
 config LAN_SAA9730
 	bool "Philips SAA9730 Ethernet support (EXPERIMENTAL)"

_
