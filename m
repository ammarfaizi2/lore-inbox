Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263045AbTDYGTi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 02:19:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263050AbTDYGTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 02:19:38 -0400
Received: from web20409.mail.yahoo.com ([66.163.169.97]:34057 "HELO
	web20421.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263045AbTDYGTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 02:19:37 -0400
Message-ID: <20030425063147.9206.qmail@web20421.mail.yahoo.com>
Date: Thu, 24 Apr 2003 23:31:47 -0700 (PDT)
From: devnetfs <devnetfs@yahoo.com>
Subject: compiling modules with gcc 3.2
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Will kernel modules compiled with gcc 3.2 load in kernel compiled with
gcc 2.96 (RH system)?  The RH 8.0 release notes state that 2.96
compiled modules can't be loaded on RH8.0 (as its compiled using gcc
3.2). So
does the reverse also hold true?

Either way why is this so? AFAIK gcc 3.2 has abi incompatiblities
w.r.t. C++ and not C (which the kernel+modules are written in). I did
try searching on google but could not find the exact set of
incompatibilies w.r.t C. Can somebody *please* point me to a link or a
thread.

Thanks a lot in advamce

Regards,
A.

PS: I am not subscribed to lkml. please Cc: me the replies.


__________________________________________________
Do you Yahoo!?
The New Yahoo! Search - Faster. Easier. Bingo
http://search.yahoo.com
