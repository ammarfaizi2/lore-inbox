Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbUBULEM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Feb 2004 06:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbUBULEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Feb 2004 06:04:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:8665 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261545AbUBULEL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Feb 2004 06:04:11 -0500
Date: Sat, 21 Feb 2004 03:04:10 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402211104.i1LB4Apw017111@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.3 - 2004-02-20.22.30) - 3 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

*** Warning: Overriding SUBDIRS on the command line can cause
drivers/i2c/busses/i2c-elv.c:155: warning: unsigned int format, long int arg (arg 2)
drivers/i2c/busses/i2c-velleman.c:141: warning: unsigned int format, long int arg (arg 2)
