Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276470AbRI2JdC>; Sat, 29 Sep 2001 05:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276474AbRI2Jcw>; Sat, 29 Sep 2001 05:32:52 -0400
Received: from web10407.mail.yahoo.com ([216.136.130.99]:57354 "HELO
	web10407.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276470AbRI2Jci>; Sat, 29 Sep 2001 05:32:38 -0400
Message-ID: <20010929093305.31768.qmail@web10407.mail.yahoo.com>
Date: Sat, 29 Sep 2001 19:33:05 +1000 (EST)
From: =?iso-8859-1?q?Steve=20Kieu?= <haiquy@yahoo.com>
Subject: 2.4.10 VM problem
To: kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just got a lockup in X windows, (black screen,
nothing works but the power off button still works)
when compiling Lyx and running several program
(LimeWire, Mozilla). Unfortunately I can not have any
informative message yet, just I found in
/var/log/message this line when reboot

 __alloc_pages: 0-order allocation failed (gfp=0
x1d2/0) from c012f7a6

This is 2.4.10 with prempt patch and vm1 tweak form
Andre.



=====
S.KIEU

http://travel.yahoo.com.au - Yahoo! Travel
- Got Itchy feet? Get inspired!
