Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265880AbTAOIW0>; Wed, 15 Jan 2003 03:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265886AbTAOIW0>; Wed, 15 Jan 2003 03:22:26 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:56800 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S265880AbTAOIWZ>; Wed, 15 Jan 2003 03:22:25 -0500
Date: Wed, 15 Jan 2003 17:30:35 +0900
From: Takao Indoh <indou.takao@soft.fujitsu.com>
Subject: About tunable features of Linux
To: linux-kernel@vger.kernel.org
Message-id: <59C2BC70601626indou.takao@soft.fujitsu.com>
MIME-version: 1.0
X-Mailer: TuruKame 2.26 (WinNT,501)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'd like to improve tunable features of Linux. I think it's a good way
to add new parameters into /proc/sys or sysfs for tuning.

For example, I'll implement the following parameters.
  - the parameter to control filesystem cache, such as inode-cache,
    dentry-cache, etc.
  - IPC parameter (e.g. msgtql, semvmx)

Should the patches for tuning be posted to LKML? Or is there another
appropriate community?

Thanks.
--------------------------------------------------
Takao Indoh
 E-Mail : indou.takao@jp.fujitsu.com
FUJITSU LIMITED
