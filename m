Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266325AbUBQQxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266326AbUBQQxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:53:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:31627 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266325AbUBQQxL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:53:11 -0500
From: john cherry <cherry@osdl.org>
Date: Tue, 17 Feb 2004 08:53:08 -0800
Message-Id: <200402171653.i1HGr8C27949@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3-rc3 - 2004-02-16.17.30) - 2 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/video/aty/radeon_base.c:227: warning: `common_regs_m6' defined but not used
make[1]: warning:  Clock skew detected.  Your build may be incomplete.
