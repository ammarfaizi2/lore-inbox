Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131539AbQKKRkt>; Sat, 11 Nov 2000 12:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131697AbQKKRkk>; Sat, 11 Nov 2000 12:40:40 -0500
Received: from vill.ha.smisk.nu ([212.75.83.8]:3848 "HELO mail.smisk.nu")
	by vger.kernel.org with SMTP id <S131539AbQKKRkZ>;
	Sat, 11 Nov 2000 12:40:25 -0500
Message-ID: <00c901c04c06$82834690$020a0a0a@totalmef>
From: "Magnus Naeslund\(b\)" <mag@bahnhof.se>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Tracing files that opens.
Date: Sat, 11 Nov 2000 18:40:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a nice way to trap on file open() and stat() ?
That way i could have nice file statistics.

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
