Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbTJBGU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 02:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTJBGU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 02:20:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:16791 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263258AbTJBGU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 02:20:26 -0400
Date: Wed, 1 Oct 2003 23:20:25 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200310020620.h926KPg3000687@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/cpu/cpufreq/powernow-k8.c:38:2: warning: #warning this driver has not been tested on a preempt system
