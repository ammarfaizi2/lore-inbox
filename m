Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbTJMN7h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 09:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTJMN7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 09:59:37 -0400
Received: from pop.gmx.net ([213.165.64.20]:4815 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261749AbTJMN7g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 09:59:36 -0400
X-Authenticated: #555711
From: "Sebastian Piecha" <spi@gmxpro.de>
To: linux-kernel@vger.kernel.org
Date: Mon, 13 Oct 2003 15:59:38 +0200
MIME-Version: 1.0
Subject: How to wait for kernel messages?
Message-ID: <3F8ACBEA.5414.1072DA2C@localhost>
X-mailer: Pegasus Mail for Windows (v4.12a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some problems with one NIC. Due to lack of time as an 
workaround I'd like to wait for the kernel message "NETDEV WATCHDOG: 
eth0: transmit timed out" and ifconfig down/up the NIC.

How can I trigger any action by such a kernel message? Do I have to 
grep the kernel log?

Mit freundlichen Gruessen/Best regards,
Sebastian Piecha

EMail: spi@gmxpro.de

