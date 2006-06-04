Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWFDCQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWFDCQM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 22:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbWFDCQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 22:16:12 -0400
Received: from [198.99.130.12] ([198.99.130.12]:39597 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751400AbWFDCQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 22:16:10 -0400
Message-Id: <200606040216.k542GBfm004822@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 0/6] UML - small fixes and cleanups for 2.6.17
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Jun 2006 22:16:10 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches are small changes which either fix important bugs or
which have no functional effect.

The first one, which adds include/asm-um/irqflags.h should go to mainline
when (or if) the lock validator does.

				Jeff

