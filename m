Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292634AbSB0SRS>; Wed, 27 Feb 2002 13:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292863AbSB0SQ5>; Wed, 27 Feb 2002 13:16:57 -0500
Received: from mail.gmx.net ([213.165.64.20]:28629 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S292860AbSB0SQm>;
	Wed, 27 Feb 2002 13:16:42 -0500
Message-ID: <043401c1bfba$fdbc8fa0$8b4b2e3e@angband>
Reply-To: "Andreas Happe" <eternalwayfarer@subdimension.com>
From: "Andreas Happe" <andreashappe@gmx.net>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Cc: "lkml" <linux-kernel@vger.kernel.org>
Subject: problems with new input api
Date: Wed, 27 Feb 2002 19:17:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i'm currently using linux-2.5.5-dj2 and have a problem with the new input
api. After booting my system the keyboard is f*cked up, some keys don't
react on key press, others do (some with false characters...).  After
changing and leaving the alternate input mode of the keyboard (fn - key, the
computer is a laptop (with 830 chipset)) the keyboard acts normal.

As so far the situation isn't a problem, just two more key presses at boot
time ;-). But recently the keyboard doesn't react to anything, i'm not able
to perform any kind of input (this happens around every tenth boot
procedure). (I don't know for sure that this is related to the previous
problem.

is there any (easy) workaround?

tia,
Andreas

