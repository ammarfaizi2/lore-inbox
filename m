Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbUAPM2O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 07:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265403AbUAPM2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 07:28:14 -0500
Received: from fw.osdl.org ([65.172.181.6]:20964 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265401AbUAPM2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 07:28:14 -0500
Date: Fri, 16 Jan 2004 04:28:12 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200401161228.i0GCSCAc020597@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.1 - 2004-01-15.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/sk98lin/skge.c:713: warning: unused variable `proc_root_initialized'
