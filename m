Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261741AbUC0N5Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 08:57:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbUC0N5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 08:57:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:4750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261741AbUC0N5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 08:57:24 -0500
Date: Sat, 27 Mar 2004 05:57:22 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200403271357.i2RDvMwb020844@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.5-rc2 - 2004-03-26.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/acpi/events/evmisc.c:143: warning: too many arguments for format
