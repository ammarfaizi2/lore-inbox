Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVCGVQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVCGVQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 16:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbVCGVPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 16:15:12 -0500
Received: from mailer.campus.mipt.ru ([194.85.82.4]:15794 "EHLO
	mailer.campus.mipt.ru") by vger.kernel.org with ESMTP
	id S261819AbVCGUNi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 15:13:38 -0500
Cc: Fruhwirth Clemens <clemens@endorphin.org>,
       Herbert Xu <herbert@gondor.apana.org.au>, cryptoapi@lists.logix.cz,
       James Morris <jmorris@redhat.com>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: [22/many] arch: alpha config
In-Reply-To: <11102278551512@2ka.mipt.ru>
X-Mailer: gregkh_patchbomb
Date: Mon, 7 Mar 2005 23:37:36 +0300
Message-Id: <1110227856415@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (mailer.campus.mipt.ru [194.85.82.4]); Mon, 07 Mar 2005 23:11:25 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- ./arch/alpha/Kconfig~	2005-03-02 10:38:38.000000000 +0300
+++ ./arch/alpha/Kconfig	2005-03-07 21:25:54.000000000 +0300
@@ -602,5 +602,7 @@
 
 source "crypto/Kconfig"
 
+source "acrypto/Kconfig"
+
 source "lib/Kconfig"
 

