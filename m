Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVCGVQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVCGVQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVCGVPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:15:50 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:17586 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261822AbVCGUNl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:41 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [31/many] arch: m68k config
In-Reply-To: <1110227857550@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:37 +0300
Message-Id: <11102278573212@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- ./arch/m68k/Kconfig~	2005-03-02 10:38:10.000000000 +0300
+++ ./arch/m68k/Kconfig	2005-03-07 21:28:12.000000000 +0300
@@ -667,4 +667,6 @@
 
 source "crypto/Kconfig"
 
+source "acrypto/Kconfig"
+
 source "lib/Kconfig"

