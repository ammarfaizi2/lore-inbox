Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264755AbTFLFwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 01:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264756AbTFLFwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 01:52:45 -0400
Received: from [210.22.78.238] ([210.22.78.238]:6400 "HELO trust-mart.com")
	by vger.kernel.org with SMTP id S264755AbTFLFwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 01:52:44 -0400
Message-ID: <005e01c330a8$c12b3860$350b9284@it053>
From: "hv-trust" <hv@trust-mart.com>
To: <linux-kernel@vger.kernel.org>
Subject: cciss driver panic in 2.5.70
Date: Thu, 12 Jun 2003 14:06:24 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My smart array controllers 5i and 532 have a panic by using 2.5.70(also
include being patched kernel with bk*,mm*),the panic message is "VFS...Could
not mount cciss/codop1 or unknown-block",but all is right under kernel
2.4.18,my linux is redhat8.0.cciss have included in the kernel, not a
module.

