Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTJFVUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbTJFVUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:20:55 -0400
Received: from fw.osdl.org ([65.172.181.6]:65458 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261769AbTJFVUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:20:54 -0400
Subject: AI32 (2.6.0-test6+) - 3 new warnings over the weekend
From: John Cherry <cherry@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065475250.21161.29.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 06 Oct 2003 14:20:51 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/linux/toshiba.h:37: warning: `tosh_get_info' declared `static'
but never defined

drivers/serial/8250_acpi.c:32: warning: long unsigned int format,
different type arg (arg 3)
drivers/serial/8250_acpi.c:32: warning: long unsigned int format,
different type arg (arg 4)

