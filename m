Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbUEAMCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUEAMCs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 08:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261711AbUEAMCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 08:02:48 -0400
Received: from mail.renesas.com ([202.234.163.13]:20694 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261685AbUEAMCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 08:02:46 -0400
Date: Sat, 01 May 2004 21:02:39 +0900 (JST)
Message-Id: <20040501.210239.730563865.takata.hirokazu@renesas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] m32r - New architecure port to Renesas M32R processor 
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20040302.165524.774041887.takata.hirokazu@renesas.com>
References: <20040302.165524.774041887.takata.hirokazu@renesas.com>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

Here are upgrade patches of the Renesas M32R processor
for the latest 2.4.26 kernel.

Patch information to the stock linux-2.4.26 kernel is placed as follows:
- m32r architecture dependent portions (arch/m32r, include/asm-m32r)
  http://www.linux-m32r.org/public/linux-2.4.26_m32r_20040429.arch-m32r.patch
- architecture independent portions for the m32r
  http://www.linux-m32r.org/public/linux-2.4.26_m32r_20040429.patch

Regards,
---
Hirokazu Takata
Linux/M32R Project: http//www.linux-m32r.org/
