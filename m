Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280627AbRKFWOk>; Tue, 6 Nov 2001 17:14:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280625AbRKFWO3>; Tue, 6 Nov 2001 17:14:29 -0500
Received: from mout04.kundenserver.de ([195.20.224.89]:32124 "EHLO
	mout04.kundenserver.de") by vger.kernel.org with ESMTP
	id <S280624AbRKFWOX>; Tue, 6 Nov 2001 17:14:23 -0500
From: "Sascha Andres" <linux-kernel@programmers-world.com>
To: <linux-kernel@vger.kernel.org>
Subject: SYN - Flood protection
Date: Tue, 6 Nov 2001 23:15:21 +0100
Message-ID: <002c01c16710$873a3100$0328a8c0@keasanb>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i use found that in the bugtraq mailinglist:

'SuSE Security Announcement: kernel (update) (SuSE-SA:2001:039)'

i have several systems with tcp_syncookies turned on.
i turned this feature on because it makes really sense
on this systems. SuSE says one should use the rpms to update
the system. well i do not use the suse kernels, i use
the official kernel series from www.kernel.org.

so my question is now, how to fix this bug (?) in the
official release. is it fixed with 2.4.14?

sascha


