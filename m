Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbUASUh1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 15:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263486AbUASUh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 15:37:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:11398 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263472AbUASUhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 15:37:21 -0500
Date: Mon, 19 Jan 2004 15:37:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Bart Samwel <bart@samwel.tk>
cc: Ashish sddf <buff_boulder@yahoo.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ kernel module + Makefile
In-Reply-To: <400C37E3.5020802@samwel.tk>
Message-ID: <Pine.LNX.4.53.0401191521400.8389@chaos>
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com>
 <Pine.LNX.4.53.0401161659470.31455@chaos> <200401171359.20381.bart@samwel.tk>
 <Pine.LNX.4.53.0401190839310.6496@chaos> <400C1682.2090207@samwel.tk>
 <Pine.LNX.4.53.0401191311250.8046@chaos> <400C37E3.5020802@samwel.tk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004, Bart Samwel wrote:

> Richard B. Johnson wrote:
> > On Mon, 19 Jan 2004, Bart Samwel wrote:
> [... lots of text ...]
[Snipped...]

I stand by my assertion that anybody who develops kernel
modules in C++, including MIT students, is arrogant.

Let's see if C++ is in use in the kernel. At one time, some
of the tools that came with it were written in C++ (like ksymoops).

Script started on Mon Jan 19 15:19:33 2004
$ cd /usr/src/linux-2.4.24
$ find . -name "*.cpp"
$ exit
exit
Script done on Mon Jan 19 15:20:25 2004

Well, perhaps the kernel developers were ignorant. They didn't
write anything in C++. Maybe they were just too dumb to learn the
language?

Maybe there is another reason:
The kernel development languages, as previously stated, were
defined at the project's inception to be the GNU C 'gcc'
compiler's "C" and extensions,  and the 'as' (AT&T syntax)
assembler. Anybody can search the archives for the discussions
about using C++ in the kernel.

Any person, or group of persons, who is smart enough to
actually write some kernel code in C++, has proved that
they are not ignorant. Therefore, they have demonstrated
their arrogance.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


