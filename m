Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268429AbRHKQEQ>; Sat, 11 Aug 2001 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268434AbRHKQEG>; Sat, 11 Aug 2001 12:04:06 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:25870 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S268429AbRHKQD5>;
	Sat, 11 Aug 2001 12:03:57 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: s0mbre <johnpol@2ka.mipt.ru>
cc: linux-kernel@vger.kernel.org
Subject: Re: [insmod don't work corrctly] /dev/hands damaged system 
In-Reply-To: Your message of "Sat, 11 Aug 2001 19:08:17 +0400."
             <8797.010811@2ka.mipt.ru> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 12 Aug 2001 02:04:03 +1000
Message-ID: <2310.997545843@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001 19:08:17 +0400, 
s0mbre <johnpol@2ka.mipt.ru> wrote:
>After recompiling -ac1( and -ac10, and -ac9, and -ac7) with
>gcc-2.95.2( instead of 3.0 that doesn't work in principle), i collide
>with strange behavior of lsmod:
>
>[root@Sombre s0mbre]# insmod /lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o
>/lib/modules/2.4.7-ac1/kernel/drivers/net/dummy.o: unresolved symbol __kfree_skb

http://www.tux.org/lkml/#s8-8

