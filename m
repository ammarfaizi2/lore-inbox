Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRBIWiN>; Fri, 9 Feb 2001 17:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130015AbRBIWiE>; Fri, 9 Feb 2001 17:38:04 -0500
Received: from msgbas1x.cos.agilent.com ([192.6.9.33]:40945 "HELO
	msgbas1.cos.agilent.com") by vger.kernel.org with SMTP
	id <S129197AbRBIWhz>; Fri, 9 Feb 2001 17:37:55 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B747797188099C@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: linux-kernel@vger.kernel.org
Subject: cli and timer/other interrupts
Date: Fri, 9 Feb 2001 15:37:48 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

on UP system, if we call cli(), then after that what all 
interrupts can occur ? Does the timer interrupt also get blocked
when we call cli() ? I read that, cli() disables all non-maskable
interrupts.

Thanks
-hiren
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
