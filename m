Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266964AbUAXPxc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 10:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266968AbUAXPxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 10:53:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:19943 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266964AbUAXPxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 10:53:08 -0500
From: john cherry <cherry@osdl.org>
Date: Sat, 24 Jan 2004 07:53:06 -0800
Message-Id: <200401241553.i0OFr6L26588@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.2-rc1 - 2004-01-23.17.30) - 1 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/xfs/xfs_log_recover.c:1534: warning: `flags' might be used uninitialized in this function
