Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292749AbSCDVXh>; Mon, 4 Mar 2002 16:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292908AbSCDVX1>; Mon, 4 Mar 2002 16:23:27 -0500
Received: from web21305.mail.yahoo.com ([216.136.129.141]:35491 "HELO
	web21305.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292749AbSCDVXP>; Mon, 4 Mar 2002 16:23:15 -0500
Message-ID: <20020304212315.89890.qmail@web21305.mail.yahoo.com>
Date: Mon, 4 Mar 2002 13:23:15 -0800 (PST)
From: chiranjeevi vaka <cvaka_kernel@yahoo.com>
Subject: Need Suggestion(modifying kernel source)
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am a graduate student doing research in linux TCP/IP
stack modification. My job is replacing the TCP layer
Sliding window protocol with Credit based mechanism.

The major problem I am getting is, as and when I do a
small change, to test that change, I have to compile
the whole kernel make boot floppy and reboot the
kernel with that floppy and test the code. This way is
takinbg too much time. I donno how linux kernel
developers will make changes to kernel and test them. 

Is there any other way to do this. Like using some
debugger or writing some modules. If I want to write a
module for this I can't create the whole linux TCP/IP
stack as a seperate module as it is monolithic kernel.
Can you suggest me in this issue. If it is any thing
to deal with the kernel debugger can you give me
proper links so that I can get more information about
that.


Thanking you in advance
Muali

__________________________________________________
Do You Yahoo!?
Yahoo! Sports - sign up for Fantasy Baseball
http://sports.yahoo.com
