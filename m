Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290684AbSA3Wmu>; Wed, 30 Jan 2002 17:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290706AbSA3Wmk>; Wed, 30 Jan 2002 17:42:40 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:711 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S290698AbSA3Wm0>; Wed, 30 Jan 2002 17:42:26 -0500
From: "Karl" <ktatgenhorst@earthlink.net>
To: "Robert Love" <rml@tech9.net>, "Alex Khripin" <akhripin@mit.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: BKL in tty code?
Date: Wed, 30 Jan 2002 16:57:18 -0500
Message-ID: <NDBBJHDEALBBOIDJGBNNIEHCCCAA.ktatgenhorst@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <1012418760.3219.43.camel@phantasy>
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>There is probably some cleanup that is possible, but really getting the
>thing in gear (which means no BKL, which is probably the hardest part to
>rip out) require some level of rewrite.

   Is there a specific maintainer for the TTY code. This is the part of the
kernel which I am most interested in. I have many TTYs in a mid size (100
user Unix network) and could get to do some testing if anyone is writing
patches for this system. I would also be willing to do minor review of code
for spelling and such. I would _really_ like to get involved with this
specific system.


Thanks,

Karl Tatgenhorst

