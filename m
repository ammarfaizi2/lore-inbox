Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262244AbTDAKQ5>; Tue, 1 Apr 2003 05:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbTDAKQ5>; Tue, 1 Apr 2003 05:16:57 -0500
Received: from in02-fes2.whowhere.com ([209.202.220.219]:38272 "HELO
	whowhere.com") by vger.kernel.org with SMTP id <S262244AbTDAKQz>;
	Tue, 1 Apr 2003 05:16:55 -0500
To: dean.mcewan@eudoramail.com, "John Bradford" <john@grabjohn.com>
Date: Tue, 01 Apr 2003 10:28:07  0000
From: "Dean McEwan" <dean.mcewan@eudoramail.com>
Message-ID: <JLPADMLNKEGDACAA@whowhere.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org
X-Sent-Mail: off
Reply-To: dean.mcewan@eudoramail.com
X-Mailer: MailCity Service
X-Priority: 3
Subject: Re: I compiled the kernel but it doesn't do any thing, its a bit like typing "halt".
X-Sender-Ip: 195.195.129.3
Organization: Lycos Mail  (http://www.mail.eudoramail.com)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

init=/bin/sh is already defined in init/main.c isn't 
it?

I accidentally compiled initrd in, but ive got it off
with "noinitrd".
---
Cheers, Dean.


>> whats system.map actually for
>
>Decoding numerical addresses in to function names.

Does it need to be put in /boot after compilation from
the root linux source folder, 'coz the mandrake one
for 2.4.19-16mdk is in there.

>
>John.
>


Need a new email address that people can remember
Check out the new EudoraMail at
http://www.eudoramail.com
