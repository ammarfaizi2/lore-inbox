Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285088AbRLQKVU>; Mon, 17 Dec 2001 05:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285089AbRLQKVK>; Mon, 17 Dec 2001 05:21:10 -0500
Received: from web21205.mail.yahoo.com ([216.136.131.248]:44907 "HELO
	web21205.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S285088AbRLQKU5>; Mon, 17 Dec 2001 05:20:57 -0500
Message-ID: <20011217102056.1779.qmail@web21205.mail.yahoo.com>
Date: Mon, 17 Dec 2001 02:20:56 -0800 (PST)
From: vijayalakshmi krishnamurthy <linaxmi@yahoo.com>
Subject: prblm with first module prog
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all
  I'm a novice ,here  I tried the first module prog 
given in the tutorial in the link
  http://www.linuxdoc.org/LDP/lkmpg/
   i followed all the instructions, verfied with
header files but on running make i get

        1.fist.c: In function `init_module':
        2.fist.c:11: warning: implicit declaration of
function `printk_Rsmp_1b7d4074'
        3.cc -Wall -DMODULE -D__KERNEL__ -DLINUX -c
fist.c
        4.echo insmod fist.o to turn it on
        5.insmod fist.o to turn it on
        6.echo rmmod fist to turn it off
        7.rmmod fist to turn it off
        8.echo
        9.
        10.echo X & kernel prog do not mix.
        11.X
        12./bin/sh: kernel: command not found
        13.make: *** [fist.o] Error 127


when I redirected my make file o/p from terminal only
lines 4 - 11 were in the
 redirected file. the rest were in the console. can
somebody explain me the reason.
 why do they echo the insmod & rmmod & other things? i
dont getit.

 All kind of explanations R welcome

 thanx in advance
 lakshmi

__________________________________________________
Do You Yahoo!?
Check out Yahoo! Shopping and Yahoo! Auctions for all of
your unique holiday gifts! Buy at http://shopping.yahoo.com
or bid at http://auctions.yahoo.com
