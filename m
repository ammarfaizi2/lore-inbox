Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277166AbRJHWDZ>; Mon, 8 Oct 2001 18:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277168AbRJHWDG>; Mon, 8 Oct 2001 18:03:06 -0400
Received: from web14708.mail.yahoo.com ([216.136.224.125]:57357 "HELO
	web14708.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277165AbRJHWC6>; Mon, 8 Oct 2001 18:02:58 -0400
Message-ID: <20011008220328.2217.qmail@web14708.mail.yahoo.com>
Date: Mon, 8 Oct 2001 15:03:28 -0700 (PDT)
From: Peter Moscatt <pmoscatt@yahoo.com>
Subject: Can't exec /usr/sbin/sendmail  (After Kernel Install) ??
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have just recently compiled my first kernel (2.4.10)
onto my Mandrake 8.0 system.

All seems to be working fine, so I had a look at the
'dmesg' file in /var/log just to see it any errors
were appearing.

I have noticed that the following is occuring:

Oct 8 19:46:53 qld anacron[818]: Job 'cron.daily'
terminate (mailing output)
Oct 8 19:46:53 qld anacron[1302]: Can't exec
/usr/sbin/sendmail: No such file or directory
Oct 8 19:46:53 qld anacron[818]: Tried to mail output
to job 'cron.daily', but mailer process
(/usr/sbin/sendmail) exited with status 1
Oct 8 19:46:53 qld anacron[818]: Normal exit (1 jobs
run)


Is it just a matter or installing sendmail and all
will be sweet again ?

Pete

__________________________________________________
Do You Yahoo!?
NEW from Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
