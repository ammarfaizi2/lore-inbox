Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272552AbTGaP7x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272553AbTGaP7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:59:53 -0400
Received: from mail.msi.umn.edu ([128.101.190.10]:10910 "EHLO mail.msi.umn.edu")
	by vger.kernel.org with ESMTP id S272552AbTGaP7w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:59:52 -0400
Date: Thu, 31 Jul 2003 10:59:52 -0500
From: Michael Bakos <bakhos@msi.umn.edu>
To: <linux-kernel@vger.kernel.org>
Subject: compile error for Opteron CPU with kernel 2.6.0-test2
Message-ID: <Pine.SGI.4.33.0307311058320.17528-100000@ir12.msi.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel version: 2.6.0-test2
CPU type: x86-64 (Opteron)
Problem: Can not successfuly do: make bzImage

For process.c:
It says that the file asm/local.h is missing, and errors out in module.h
at line 175, parse error before local_t

Michael Bakhos


