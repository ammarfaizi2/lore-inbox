Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318151AbSHIFWN>; Fri, 9 Aug 2002 01:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSHIFWN>; Fri, 9 Aug 2002 01:22:13 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:59611 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S318151AbSHIFWM>; Fri, 9 Aug 2002 01:22:12 -0400
Message-ID: <20020809052550.12233.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "sanket rathi" <sanket@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 09 Aug 2002 13:25:50 +0800
Subject: Kernel Oops
X-Originating-Ip: 202.54.40.36
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I have written a driver for kernel 2.2.14-5.
but some time when i try to break application through crtl-C i get kernel oops :-
because at that time machine freezes so i am not able to catch whole message waht i can read is :

Code : 89 02 85 c0 74 03 89 50 04 b8 01 00 00 00 eb 02 31 c0 c7 41
Aiee, killing interrupt handler
Kernel panic: Attempt to kill the idle task!
In interrupt handler - not syncing

But this problen is unpredictable generally it does not comes. Can any body help me in this that what could be the problem


Thanks in advance
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
