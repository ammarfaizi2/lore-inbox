Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVCGVGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVCGVGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261318AbVCGUxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:53:14 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:9394 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261809AbVCGUNe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:34 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [28/many] arch: i386 config
In-Reply-To: <11102278562068@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:36 +0300
Message-Id: <11102278563623@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:24 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- ./arch/i386/Kconfig~	2005-03-02 10:37:49.000000000 +0300
+++ ./arch/i386/Kconfig	2005-03-07 20:52:47.000000000 +0300
@@ -1214,6 +1214,8 @@
 
 source "crypto/Kconfig"
 
+source "acrypto/Kconfig"
+
 source "lib/Kconfig"
 
 #

