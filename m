Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264957AbUF1N0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264957AbUF1N0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 09:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUF1N0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 09:26:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:17637 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264941AbUF1N0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 09:26:31 -0400
Date: Mon, 28 Jun 2004 06:26:29 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200406281326.i5SDQTCB013940@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.7 - 2004-06-27.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/ipmi/ipmi_si_intf.c:1174: warning: passing arg 4 of `acpi_install_gpe_handler' from incompatible pointer type
drivers/char/ipmi/ipmi_si_intf.c:1194: warning: passing arg 3 of `acpi_remove_gpe_handler' from incompatible pointer type
