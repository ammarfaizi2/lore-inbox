Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130004AbRCDCjq>; Sat, 3 Mar 2001 21:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130008AbRCDCjg>; Sat, 3 Mar 2001 21:39:36 -0500
Received: from slamp.tomt.net ([195.139.204.145]:34534 "HELO slamp.tomt.net")
	by vger.kernel.org with SMTP id <S130004AbRCDCjY>;
	Sat, 3 Mar 2001 21:39:24 -0500
From: "Andre Tomt" <andre@tomt.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: <sjhill@cotw.com>
Subject: RE: LILO error with 2.4.3-pre1...
Date: Sun, 4 Mar 2001 03:39:34 +0100
Message-ID: <OPECLOJPBIHLFIBNOMGBIEDHDGAA.andre@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
In-Reply-To: <3AA19820.6A33E871@cotw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    'lba32' extensions Copyright (C) 1999,2000 John Coffman
     ^^^^^^

Add lba32 as the top line in lilo.conf. Re-run lilo.

> Fatal: geo_comp_addr: Cylinder number is too big (1274 > 1023)

Before 2.4.3pre1, your kernel just happened to toss itself below cylinder
1024.

> Go ahead, call me idiot :).

Idiot. :-)

--
Regards,
Andre Tomt

