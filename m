Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbUBFLWh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 06:22:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265420AbUBFLWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 06:22:37 -0500
Received: from fw.osdl.org ([65.172.181.6]:3250 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265401AbUBFLWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 06:22:36 -0500
Date: Fri, 6 Feb 2004 03:22:35 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402061122.i16BMZ10009537@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/ne.c:168: warning: unused variable `irq'
drivers/scsi/imm.c:1146: warning: `ports' might be used uninitialized in this function
drivers/scsi/ppa.c:1006: warning: `ports' might be used uninitialized in this function
