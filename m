Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbUCINRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 08:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbUCINRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 08:17:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:49808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261909AbUCINRG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 08:17:06 -0500
Date: Tue, 9 Mar 2004 05:17:05 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200403091317.i29DH5hC016087@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.4-rc2 - 2004-03-08.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/stop_machine.c:85: warning: implicit declaration of function `sys_sched_setscheduler'
