Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315913AbSEOMbp>; Wed, 15 May 2002 08:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSEOMbo>; Wed, 15 May 2002 08:31:44 -0400
Received: from web21507.mail.yahoo.com ([66.163.169.18]:62840 "HELO
	web21507.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S315913AbSEOMbo>; Wed, 15 May 2002 08:31:44 -0400
Message-ID: <20020515123144.66286.qmail@web21507.mail.yahoo.com>
Date: Wed, 15 May 2002 05:31:44 -0700 (PDT)
From: Shashidhar MC <shashimc2002@yahoo.com>
Subject: all of a sudden !
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I recently installed Red Hat 7.1 (2.4.2-2) on a
machine with 2GB HD, 32MB RAM.  It works fine, but
occassionally it throws the following error and it
hangs:

<error>

pgd entry c04....
pmd entry c0...
... pmd not present !
Oops: 0000
CPU: 0
EIP:  0010:....
EFLAGS:  00010...
eax: ...       ebx:........   ecx:....   edx:.....
esi:....       edi:.......    ebp:....   esp:....
ds: ..         es: ...        ss:...
Process ifconfig ( pid: 2136, stackpage=0c....)
Stack: c2826.. ....... ............... ........ ....

Call Trace: .....
Code: 8b 04 ...........
Kernel Panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing

</error>

  I have typed out the error manually on a
neighbouring machine (because my machine hung) and
hence replaced those numbers with dots.

I was just reading a file in a text editor when this
last happened.

Any idea why this happens ?  Any solution ?

thanks in advance.
------------------------------------------------------------------------------

__________________________________________________
Do You Yahoo!?
LAUNCH - Your Yahoo! Music Experience
http://launch.yahoo.com
