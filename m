Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129124AbRBCI7g>; Sat, 3 Feb 2001 03:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129252AbRBCI70>; Sat, 3 Feb 2001 03:59:26 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:3083 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129124AbRBCI7J>;
	Sat, 3 Feb 2001 03:59:09 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Fix for include/linux/fs.h in 2.4.0 kernels 
In-Reply-To: Your message of "03 Feb 2001 08:48:54 -0000."
             <m2d7d0up6x.fsf@barnowl.demon.co.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Feb 2001 19:59:02 +1100
Message-ID: <14353.981190742@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03 Feb 2001 08:48:54 +0000, 
Graham Murray <graham@barnowl.demon.co.uk> wrote:
>So what is your advice?  Would the "correct" action be to take a
>snapshot of the appropriate kernel directories against which glibc is
>built? (ie to copy the directories (or those files needed) to
>/usr/include/asm and /usr/include/linux)

This has all been thrashed out before.  Read the threads

http://www.mail-archive.com/linux-kernel@vger.rutgers.edu/2000-month-07/msg04096.html
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg18256.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
