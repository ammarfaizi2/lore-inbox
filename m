Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266248AbUA2QYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 11:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266232AbUA2QYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 11:24:39 -0500
Received: from fw.osdl.org ([65.172.181.6]:3994 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266248AbUA2QYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 11:24:38 -0500
From: john cherry <cherry@osdl.org>
Date: Thu, 29 Jan 2004 08:24:35 -0800
Message-Id: <200401291624.i0TGOZY27672@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.2-rc2 - 2004-01-28.17.30) - 2 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/usb/gadget/net2280.c:1681: warning: unsigned int format, different type arg (arg 4)
drivers/usb/gadget/net2280.c:478:2: warning: #warning Using dma_alloc_coherent even with buffers smaller than a page.
