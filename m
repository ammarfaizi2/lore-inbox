Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbQKUPJD>; Tue, 21 Nov 2000 10:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129752AbQKUPIx>; Tue, 21 Nov 2000 10:08:53 -0500
Received: from [193.127.21.194] ([193.127.21.194]:35381 "HELO
	postal.sl.trymedia.com") by vger.kernel.org with SMTP
	id <S129453AbQKUPIk>; Tue, 21 Nov 2000 10:08:40 -0500
From: Rubén Gallardo Fructuoso <ruben@trymedia.com>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Address translation
Date: Tue, 21 Nov 2000 15:41:26 +0100
Message-ID: <DLECJAOCHAKJBLMJFKPIAEPBCCAA.ruben@trymedia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi everybody!

	I'm developing a module of file system filter and I have a question about
it. Does anybody know a function or method in order to translate an user
space pointer into a valid pointer in kernel mode?

	I'd like to avoid copying data (such as the 'copy_to_user' and
'copy_from_user' functions do) because it slows down my system.

	Thanks in advance,
	Rubén.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
