Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUGCN3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUGCN3o (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 09:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265093AbUGCN3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 09:29:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:5867 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265091AbUGCN3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 09:29:44 -0400
Date: Sat, 3 Jul 2004 06:29:43 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200407031329.i63DThfm013989@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.7 - 2004-07-02.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/apm.c:1221: warning: implicit declaration of function `save_processor_state'
arch/i386/kernel/apm.c:1223: warning: implicit declaration of function `restore_processor_state'
