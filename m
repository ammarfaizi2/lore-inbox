Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131587AbRDMSXK>; Fri, 13 Apr 2001 14:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131588AbRDMSW7>; Fri, 13 Apr 2001 14:22:59 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:15620 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S131587AbRDMSWk>; Fri, 13 Apr 2001 14:22:40 -0400
From: Fabien CHEVALIER <fabchev4@free.fr>
Reply-To: fabchev4@free.fr
Date: Fri, 13 Apr 2001 20:20:15 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_R5ZQES649JHM0KX2QNRG"
To: video4linux-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH- new driver] Maxi Radio FM 2 driver (GemTek)
MIME-Version: 1.0
Message-Id: <01041320201500.00782@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_R5ZQES649JHM0KX2QNRG
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit


Hi,

I've wrote this driver for my Maxi Radio Fm 2 card.
I hope it can be usefull for somebody.
This card uses a GemTek chip, but the GemTek driver wasn't working very well :
the card was left uninitialized, and so it didn't mute.

I didn't wrote a patch for the GemTek driver because the protocol to change 
frequency is different.

This patch is for 2.4.3 kernel - nobody but me tested it yet...

Please CC your answers as my 56 k modem can't bear the list!
--------------Boundary-00=_R5ZQES649JHM0KX2QNRG
Content-Type: application/x-gzip;
  name="patch-maxifm2-v0.12-2.4.3.gz"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch-maxifm2-v0.12-2.4.3.gz"

‹‚X×:
--------------Boundary-00=_R5ZQES649JHM0KX2QNRG--
