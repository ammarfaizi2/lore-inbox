Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263796AbUBHQX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbUBHQX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:23:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:52636 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263796AbUBHQX0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:23:26 -0500
From: john cherry <cherry@osdl.org>
Date: Sun, 8 Feb 2004 08:23:25 -0800
Message-Id: <200402081623.i18GNPf04291@build-000.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA64 (2.6.3-rc1 - 2004-02-07.17.30) - 2 New warnings (gcc 3.3.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/acpi/numa.c:48: warning: unused variable `p'
drivers/acpi/numa.c:58: warning: unused variable `p'
