Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbUGFEKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbUGFEKG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 00:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUGFEKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 00:10:06 -0400
Received: from inetmg01.sony.com.sg ([202.42.154.67]:54084 "EHLO
	inetmg01.sony.com.sg") by vger.kernel.org with ESMTP
	id S263003AbUGFEKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 00:10:01 -0400
Subject: Regarding Kernel 2.6.5
From: Manjunath <manjunath.n@ap.sony.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: SONY
Message-Id: <1089087274.5155.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 06 Jul 2004 09:44:34 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

I tried to build Kernel 2.6.5 on Fedora Core 1.
make modules_install gives me this error

depmod: *** Unresolved symbols in
/lib/modules/2.6.5-gcov/kernel/net/irda/irnet/irnet.ko
depmod:         irttp_open_tsap
depmod:         iriap_getvaluebyclass_request
depmod:         irda_notify_init
make: *** [_modinst_post] Error 1

On Fedora Core 1.

Regards
Manju

