Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbTJHGeG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 02:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTJHGeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 02:34:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:29840 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261152AbTJHGeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 02:34:05 -0400
Date: Tue, 7 Oct 2003 23:34:03 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200310080634.h986Y3aH006384@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.0-test6 - 2003-10-07.18.30) - 4 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/cpu/cpufreq/longhaul.h:237: warning: `nehemiah_clock_ratio' defined but not used
arch/i386/kernel/cpu/cpufreq/longhaul.h:273: warning: `nehemiah_eblcr' defined but not used
arch/i386/kernel/cpu/cpufreq/powernow-k8.c:938:2: warning: #warning pol->policy is in undefined state here
drivers/media/video/bttv-if.c:257: warning: comparison of distinct pointer types lacks a cast
