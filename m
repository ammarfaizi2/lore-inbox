Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129996AbRACSsZ>; Wed, 3 Jan 2001 13:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130107AbRACSsO>; Wed, 3 Jan 2001 13:48:14 -0500
Received: from [204.26.91.1] ([204.26.91.1]:62469 "EHLO www.mammoth.org")
	by vger.kernel.org with ESMTP id <S130070AbRACSsF>;
	Wed, 3 Jan 2001 13:48:05 -0500
Date: Wed, 3 Jan 2001 12:17:38 -0600 (CST)
From: josh <skulcap@mammoth.org>
To: linux-kernel@vger.kernel.org
Subject: usb dc2xx quirk
Message-ID: <Pine.LNX.4.20.0101031155240.2682-100000@www>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel Version: 2.4.0-test11 - 2.4.0-prerelease
Platform: ix86 (PIII)
Problem Hardware: Kodac DC280, firmware 1.01

Ever since test10 or after, removing my dc280 from the usb
bus causes khubd to crash.  I have tried both UHCI drivers
and they produce the same effect. 

dmesg, syslog, messages, and .config can be found at:
http://mammoth.org/~skulcap/usb-problem

I have looked throug the archives and havent found anything
like this, so I'm sorry if it has been covered already.  

Thanks in advance!

                            mammoth.org/~skulcap
**********************************************BEGIN GEEK CODE BLOCK************
"Sometimes, if you're perfectly      * GCS d- s: a-- C++ ULSC++++$ P+ L+++ E--- 
still, you can hear the virgin       * W+(++) N++ o+ K- w--(---) O- M- V- PS-- 
weeping for the savior of your will."* PE Y+ PGP t+ 5 X+ R !tv b+>+++ DI++ D++  
 --DreamTheater, "Lines in the Sand" * G e h+ r-- y-   (www.geekcode.com)
**********************************************END GEEK CODE BLOCK**************

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
