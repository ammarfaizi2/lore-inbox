Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264553AbUAXLNv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 06:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266908AbUAXLNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 06:13:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:59821 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264553AbUAXLNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 06:13:51 -0500
Date: Sat, 24 Jan 2004 03:13:49 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200401241113.i0OBDnfH017530@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.2-rc1 - 2004-01-23.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/kernel/dmi_scan.c:287: warning: `apm_is_horked_d850md' defined but not used
fs/xfs/xfs_log_recover.c:1534: warning: `flags' might be used uninitialized in this function
