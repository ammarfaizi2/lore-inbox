Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbTDCQiw>; Thu, 3 Apr 2003 11:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261363AbTDCQiw>; Thu, 3 Apr 2003 11:38:52 -0500
Received: from in02-fes2.whowhere.com ([209.202.220.219]:20317 "HELO
	whowhere.com") by vger.kernel.org with SMTP id <S261339AbTDCQiu>;
	Thu, 3 Apr 2003 11:38:50 -0500
To: "John Bradford" <john@grabjohn.com>
Date: Thu, 03 Apr 2003 16:49:58  0000
From: "Dean McEwan" <dean.mcewan@eudoramail.com>
Message-ID: <LKIAPKGOJEIOACAA@whowhere.com>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Content-Language: en
Reply-To: dean.mcewan@eudoramail.com
X-Sent-Mail: off
X-Mailer: MailCity Service
Subject: Re: I compiled the kernel but it doesn't do any thing, its a bit like typing "halt
X-Priority: 3
X-Sender-Ip: 195.195.129.3
Organization: Lycos Mail  (http://www.mail.eudoramail.com)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003 11:38:47 John Bradford wrote:
> init=/bin/sh is already defined in init/main.c isn't 
> it?
>
>Once the kernel has booted, it usually passed control to init.  The
>kernel usually looks for init in /sbin /etc and /bin, but if there is
>no init in those locations, /bin/sh is looked for as a last resort.


>I am assuming that you have an init on your system, but something is
>wrong.

Perhaps. It may be the kernel.

  Using init=/bin/sh will allow you to use the shell as the init
>process, which proves it's an init problem.

I did it but to no avail... Alas Mandrake sucks :-)

>
>> I accidentally compiled initrd in, but ive got it off
>> with "noinitrd".
>
>I don't really understand what you're trying to do.

Ok John, I'll put it simply, Im trying to compile a 2.5.* kernel. ;-) 

Once ive got a 2.5.* series kernel to work on my machine, I've
decided to download .66 when I can get the one Ive got now to compile.

>> 
Ok John, calm down you seem a bit agitated :-)
Maybe you've been talking to Andre ;-)
---
Cheers, Dean.
No Warrantee for incorrectness, political or otherwise,
after all, Dubya doesn't have one...

One of 4 members of the board of DM. TECH.
a.k.a. Everybody at DM. TECH's Boss.
Member of ATI Open Source development project.
NDA's signed to date = 29.
Number of people who've blocked me = priceless.


Need a new email address that people can remember
Check out the new EudoraMail at
http://www.eudoramail.com
