Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269221AbUI3OcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269221AbUI3OcP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 10:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269297AbUI3OcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 10:32:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:5796 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269303AbUI3OcH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 10:32:07 -0400
Date: Thu, 30 Sep 2004 07:32:03 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200409301432.i8UEW3Fn029396@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc3 - 2004-09-29.21.30) - 10 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Warning: "isdn_ppp_register_compressor" [drivers/isdn/i4l/isdn_bsdcomp.ko] undefined!
*** Warning: "isdn_ppp_unregister_compressor" [drivers/isdn/i4l/isdn_bsdcomp.ko] undefined!
*** Warning: "register_isdn" [drivers/isdn/act2000/act2000.ko] undefined!
*** Warning: "register_isdn" [drivers/isdn/capi/capidrv.ko] undefined!
*** Warning: "register_isdn" [drivers/isdn/hisax/hisax.ko] undefined!
*** Warning: "register_isdn" [drivers/isdn/icn/icn.ko] undefined!
*** Warning: "register_isdn" [drivers/isdn/pcbit/pcbit.ko] undefined!
*** Warning: "register_isdn" [drivers/isdn/sc/sc.ko] undefined!
*** Warning: "register_isdn" [drivers/isdn/tpam/tpam.ko] undefined!
drivers/net/wan/pc300_tty.c:704: warning: passing arg 1 of `tty_ldisc_ref' from incompatible pointer type
