Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281794AbRLBVR1>; Sun, 2 Dec 2001 16:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276369AbRLBVRQ>; Sun, 2 Dec 2001 16:17:16 -0500
Received: from fepA.post.tele.dk ([195.41.46.143]:63109 "EHLO
	fepA.post.tele.dk") by vger.kernel.org with ESMTP
	id <S279305AbRLBVPy>; Sun, 2 Dec 2001 16:15:54 -0500
Message-ID: <000b01c17bbe$a8bdd3a0$0b00a8c0@runner>
From: "Rune Petersen" <rune.mail-list@mail.tele.dk>
To: "Pavel Machek" <pavel@suse.cz>
Cc: "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20011202121922.A2356@elf.ucw.cz>
Subject: Re: ACPI+HP omnibook -- freeze until power is pressed?
Date: Sun, 2 Dec 2001 21:52:09 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've experiensed something with my laptop (Uniwill):
It sometimes locks up when I've booted up, and the powerbutton sometimes
help, other times it just powers off.
it has happend for me since kernel 2.4.3, but since by laptop is buggy I
thought it something wrong with it. seams I was wrong..

Rune Petersen
----- Original Message -----
From: Pavel Machek <pavel@suse.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Cc: ACPI mailing list <acpi@phobos.fachschaften.tu-muenchen.de>
Sent: Sunday, December 02, 2001 3:19 AM
Subject: ACPI+HP omnibook -- freeze until power is pressed?


Hi!

I'm seeing strange thing on hp omnibook... I work on console, and
machine suddenly locks up without me doing anything strange. So I
press powerbutton for a short while, and ... machine continues to work
as if nothing happened. Not even keyboard presses are lost.

But its annoying, anyway. 2.4.14-acpi. Happened ~10 times so
far. Anyone seen something similar?
Pavel
--
"I do not steal MS software. It is not worth it."
                                -- Pavel Kankovsky
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


