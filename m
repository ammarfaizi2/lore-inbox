Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266970AbUBGQnv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 11:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266975AbUBGQnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 11:43:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:36808 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266970AbUBGQnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 11:43:06 -0500
From: john cherry <cherry@osdl.org>
Date: Sat, 7 Feb 2004 08:43:05 -0800
Message-Id: <200402071643.i17Gh5v04277@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.2 - 2004-02-06.17.30) - 1 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sound/pci/vx222/vx222_ops.c:409: warning: int format, different type arg (arg 6)
