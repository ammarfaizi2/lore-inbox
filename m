Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262370AbUEOMn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUEOMn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 08:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUEOMn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 08:43:58 -0400
Received: from fw.osdl.org ([65.172.181.6]:38295 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262370AbUEOMn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 08:43:57 -0400
Date: Sat, 15 May 2004 05:43:55 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200405151243.i4FChtH3004328@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.6 - 2004-05-14.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/usb/gadget/serial.c:162: warning: `debug' defined but not used
drivers/usb/serial/console.c:140: warning: implicit declaration of function `serial_paranoia_check'
