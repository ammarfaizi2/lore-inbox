Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbVETD0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbVETD0A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 23:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261151AbVETD0A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 23:26:00 -0400
Received: from [218.94.131.104] ([218.94.131.104]:65038 "EHLO RCS-9000.COM")
	by vger.kernel.org with ESMTP id S261200AbVETDZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 23:25:57 -0400
Date: Fri, 20 May 2005 11:27:14 +0800
Message-Id: <200505201127.AA8126754@RCS-9000.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "zhonglei" <zhonglei@RCS-9000.COM>
Reply-To: <zhonglei@RCS-9000.COM>
To: <linux-kernel@vger.kernel.org>
Subject: module mismatch
X-Mailer: <IMail v8.03>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when I use "insmod -f hello.o" in my Embeded linux,the warning appears:
Warning: Kernel-module version mismatch
         hello.o was compiled for kernel version 2.4.24-per2
         while this kernel is version 2.4.25
Warning: loading hello.o will taint the kernel: forced load
   see http://www.tux.org/lkml/#export-tainted for information about tainted modules

Is there any problem on my using my module function with this warning?

