Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967883AbWLEAP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967883AbWLEAP4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 19:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936571AbWLEAP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 19:15:56 -0500
Received: from www.polish-dvd.com ([69.222.0.225]:43202 "HELO
	mail.webhostingstar.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S936544AbWLEAPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 19:15:55 -0500
Message-ID: <20061204180731.jeedbekf4f0g8ww0@69.222.0.225>
Date: Mon, 04 Dec 2006 18:07:31 -0600
From: art@usfltd.com
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: 2.6.19 git compile error - "current_is_keventd"
	[drivers/net/phy/libphy.ko] undefined
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Internet Messaging Program (IMP) H3 (4.1.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to: linux-kernel@vger.kernel.org
cc: torvalds@osdl.org

2006/12/04/18:00 CST

   Building modules, stage 2.
Kernel: arch/x86_64/boot/bzImage is ready  (#2)
   MODPOST 1256 modules
WARNING: "current_is_keventd" [drivers/net/phy/libphy.ko] undefined!
make[1]: *** [__modpost] Error 1
make: *** [modules] Error 2

xboom
