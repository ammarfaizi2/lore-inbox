Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264246AbUEaNUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264246AbUEaNUL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 09:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbUEaNUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 09:20:11 -0400
Received: from ammi.mclink.it ([195.110.128.1]:31754 "EHLO ammi.mclink.it")
	by vger.kernel.org with ESMTP id S264246AbUEaNUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 09:20:02 -0400
Date: Mon, 31 May 2004 15:20:01 +0200 (CEST)
From: Marco Fioretti <mfioretti@mclink.it>
To: linux-kernel@vger.kernel.org
Subject: How to make cardbus pci1130 work with kernel 2.4?
Message-Id: <1.0.2.200405311519.68186@mclink.it>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="---_____________20040531151968186.mclink.it_____--"
X-Mailer: Easy-MAIL v1.02 - http://www.mclink.it/
Organization: MC-link the world online
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
Questo e' un messaggio multi parte in formato MIME.

-----_____________20040531151968186.mclink.it_____--
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit




-----_____________20040531151968186.mclink.it_____--
Content-Type: message/rfc822
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Received: from ammi.mclink.it (ammi.mclink.it [195.110.128.1])
	by mailhub2.mclink.it (8.12.3/8.12.3) with ESMTP id i4VD83bn051492
	for <mfioretti@mclink.it>; Mon, 31 May 2004 15:08:03 +0200 (CEST)
	(envelope-from mfioretti@mclink.it)
Received: from ammi.mclink.it (localhost [127.0.0.1])
	by ammi.mclink.it (8.12.6/8.12.6) with ESMTP id i4VD83jG058473;
	Mon, 31 May 2004 15:08:03 +0200 (CEST)
	(envelope-from mfioretti@mclink.it)
Received: (from root@localhost)
	by ammi.mclink.it (8.12.6/8.12.6/Submit) id i4VD83p9058472;
	Mon, 31 May 2004 15:08:03 +0200 (CEST)
Date: Mon, 31 May 2004 15:08:03 +0200 (CEST)
From: Marco Fioretti <mfioretti@mclink.it>
To: linux-kernel@vger.rutgers.edu
Cc: mfioretti@mclink.it
Subject: How to make cardbus pci1130 work with kernel 2.4?
Message-Id: <1.0.2.200405311507.63996@mclink.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
X-Mailer: Easy-MAIL v1.02 - http://www.mclink.it/
Organization: MC-link the world online


Hello,

I am looking for config files, kernel or boot
options, *anything* to help me to make the cardbus
bridge TI PCI1130 work with Red hat 9, or anything with
2.4 kernel.

Right now, lspci outpout says that its two pins
get both assigned interrupts 255. After that, it just
doesn't see any pcmcia card I plug in.

*If* possible, any workaround, however ugly, would
be preferable to recompiling stuff, since I have
only quite old and slow HW available these days.
If the solution does need patching the kernel, so be
it, please let me know it anyway.

Of course, don't hesitate to ask for any test I need to
run, which command output you need and so on.

Thank you in advance for any feedback!

Marco Fioretti


-----_____________20040531151968186.mclink.it_____----
