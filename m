Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUE1EQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUE1EQZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 00:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265793AbUE1EQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 00:16:25 -0400
Received: from mail.renesas.com ([202.234.163.13]:28149 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262730AbUE1EQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 00:16:22 -0400
Date: Fri, 28 May 2004 13:16:11 +0900 (JST)
Message-Id: <20040528.131611.28785624.takata.hirokazu@renesas.com>
To: linux-kernel@vger.kernel.org
Cc: takata@linux-m32r.org
Subject: [PATCH] m32r - Upgrade to v2.6.6 kernel
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to send the latest 2.6.6 kernel patch for 
the Renesas M32R processor.

Patch information to the stock 2.6.6 kernel is placed as follows:
- m32r architecture dependent portions (arch/m32r, include/asm-m32r)
  http://www.linux-m32r.org/public/linux-2.6.6_m32r_20040528.arch-m32r.patch

In this M32R kernel,
- OProfile is newly supported.
- Architecture-dependent portion codes have been modified for gcc-3.4.0.

Best Regards,
--
Hirokazu Takata
Linux/M32R Project: http://www.linux-m32r.org/

