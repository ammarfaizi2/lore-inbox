Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285369AbSALPkc>; Sat, 12 Jan 2002 10:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285498AbSALPkM>; Sat, 12 Jan 2002 10:40:12 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:51616 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S285369AbSALPkK>; Sat, 12 Jan 2002 10:40:10 -0500
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200201121540.g0CFe7F01606@ns.home.local>
Subject: Re: netfilter oops (Was: Re: Linux 2.4.18-pre2)
To: cat@zip.com.au
Date: Sat, 12 Jan 2002 16:40:07 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Writing it down would be a pain so I may opt for the
> null-modem cable which may take a week or so for me to
> get at though.

You'd better download my kmsgdump patch which will let you save
all your kernel messages (including oops) to a floppy disk.
Please read the doc in Documentation/kmsgdump.txt to get more info.

http://www-miaif.lip6.fr/willy/linux-patches//kmsgdump/0.4.3/kmsgdump-0.4.3-2.4.16pre1.patch

Regards,
Willy

