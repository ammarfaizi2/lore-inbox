Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286311AbRL0Pvv>; Thu, 27 Dec 2001 10:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286315AbRL0Pvm>; Thu, 27 Dec 2001 10:51:42 -0500
Received: from [212.16.7.124] ([212.16.7.124]:53127 "HELO laputa.namesys.com")
	by vger.kernel.org with SMTP id <S286311AbRL0Pvd>;
	Thu, 27 Dec 2001 10:51:33 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15403.16930.233614.432899@laputa.namesys.com>
Date: Thu, 27 Dec 2001 18:45:38 +0300
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: <linux-kernel@vger.kernel.org>,
        Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: reiserfs does not work with linux 2.4.17 on sparc64 CPUs
In-Reply-To: <Pine.LNX.4.33.0112271607570.24247-100000@Expansa.sns.it>
In-Reply-To: <Pine.LNX.4.33.0112271607570.24247-100000@Expansa.sns.it>
X-Mailer: VM 7.00 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni writes:
 > HI,
 > I just upgraded to kernel 2.4.17 on a ultra2, sparc64, with 2 scsi disks.
 > 
 > My system was on reiserfs,except for root partition, but the kernel 2.4.17
 > is unable to mount reiserFS partitions.
 > At boot i get an oops during the mount, but sincer I have no syslogd
 > running I am not able to log it. Anyway the message talk about not been
 > able to load a table map.

Can you boot into single user, mount reiserfs partition manually and
send decoded oops trace to the reiserfs list
(Reiserfs-List@Namesys.COM)?

 > 
 > gone back (sig!) to 2.4.16
 > 
 > on x86 processors, instead, reiserfs semms to work as usual
 > 
 > Luigi
 > 

Nikita.
-- 
Harry Popper---bespectacled philosopher
