Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUHXPTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUHXPTg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 11:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267993AbUHXPTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 11:19:35 -0400
Received: from fw.osdl.org ([65.172.181.6]:16309 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267987AbUHXPTa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 11:19:30 -0400
Date: Tue, 24 Aug 2004 08:19:28 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200408241519.i7OFJS6S027910@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.8.1 - 2004-08-23.21.30) - 3 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/BusLogic.c:2976: warning: `BusLogic_AbortCommand' defined but not used
security/selinux/hooks.c:2825: warning: `ret' might be used uninitialized in this function
security/selinux/hooks.c:2886: warning: `ret' might be used uninitialized in this function
