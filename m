Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261881AbTD2VlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbTD2VlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:41:05 -0400
Received: from web41608.mail.yahoo.com ([66.218.93.108]:50046 "HELO
	web41608.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261881AbTD2VlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:41:04 -0400
Message-ID: <20030429215318.27252.qmail@web41608.mail.yahoo.com>
Date: Tue, 29 Apr 2003 14:53:18 -0700 (PDT)
From: Pawan Deepika <pawan_deepika@yahoo.com>
Subject: 'tainting kernel' problem in linux-2.4.18
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

 I am trying LKM with linux-2.4.18. I have a problem
here. When I load the module using 'insmod' command,
module gets loaded but I get following error

------------------------------------------------------
/sbin/insmod ./hello.o
Warning: loading ./hello.o will taint the kernel: no
license
  See http://www.tux.org/lkml/#export-tainted for
information about tainted modules
Module hello loaded, with warnings
----------------------------------------------------

Can anyone tell me why I am getting this problem and
what is the impact of this error while module is
running in kernel. 

Thanks in advance.

Regards,
Deepika


__________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo.
http://search.yahoo.com
