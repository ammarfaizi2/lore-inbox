Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSCWCTD>; Fri, 22 Mar 2002 21:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290184AbSCWCSx>; Fri, 22 Mar 2002 21:18:53 -0500
Received: from web10503.mail.yahoo.com ([216.136.130.153]:48277 "HELO
	web10503.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S289484AbSCWCSq>; Fri, 22 Mar 2002 21:18:46 -0500
Message-ID: <20020323021846.56882.qmail@web10503.mail.yahoo.com>
Date: Fri, 22 Mar 2002 18:18:46 -0800 (PST)
From: S W <egberts@yahoo.com>
Subject: 2.4.19-pre3: kernel bug: kswapd vmscan.c:358
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bare 2.4.19-pre3 Kernel, running all VIA-chipsets mobo
with "cachesize=0" boot option. (author of previous
msg: (Cyrix II L2-cache redux?).

Regularly getting kswapd vmscan.c:358 Kernel bug.

Seeking guidance on kgdb analysis plan.

S W



__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
