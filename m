Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265348AbUGDClP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265348AbUGDClP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 22:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUGDClO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 22:41:14 -0400
Received: from web51805.mail.yahoo.com ([206.190.38.236]:38752 "HELO
	web51805.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265348AbUGDClN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 22:41:13 -0400
Message-ID: <20040704024112.4513.qmail@web51805.mail.yahoo.com>
Date: Sat, 3 Jul 2004 19:41:12 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: Slow internet access for 2.6.7bk15&16
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heelo,

I have been watching a thread concerning the slow down
with accessing some websites but have not found a
resolution to the issue.  

Here is the issue going to kernel.org and grabbing
util-linux-2.12a.tar.bz  via ftp on 2.6.7 and 2.6.6
takes ~10s, however, on 2.6.7bk9,15,16 it takes 2
minutes:

2.6.6:
1281955 bytes received in 10 seconds (1.2e+02
Kbytes/s)

2.6.7bk16:
1281955 bytes received in 1.6e+02 seconds (7.7
Kbytes/s)

Moving files on the local net shows no issues:
622853632 bytes received in 15 seconds (4.2e+04
Kbytes/s)

Is this a known issue and is there a resolution?  Any
help with this is greatly appreciated.

Thanks,
Phy


	
		
__________________________________
Do you Yahoo!?
New and Improved Yahoo! Mail - 100MB free storage!
http://promotions.yahoo.com/new_mail 
