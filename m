Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSIOQof>; Sun, 15 Sep 2002 12:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318115AbSIOQof>; Sun, 15 Sep 2002 12:44:35 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:36328 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S318113AbSIOQoe>; Sun, 15 Sep 2002 12:44:34 -0400
From: "syam" <syam@cisco.com>
To: "Thunder from the hill" <thunder@lightweight.ods.org>
Cc: "Richard Zidlicky" <rz@linux-m68k.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.4.19 Oops error
Date: Sun, 15 Sep 2002 09:48:04 -0700
Message-ID: <BOEAKBEECIJEDIMOJJJOIEHFCEAA.syam@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.44.0209130911150.10048-100000@hawkeye.luckynet.adm>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran memtest on my system and it didn't complain about any holes in it. I
still keep getting ext2_check_page() error. Any suggestions?

- Syam

-----Original Message-----
From: Thunder from the hill [mailto:thunder@lightweight.ods.org]
Sent: Friday, September 13, 2002 8:13 AM
To: syam
Cc: Richard Zidlicky; linux-kernel@vger.kernel.org
Subject: RE: Kernel 2.4.19 Oops error


Hi,

On Fri, 13 Sep 2002, syam wrote:
> Will running memtest fix the corruption?

No, but it will detect holes in your memory. Sometimes this bad memory can
be blacklisted, but badness is known to spread...

If the memory is just too hot, youre well off. Otherwise you might have to
get some new.


			Thunder
--
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

