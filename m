Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbUCBHze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 02:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbUCBHzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 02:55:33 -0500
Received: from mail.renesas.com ([202.234.163.13]:10923 "EHLO
	mail01.idc.renesas.com") by vger.kernel.org with ESMTP
	id S261500AbUCBHzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 02:55:31 -0500
Date: Tue, 02 Mar 2004 16:55:24 +0900 (JST)
Message-Id: <20040302.165524.774041887.takata.hirokazu@renesas.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] m32r - New architecure port to Renesas M32R processor  
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: takata@linux-m32r.org
X-Mailer: Mew version 3.3 on XEmacs 21.4.14 (Reasonable Discussion)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus and folks,

We have ported Linux to the M32R processor, which is a 32-bit RISC embedded
microprocessor of Renesas Technology.

I would like to release a patch information for this m32r port.
Would you merge them to the stock kernel?
# Unfortunately, I have linux-2.4.19 based kernel, not latest one.

Patch information is slightly bigger, so I placed it on our 
Linux/M32R homepage.
http://www.linux-m32r.org/public/linux-2.4.19_m32r_20040203.arch-m32r.patch

This new architecture port has already reported at OLS2003.
http://www.linux-m32r.org/cmn/m32r/ols2003_presentation.pdf
http://archive.linuxsymposium.org/ols2003/Proceedings/All-Reprints/Reprint-Takata-OLS2003.pdf

Thank you.
--
Hirokazu Takata

