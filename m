Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261757AbVCGUwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVCGUwq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 15:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbVCGUwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 15:52:12 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:5298 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261802AbVCGUNb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:31 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [43/many] arch: v850 config
In-Reply-To: <11102278582468@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:38 +0300
Message-Id: <11102278583370@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:24 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- ./arch/v850/Kconfig~	2005-03-02 10:38:08.000000000 +0300
+++ ./arch/v850/Kconfig	2005-03-07 21:31:12.000000000 +0300
@@ -311,6 +311,8 @@
 
 source "crypto/Kconfig"
 
+source "acrypto/Kconfig"
+
 source "lib/Kconfig"
 
 #############################################################################

