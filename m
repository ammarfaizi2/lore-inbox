Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129111AbRBDLvC>; Sun, 4 Feb 2001 06:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129810AbRBDLuw>; Sun, 4 Feb 2001 06:50:52 -0500
Received: from pop.gmx.net ([194.221.183.20]:50252 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129111AbRBDLum>;
	Sun, 4 Feb 2001 06:50:42 -0500
Reply-To: <frlind@frlind.de>
From: "Friedrich Lindenberg" <frlind@gmx.net>
To: <linux-kernel@vger.kernel.org>
Subject: AW: ATAPI CDRW which doesn't work -> devfs problems part2
Date: Sun, 4 Feb 2001 12:52:35 +0100
Message-ID: <MABBKGIEPCIBHBENODFDAELDCBAA.frlind@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <MABBKGIEPCIBHBENODFDGELBCBAA.frlind@gmx.net>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Ursprüngliche Nachricht-----
Von: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]Im Auftrag von Friedrich
Lindenberg
Gesendet: Sonntag, 4. Februar 2001 11:36
An: linux-kernel@vger.kernel.org
Betreff: AW: ATAPI CDRW which doesn't work -> devfs problems



 Hi
 I was trying to burn cds under linux-2.4.1 with
 devFS enabled. But x-cd-roast (and also cdrecord)
 do not find any scsi drives.
    I AM USING hdd=ide-scsi && hdc=ide-scsi !!!

 I guess they have been
 renamed or something like that, I cannot find them
 in /dev, nor anywhere in /dev/scsi ...
 Oh, and could anybody tell me, how I stop RH7
 creating /dev/lp* every time I boot ? I don't
 use devices attached to lp* ....

   thanks & greetings,
    Friedrich


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
