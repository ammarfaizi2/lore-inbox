Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbUCVNv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 08:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbUCVNv3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 08:51:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:25819 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261982AbUCVNv2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 08:51:28 -0500
Date: Mon, 22 Mar 2004 05:51:24 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200403221351.i2MDpO6C012019@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.5-rc2 - 2004-03-21.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/isdn/hardware/eicon/dlist.c:54: warning: `diva_q_find' defined but not used
drivers/isdn/hardware/eicon/dlist.c:73: warning: `diva_q_get_next' defined but not used
