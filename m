Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267100AbUBMQhH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 11:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267101AbUBMQhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 11:37:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:46743 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267100AbUBMQhF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 11:37:05 -0500
From: john cherry <cherry@osdl.org>
Date: Fri, 13 Feb 2004 08:37:03 -0800
Message-Id: <200402131637.i1DGb3B19197@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3-rc2 - 2004-02-12.17.30) - 5 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/video/aty/radeon_base.c:1025: warning: `vclk_cntl' might be used uninitialized in this function
drivers/video/aty/radeon_base.c:1319: warning: `pll_output_freq' might be used uninitialized in this function
drivers/video/aty/radeon_base.c:474: warning: `xtal' might be used uninitialized in this function
drivers/video/aty/radeon_base.c:944: warning: `val2' might be used uninitialized in this function
make[3]: warning:  Clock skew detected.  Your build may be incomplete.
