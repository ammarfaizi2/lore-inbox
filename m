Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262981AbSLBBS0>; Sun, 1 Dec 2002 20:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSLBBS0>; Sun, 1 Dec 2002 20:18:26 -0500
Received: from web14506.mail.yahoo.com ([216.136.224.69]:19026 "HELO
	web14506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262981AbSLBBSZ>; Sun, 1 Dec 2002 20:18:25 -0500
Message-ID: <20021202012552.47909.qmail@web14506.mail.yahoo.com>
Date: Sun, 1 Dec 2002 17:25:52 -0800 (PST)
From: Arun Prasad Velu <arun_linux@yahoo.com>
Subject: kgdb - compilation fails for i386_ksyms.c 
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I was trying to use kgdb.
But I get the following error while trying to create
the kernel image after applying kgdb patch.
I couldn't copy paste the error and so typed the same
here.

"
i386_ksyms.c:172: 'do_BUG' undeclared here (not in a
function)
i386_ksyms.c:172: initializaer element is not a
constant
i386_ksyms.c:172: (near initialization for
'__ksymtab_do_BUG.value')
make[1]: *** [ie86_ksyms.o] Error 1
make *** [_dir_arch/i386/kernel] Error 2
"

Your earlier response would ne of great help.

Have a nice time.
Warm Regards
Arun


__________________________________________________
Do you Yahoo!?
Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
http://mailplus.yahoo.com
