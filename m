Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132386AbRAXEDf>; Tue, 23 Jan 2001 23:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131990AbRAXEDZ>; Tue, 23 Jan 2001 23:03:25 -0500
Received: from mail.etang.com ([202.101.42.207]:2450 "HELO mail.etang.com")
	by vger.kernel.org with SMTP id <S132392AbRAXEDP>;
	Tue, 23 Jan 2001 23:03:15 -0500
Date: Wed, 24 Jan 2001 11:38:31 -0800
From: hugang <linuxhappy@etang.com>
To: newsreader@mediaone.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: pre 10
Message-Id: <20010124113831.0f7f34df.linuxhappy@etang.com>
In-Reply-To: <20010123220140.A11608@dragon.universe>
In-Reply-To: <20010123220140.A11608@dragon.universe>
X-Mailer: Sylpheed version 0.4.52 (GTK+ 1.2.8; Linux 2.4.1-pre10; i686)
Organization: soul
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001 22:01:41 -0500
newsreader@mediaone.net wrote:

upgrade the ppp to 2.4.0. 

>I have successfully compiled and used 2.4.0 on pentium 133
>system.  However because I wanted to try reiserfs I installed
>2.4.1-pre10.  ppp is now broken.  I get the following error
>
>-------------
>
>Jan 23 21:24:55 a pppd[505]: Serial connection established.
>Jan 23 21:24:55 a pppd[505]: ioctl(PPPIOCGFLAGS): Invalid argument
>Jan 23 21:24:56 a pppd[505]: Hangup (SIGHUP)
>Jan 23 21:24:56 a pppd[505]: Exit.
>
>-----------
>
>I hope it's not my fault?  I did not have any problem with
>2.4.0 kernel.
>
>
>---------------
>
>Next I also have a dell box running celeron 566 with intel i810. 
>I run 2.2.18 and managed to make my display adapter work
>with a couple of packages from intel site.  I would like
>to run 2.4.  First 2.4.0 compiles and boots on this
>machine fine.  But I could not startx.  I gave up at that
>point but I wanted reiserfs so I again tried with pre10.  pre10
>kernel won't even boot.  It says that I must supply "root="
>parameter
>
>That can't be right.  First I compile and install on the
>same machine.  Next my root is /dev/hda1.  
>
>Next I did 
>
>/usr/sbin/rdev bzImage /dev/hda1
>
>That did not work.
>
>Next I install lilo with proper root parameter.
>
>That did not work.
>
>I hope someone can find and fix these problems.
>
>Regards
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
