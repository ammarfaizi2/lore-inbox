Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132296AbQKKTyL>; Sat, 11 Nov 2000 14:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132324AbQKKTyA>; Sat, 11 Nov 2000 14:54:00 -0500
Received: from web1102.mail.yahoo.com ([128.11.23.122]:4112 "HELO
	web1102.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S132296AbQKKTxq>; Sat, 11 Nov 2000 14:53:46 -0500
Message-ID: <20001111195345.6818.qmail@web1102.mail.yahoo.com>
Date: Sat, 11 Nov 2000 20:53:45 +0100 (CET)
From: willy tarreau <wtarreau@yahoo.fr>
Subject: Re: Tracing files that opens.
To: mag@bahnhof.se
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a nice way to trap on file open() and
stat() ? 

a few months ago, I helped a friend in writing a
generic syscall wrapper because he needed exactly
this.
You should take a look at the section "overloader" on 

http://bdolez.free.fr/

Regards,
willy


___________________________________________________________
Do You Yahoo!? -- Pour dialoguer en direct avec vos amis, 
Yahoo! Messenger : http://fr.messenger.yahoo.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
