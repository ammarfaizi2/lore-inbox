Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262103AbUDADs1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 22:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUDADs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 22:48:27 -0500
Received: from web41313.mail.yahoo.com ([66.218.93.62]:49321 "HELO
	web41313.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262103AbUDADsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 22:48:25 -0500
Message-ID: <20040401034824.99925.qmail@web41313.mail.yahoo.com>
Date: Wed, 31 Mar 2004 19:48:24 -0800 (PST)
From: Tyler Riddle <triddle_1999@yahoo.com>
Subject: Kernel hangs approximitly every 3 days, some times during boot  on version 2.4 and 2.6
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

You can find a detailed bug report folowing the
template specified in REPORTING-BUGS at
http://foodmotron.homeunix.org/~tyler/bug-report.txt

In short, the kernel will hard lock on my machine
about every 3 days. I have tried several of the latest
versions of the 2.4 and 2.6 series kernels, 2.2 has
not shown this problem. I have tried to remedy this
problem by removing APIC support, IDE DMA and explicit
support for my IDE chipset
(VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235), none of
which has helped any. On every lockup the IDE disk
access light has been steady and usualy a steady tone
is left playing out of my sound card.

I'm hoping someone here can help me figure out what is
going on. This exact same hardware in the exact same
configuration ran Windows 2000 for over a year with
out issue. To verify the problem was localized to the
linux kernel I also ran FreeBSD 5.2.1 for 3 weeks
after the lockup problem existed under linux.

Thanks for your help,

Tyler Riddle

=====
"There are only 10 types of people in this world: Those who understand binary and those who don't."

aim: TheMastaSpice

__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
