Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbRHBRrl>; Thu, 2 Aug 2001 13:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268453AbRHBRrb>; Thu, 2 Aug 2001 13:47:31 -0400
Received: from web13704.mail.yahoo.com ([216.136.175.137]:28430 "HELO
	web13704.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S267248AbRHBRrV>; Thu, 2 Aug 2001 13:47:21 -0400
Message-ID: <20010802174730.76395.qmail@web13704.mail.yahoo.com>
Date: Thu, 2 Aug 2001 10:47:30 -0700 (PDT)
From: jalaja devi <jala_74@yahoo.com>
Subject: kgdb ksymtab_addr not found!!
To: linux-kernel@vger.kernel.org
In-Reply-To: <992041001.9209.0.camel@phantasy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have 2 quesions here:


1. Could any plz tell me what am i missing out here?

I basically, trying to debug my my loadable module in
kernel in kernel2.4.6 version. I patched the kernel
with 2.4.6 kgdb patch, using the recent version.

I am using the modutils shell script to load my module
loadmodule.sh which creates a gdbscript. When I source
the gdbscript I get the following warnings:

warning : section _ksymtab not found in mymodule.o
warning : section _archdata not found in mymodule.o

Do I need to patch the kernel with the modutils. Why
do I get these warnings.


2. How can I put a breakpoint to debug my init_module?
Which is the Kernel Fxn to be invoked to put a
breakpoint in my init_module?


Thanks in advance,

Jalaja




__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
