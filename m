Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbUA3PFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 10:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUA3PFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 10:05:44 -0500
Received: from heavymos.kumin.ne.jp ([61.114.158.133]:55949 "HELO
	emerald.kumin.ne.jp") by vger.kernel.org with SMTP id S261563AbUA3PFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 10:05:43 -0500
Message-Id: <200401301505.AA00013@prism.kumin.ne.jp>
Date: Sat, 31 Jan 2004 00:05:29 +0900
To: linux-kernel@vger.kernel.org
Cc: tao@acc.umu.se
Subject: linux-2.0.40-rc8
From: Seiichi Nakashima <nakasima@kumin.ne.jp>
In-Reply-To: <200401171453.AA00009@prism.kumin.ne.jp>
References: <200401171453.AA00009@prism.kumin.ne.jp>
MIME-Version: 1.0
X-Mailer: AL-Mail32 Version 1.13
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I update linux-2.0.40-rc8 from 2.0.40-rc6, compile and work fine.
these warning error exist in my environment(slackware-3.9 base).

ialloc.c: In function `ext2_new_inode':
ialloc.c:302: warning: `bh2' might be used uninitialized in this function
ialloc.c:452: warning: `bh' might be used uninitialized in this function

--------------------------------
  Seiichi Nakashima
  Email   nakasima@kumin.ne.jp
--------------------------------
