Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbWC1TMN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbWC1TMN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 14:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWC1TMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 14:12:13 -0500
Received: from mail.gmx.de ([213.165.64.20]:53141 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932096AbWC1TMM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 14:12:12 -0500
X-Authenticated: #9163084
Date: Tue, 28 Mar 2006 22:12:23 +0200
From: Marko <letterdrop@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Who wants to test cracklinux??
Message-Id: <20060328221223.80753cab.letterdrop@gmx.de>
X-Mailer: Sylpheed version 2.2.1 (GTK+ 2.8.13; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I've written a small kernel module & shared object for kernel 2.6 to
enable the following for normal users:

- inb()/outb()... via a wrapper function
- enable direct IO access (like ioperm())
- direct access on physical memory addresses
- installation of user space ISR
- change nice level

The module is primary thought for education, but perhaps also helpful
in software development.
The module is finished now, but because it's my first kernel code
there could be something to improve. If anyone wants to test, just
send me a mail and you'll get the code.

Thanks,

Marko Euth
