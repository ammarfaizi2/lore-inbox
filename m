Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266703AbUHOO1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266703AbUHOO1H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 10:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUHOO1G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 10:27:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:51903 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266703AbUHOO1F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 10:27:05 -0400
Date: Sun, 15 Aug 2004 07:27:03 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200408151427.i7FER3es031319@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.8.1 - 2004-08-14.21.30) - 4 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/ipmi/ipmi_si_intf.c:1173: warning: passing arg 4 of `acpi_install_gpe_handler' from incompatible pointer type
drivers/char/ipmi/ipmi_si_intf.c:1193: warning: passing arg 3 of `acpi_remove_gpe_handler' from incompatible pointer type
init/main.c:99: warning: function declaration isn't a prototype
init/main.c:99: warning: return type defaults to `int'
