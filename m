Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQKUJEC>; Tue, 21 Nov 2000 04:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129208AbQKUJDw>; Tue, 21 Nov 2000 04:03:52 -0500
Received: from c954190-a.saltlk1.ut.home.com ([24.13.131.161]:30450 "EHLO
	newton.uucp") by vger.kernel.org with ESMTP id <S129091AbQKUJDd>;
	Tue, 21 Nov 2000 04:03:33 -0500
Message-ID: <XFMail.20001121013350.aussersterne@home.com>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Tue, 21 Nov 2000 01:33:50 -0700 (MST)
Organization: The Frozbizz Magic Company
From: Aron Hsiao <aussersterne@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Freeze on FPU exception with Athlon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This may not be helpful (and the thread is now two days
old), but I just wanted to add that after using Mr.
Torvalds' comment-out-irq13 suggestion and Vojtech
Pavlik's "Possible critical VIA vt82c686a chip bug"
patch (Oct 26), both with 2.4.0-t10, I've successfully
had a 2.4 series uptime >48 hours for the first time
with an Athlon/KX133 setup! Whopee!

Hopefully both of these are incorporated in some way
into 2.4.0-t11? I'm about to test it out...

Thanks all... I'm just so overjoyed. *sniff*

-A. Hsiao



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
