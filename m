Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266936AbUBMK4V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266937AbUBMK4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:56:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:59033 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266936AbUBMK4V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:56:21 -0500
Date: Fri, 13 Feb 2004 02:56:19 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402131056.i1DAuJ4b032640@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.3-rc2 - 2004-02-12.22.30) - 4 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/video/aty/radeon_base.c:1025: warning: `vclk_cntl' might be used uninitialized in this function
drivers/video/aty/radeon_base.c:1319: warning: `pll_output_freq' might be used uninitialized in this function
drivers/video/aty/radeon_base.c:474: warning: `xtal' might be used uninitialized in this function
drivers/video/aty/radeon_base.c:944: warning: `val2' might be used uninitialized in this function
