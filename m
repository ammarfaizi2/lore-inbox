Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290792AbSAYSvr>; Fri, 25 Jan 2002 13:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290791AbSAYSvq>; Fri, 25 Jan 2002 13:51:46 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18304 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290792AbSAYSt0>; Fri, 25 Jan 2002 13:49:26 -0500
Date: Fri, 25 Jan 2002 13:50:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Uptime again?
Message-ID: <Pine.LNX.3.95.1020125134800.1544A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Uptime, when using Linux-2.4.1 doesn't seem to go past 128 days!
This is a RedHat distrubution, 7.x

These are the last three days:

 11:59am  up 128 days, 21:24,  2 users,  load average: 1.03, 1.01, 1.00
 10:06am  up 128 days, 12:31,  2 users,  load average: 1.02, 1.00, 1.00
  1:06pm  up 128 days, 22:31,  2 users,  load average: 1.00, 1.00, 1.00
Linux boneserver 2.4.1 #15 SMP Thu Aug 9 16:03:49 EDT 2001 i686
  1:10pm  up 128 days, 22:35,  2 users,  load average: 1.08, 1.02, 1.01
USER     TTY      FROM              LOGIN@  IDLE   JCPU   PCPU  WHAT
root     ttyp1    chaos.analogic.com 1:05pm  0.00s  0.12s  0.02s  w 


My Sun, which did NOT reboot several days ago, shows:

  1:11pm  up 2 day(s), 22:30,  1 user,  load average: 0.00, 0.00, 0.01

So it looks like it just 'wrapped'.
 
Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


