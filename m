Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262793AbSJLDk6>; Fri, 11 Oct 2002 23:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262794AbSJLDk5>; Fri, 11 Oct 2002 23:40:57 -0400
Received: from holomorphy.com ([66.224.33.161]:49795 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262793AbSJLDkz>;
	Fri, 11 Oct 2002 23:40:55 -0400
Date: Fri, 11 Oct 2002 20:43:25 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [lart] /bin/ps output
Message-ID: <20021012034325.GC10722@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>
References: <3DA798B6.9070400@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA798B6.9070400@us.ibm.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 08:36:22PM -0700, Dave Hansen wrote:
> Man, this looks ugly.  I'm just waiting for Bill Irwin, or Anton to 
> trump me, though.

UID        PID  PPID  C STIME TTY          TIME CMD
root         1     0  0 Oct09 ?        00:00:08 init
root         2     1  0 Oct09 ?        00:00:00 [migration_CPU0]
root         3     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU0]
root         4     1  0 Oct09 ?        00:00:00 [migration_CPU1]
root         5     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU1]
root         6     1  0 Oct09 ?        00:00:00 [migration_CPU2]
root         7     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU2]
root         8     1  0 Oct09 ?        00:00:00 [migration_CPU3]
root         9     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU3]
root        10     1  0 Oct09 ?        00:00:00 [migration_CPU4]
root        11     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU4]
root        12     1  0 Oct09 ?        00:00:00 [migration_CPU5]
root        13     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU5]
root        14     1  0 Oct09 ?        00:00:00 [migration_CPU6]
root        15     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU6]
root        16     1  0 Oct09 ?        00:00:00 [migration_CPU7]
root        17     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU7]
root        18     1  0 Oct09 ?        00:00:00 [migration_CPU8]
root        19     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU8]
root        20     1  0 Oct09 ?        00:00:00 [migration_CPU9]
root        21     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU9]
root        22     1  0 Oct09 ?        00:00:00 [migration_CPU10]
root        23     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU10]
root        24     1  0 Oct09 ?        00:00:00 [migration_CPU11]
root        25     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU11]
root        26     1  0 Oct09 ?        00:00:00 [migration_CPU12]
root        27     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU12]
root        28     1  0 Oct09 ?        00:00:00 [migration_CPU13]
root        29     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU13]
root        30     1  0 Oct09 ?        00:00:00 [migration_CPU14]
root        31     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU14]
root        32     1  0 Oct09 ?        00:00:00 [migration_CPU15]
root        33     1  0 Oct09 ?        00:00:00 [ksoftirqd_CPU15]
root        34     1  0 Oct09 ?        00:00:00 [events/0]
root        35     1  0 Oct09 ?        00:00:00 [events/1]
root        36     1  0 Oct09 ?        00:00:00 [events/2]
root        37     1  0 Oct09 ?        00:00:00 [events/3]
root        38     1  0 Oct09 ?        00:00:00 [events/4]
root        39     1  0 Oct09 ?        00:00:00 [events/5]
root        40     1  0 Oct09 ?        00:00:00 [events/6]
root        41     1  0 Oct09 ?        00:00:00 [events/7]
root        42     1  0 Oct09 ?        00:00:00 [events/8]
root        43     1  0 Oct09 ?        00:00:00 [events/9]
root        44     1  0 Oct09 ?        00:00:00 [events/10]
root        45     1  0 Oct09 ?        00:00:00 [events/11]
root        46     1  0 Oct09 ?        00:00:00 [events/12]
root        47     1  0 Oct09 ?        00:00:00 [events/13]
root        48     1  0 Oct09 ?        00:00:00 [events/14]
root        49     1  0 Oct09 ?        00:00:00 [events/15]
root        71     1  0 Oct09 ?        00:00:00 [pdflush]
root        70     1  0 Oct09 ?        00:02:24 [pdflush]
root        69     1  0 Oct09 ?        00:00:00 [kswapd0]
root        68     1  0 Oct09 ?        00:00:00 [kswapd1]
root        67     1  0 Oct09 ?        00:00:00 [kswapd2]
root        66     1  0 Oct09 ?        00:00:00 [kswapd3]
root        72     1  0 Oct09 ?        00:00:00 [aio/0]
root        73     1  0 Oct09 ?        00:00:00 [aio/1]
root        74     1  0 Oct09 ?        00:00:00 [aio/2]
root        75     1  0 Oct09 ?        00:00:00 [aio/3]
root        76     1  0 Oct09 ?        00:00:00 [aio/4]
root        77     1  0 Oct09 ?        00:00:00 [aio/5]
root        78     1  0 Oct09 ?        00:00:00 [aio/6]
root        79     1  0 Oct09 ?        00:00:00 [aio/7]
root        80     1  0 Oct09 ?        00:00:00 [aio/8]
root        81     1  0 Oct09 ?        00:00:00 [aio/9]
root        82     1  0 Oct09 ?        00:00:00 [aio/10]
root        83     1  0 Oct09 ?        00:00:00 [aio/11]
root        84     1  0 Oct09 ?        00:00:00 [aio/12]
root        85     1  0 Oct09 ?        00:00:00 [aio/13]
root        86     1  0 Oct09 ?        00:00:00 [aio/14]
root        87     1  0 Oct09 ?        00:00:00 [aio/15]
root        88     1  0 Oct09 ?        00:00:00 [scsi_eh_0]
root       264     1  0 Oct09 ?        00:00:00 /sbin/syslogd
root       267     1  0 Oct09 ?        00:00:01 /sbin/klogd
root       274     1  0 Oct09 ?        00:00:00 /usr/sbin/inetd
root       279     1  0 Oct09 ?        00:00:00 /usr/sbin/netserver
root       285     1  0 Oct09 ?        00:00:00 /usr/sbin/sshd
root       288     1  0 Oct09 ?        00:00:07 /usr/sbin/ntpd
root       291     1  0 Oct09 tty1     00:00:00 /sbin/getty 38400 tty1
root       292     1  0 Oct09 tty2     00:00:00 /sbin/getty 38400 tty2
root       293     1  0 Oct09 tty3     00:00:00 /sbin/getty 38400 tty3
root       294     1  0 Oct09 tty4     00:00:00 /sbin/getty 38400 tty4
root       295     1  0 Oct09 tty5     00:00:00 /sbin/getty 38400 tty5
root       296     1  0 Oct09 tty6     00:00:00 /sbin/getty 38400 tty6
root       297     1  0 Oct09 ttyS0    00:00:00 -bash
root       303     1  0 Oct09 ?        00:00:00 sshd -p 1976
root      9582   285  0 Oct10 ?        00:00:00 /usr/sbin/sshd
wli       9584  9582  0 Oct10 ?        00:00:01 /usr/sbin/sshd
wli       9585  9584  0 Oct10 pts/0    00:00:00 -zsh
root      9589   285  0 Oct10 ?        00:00:00 /usr/sbin/sshd
wli       9591  9589  0 Oct10 ?        00:00:00 /usr/sbin/sshd
wli       9592  9591  0 Oct10 pts/1    00:00:00 -zsh
root      5901   285  0 20:44 ?        00:00:00 /usr/sbin/sshd
wli       5903  5901  0 20:44 ?        00:00:00 /usr/sbin/sshd
wli       5904  5903  1 20:44 pts/2    00:00:00 -zsh
wli       5907  5904  0 20:44 pts/2    00:00:00 ps -fade
wli       5908  5904  0 20:44 pts/2    00:00:00 less
