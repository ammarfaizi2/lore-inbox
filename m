Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTIMQLd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 12:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbTIMQLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 12:11:33 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:1550 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S261168AbTIMQLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 12:11:32 -0400
From: Michael Frank <mhf@linuxmail.org>
To: Pat LaVarre <p.lavarre@ieee.org>, mpm@selenic.com
Subject: Re: console lost to Ctrl+Alt+F$n in 2.6.0-test5
Date: Sat, 13 Sep 2003 23:47:37 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <1063378664.5059.19.camel@patehci2> <1063460312.2905.13.camel@patehci2> <200309132249.40283.mhf@linuxmail.org>
In-Reply-To: <200309132249.40283.mhf@linuxmail.org>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309132347.37831.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 13 September 2003 22:49, Michael Frank wrote:
> Don't think this is a keyboard problem and have seen
> this several times related to video drivers in particular
> when switching back to X.

Used script with 2.6.0-test5 + pm2 patch

Kernel: VGA16FB 

X4.3:	Driver      "vesa"
	VendorName  "Silicon Integrated Systems [SiS]"
	BoardName   "VESA driver (generic)"

200 cycles wo problems.

