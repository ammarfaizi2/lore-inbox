Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280410AbRLXE1I>; Sun, 23 Dec 2001 23:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280771AbRLXE06>; Sun, 23 Dec 2001 23:26:58 -0500
Received: from johnson.mail.mindspring.net ([207.69.200.177]:63756 "EHLO
	johnson.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S280410AbRLXE0o>; Sun, 23 Dec 2001 23:26:44 -0500
Message-ID: <3C26B024.B67CCF6E@mindspring.com>
Date: Sun, 23 Dec 2001 20:33:40 -0800
From: Joe <joeja@mindspring.com>
Reply-To: joeja@mindspring.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17.. multiple oops 's
In-Reply-To: <3C26676A.3E4237C3@mindspring.com> <20011224000728.A21656@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo Carvalho de Melo wrote:

> Em Sun, Dec 23, 2001 at 03:23:22PM -0800, Joe escreveu:
> > uname -r = 2.4.17
> > OS = RH 7.2
> > glibc = /lib/libc-2.2.4.so
>
> And the compiler, which version? This is a very important information to
> provide...

compile is
from Makefile:
HOSTCC          = kgcc

kgcc --version = egcs-2.91.66

athelon 1.2 Ghz / 266fsb

I am checking weather this is bios related, it seems that by default or
after the bios upgrade one of my RAM settings was set to 4-way interleave.
I think it is possible that this caused the oops.

Joe


