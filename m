Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbULQLG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbULQLG4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 06:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbULQLG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 06:06:56 -0500
Received: from mail.renesas.com ([202.234.163.13]:44190 "EHLO
	mail03.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262058AbULQLGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 06:06:55 -0500
Date: Fri, 17 Dec 2004 20:06:41 +0900 (JST)
Message-Id: <20041217.200641.1059989756.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc3-mm1] m32r: Update include/asm-m32r/thread_info.h
 (0/2)
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset updates include/asm-m32r/thread_info.h.
Please apply.

Thank you.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

[PATCH 2.6.10-rc3-mm1] m32r: include/asm-m32r/thread_info.h minor updates (1/2)
- Use THREAD_SIZE for __ASSEMBLY__ portion.
- Update comments.
- Fix a typo: user-thead --> user-thread.

[PATCH 2.6.10-rc3-mm1] m32r: Use kmalloc for m32r stacks (2/2)
- Use kmalloc for m32r stacks (cf. changeset 1.1046.533.10)
- Update for CONFIG_DEBUG_STACK_USAGE

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/


