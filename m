Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbUBQLlm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 06:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266118AbUBQLlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 06:41:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:23212 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266114AbUBQLlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 06:41:15 -0500
Date: Tue, 17 Feb 2004 03:41:13 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402171141.i1HBfDmC011838@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.3-rc4 - 2004-02-16.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/video/aty/radeon_base.c:227: warning: `common_regs_m6' defined but not used
