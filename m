Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130355AbQKKJwO>; Sat, 11 Nov 2000 04:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130404AbQKKJwF>; Sat, 11 Nov 2000 04:52:05 -0500
Received: from web1102.mail.yahoo.com ([128.11.23.122]:59921 "HELO
	web1102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S130355AbQKKJvx>; Sat, 11 Nov 2000 04:51:53 -0500
Message-ID: <20001111095151.1167.qmail@web1102.mail.yahoo.com>
Date: Sat, 11 Nov 2000 10:51:51 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: Re: crash @ 64 day's of uptime
To: mjrider@enschede.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

in the company I left 3 months ago, there is a DNS
which has more than 500 days uptime now. It's based
on 2.2.10 and receives requests from internet and
intranet. I know this kernel is pretty old, but you
could try it on an unused system to see if it goes
down in 64 days or not. It may be possible that your
problem is related to a particular driver or subsystem
common to both your sparc and PCs.

Regards,
Willy


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
