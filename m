Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbQKBTAx>; Thu, 2 Nov 2000 14:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129136AbQKBTAn>; Thu, 2 Nov 2000 14:00:43 -0500
Received: from smtp-abo-2.wanadoo.fr ([193.252.19.150]:49322 "EHLO
	amyris.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129131AbQKBTAd>; Thu, 2 Nov 2000 14:00:33 -0500
Message-ID: <3A01508E.A992B792@easter-eggs.com>
Date: Thu, 02 Nov 2000 11:31:26 +0000
From: Adam Huuva <sventon@easter-eggs.com>
Organization: easter-eggs.org
X-Mailer: Mozilla 4.61 [en] (X11; I; Linux 2.2.12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Several concurrent terminals.
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

We'd like to have two sets of keyboard/mouse/screen connected to the
same computer with each set having the control and output of an
independent X
session each, concurrently. There might for instance be the ps/2
keyboard and mouse and
USB dittos. After attempting (and failing) we believe the problem is
really one of the kernel only allowing one virtual terminal to be active
at one time. Is this so and what can be done?

Cheers,
-- 
Adam Huuva / Easter-eggs                 Spécialiste GNU/Linux
44-46 rue de l'Ouest  -  75014 Paris  -  France -  Métro Gaité
Phone: +33 (0) 1 43 35 00 37    -   Fax: +33 (0) 1 41 35 00 76
mailto:sventon@easter-eggs.com  -   http://www.easter-eggs.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
