Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUBFQSV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 11:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265532AbUBFQSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 11:18:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:16270 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265515AbUBFQSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 11:18:12 -0500
From: john cherry <cherry@osdl.org>
Date: Fri, 6 Feb 2004 08:18:11 -0800
Message-Id: <200402061618.i16GIBO06879@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.2 - 2004-02-05.17.30) - 1 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/tulip/interrupt.c:218: warning: unsigned int format, different type arg (arg 4)
