Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUAZS3q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 13:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbUAZS3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 13:29:46 -0500
Received: from web21405.mail.yahoo.com ([216.136.232.75]:22121 "HELO
	web21405.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264538AbUAZS3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 13:29:45 -0500
Message-ID: <20040126182941.50687.qmail@web21405.mail.yahoo.com>
Date: Mon, 26 Jan 2004 10:29:41 -0800 (PST)
From: Dave Johnson <davejohnson_hifi@yahoo.com>
Subject: Using 8 Instruction and Data BAT registers in 82xx
To: cort@fsmlabs.com, linux-kernel@vger.kernel.org,
       linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All:
As there are 8 data and Instruction BAT registers in
some 82xx flavors, and Cort has posted a patch to ADD
these registers
(http://www.ussg.iu.edu/hypermail/linux/kernel/0209.1/0871.html)
I was wondering if anyone has any idea how to use
these addistional BAT regs be used?? Perhaps for new
processes and threads, etc. 

Dave..

__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
