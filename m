Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131949AbRDNKdr>; Sat, 14 Apr 2001 06:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDNKdh>; Sat, 14 Apr 2001 06:33:37 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:59145 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S131949AbRDNKd1>; Sat, 14 Apr 2001 06:33:27 -0400
From: Fabien CHEVALIER <fabchev2@free.fr>
Reply-To: fabchev2@free.fr
Date: Sat, 14 Apr 2001 12:30:26 +0000
X-Mailer: KMail [version 1.1.99]
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_Q28S97QONW82L3U7AZ17"
To: linux-kernel@vger.kernel.org
Subject: [PATCH- new driver] Maxi Radio FM 2 driver (GemTek) (2)
MIME-Version: 1.0
Message-Id: <01041412302602.00723@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_Q28S97QONW82L3U7AZ17
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit

>Hi,

>I've wrote this driver for my Maxi Radio Fm 2 card.
> i hope it can be usefull for somebody.
>This card uses a GemTek chip, but the GemTek driver wasn't working very well 
>:
>the card was left uninitialized, and so it didn't mute.

>I didn't wrote a patch for the GemTek driver because the protocol to change 
>frequency is different.

>This patch is for 2.4.3 kernel - nobody but me tested it yet...

>Please CC your answers as my 56 k modem can't bear the list!


Ooops, something went wrong with the attached patch, I hope this time there 
won't be any problem...
--------------Boundary-00=_Q28S97QONW82L3U7AZ17
Content-Type: text/plain;
  name="patch-maxifm2-v0.12-2.4.3.gz"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="patch-maxifm2-v0.12-2.4.3.gz"

‹‚X×:
--------------Boundary-00=_Q28S97QONW82L3U7AZ17--
