Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272241AbRHWMi6>; Thu, 23 Aug 2001 08:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272248AbRHWMis>; Thu, 23 Aug 2001 08:38:48 -0400
Received: from chaos.analogic.com ([204.178.40.224]:53893 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S272247AbRHWMie>; Thu, 23 Aug 2001 08:38:34 -0400
Date: Thu, 23 Aug 2001 08:38:48 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: python now required for kernel compile -- <grin>
Message-ID: <Pine.LNX.3.95.1010823083600.5631A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


python???
Remember the `fortune` where somebody accidentally typed `ed`?

# python
Python 1.3 (Mar 11 1996)  [GCC 2.7.2]
Copyright 1991-1995 Stichting Mathematisch Centrum, Amsterdam
>>> ^C 
KeyboardInterrupt
>>> ^C 
KeyboardInterrupt
>>> ^C 
KeyboardInterrupt
>>> help
>Traceback (innermost last):
  File "<stdin>", line 1, in ?
NameError: help
>>> quit
>Traceback (innermost last):
  File "<stdin>", line 1, in ?
NameError: quit
>>> exit
>Traceback (innermost last):
  File "<stdin>", line 1, in ?
NameError: exit
>>> ^Z
[1]+  Stopped		python
$ killall python
$ ps | grep python
5549  2 T  0:00  python
5568  2 S  0:00  grep python
$ kill -9 5549

Welcome to Linux 2.4.1

putah login:



Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


