Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbSA1Uuw>; Mon, 28 Jan 2002 15:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSA1Uum>; Mon, 28 Jan 2002 15:50:42 -0500
Received: from pop.gmx.net ([213.165.64.20]:19265 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S284987AbSA1UuZ>;
	Mon, 28 Jan 2002 15:50:25 -0500
Message-ID: <000d01c1a83d$602df2e0$094b2e3e@angband>
Reply-To: "Andreas Happe" <andreashappe@subdimension.com>
From: "Andreas Happe" <andreashappe@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: kernel 2.5.2-dj 5 & 6 - compile error using radeon fb
Date: Mon, 28 Jan 2002 21:46:16 +0100
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

good evening,

i've got problems compiling the kernel 2.5.2-dj5 and dj6 due to a syntax
error in ./drivers/video/radeonfb.c . After hours spent in solitude and
asceticism i was able to trace back the error to a missing semicolon at line
1454. Could anyone fix it (adding a single character is a huge amount of
work, i know, but somebody got to do it)


Andreas Happe

(hope you don't this too seriously)

