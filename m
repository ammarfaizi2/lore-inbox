Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265314AbRF2CAl>; Thu, 28 Jun 2001 22:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265398AbRF2CAb>; Thu, 28 Jun 2001 22:00:31 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:6129 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265314AbRF2CAS>; Thu, 28 Jun 2001 22:00:18 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <alan@redhat.com>
Subject: Re: Linux 2.4.5-ac21
Date: Fri, 29 Jun 2001 03:59:58 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20010629020021Z265314-17720+8914@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

you've missed the CONFIG_DRM_AGP thing.
Some other config objects (Input -> joysticks , SMB file system) are
broken, too.

Regards,
	Dieter

can't read "CONFIG_DRM_AGP": no such variable
    while executing
"list $CONFIG_DRM_AGP"
    (procedure "writeconfig" line 2352)
    invoked from within
"writeconfig .config include/linux/autoconf.h"
    invoked from within
".f0.right.save invoke"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke]"
    (procedure "tkButtonUp" line 7)
    invoked from within
"tkButtonUp .f0.right.save
"
    (command bound to event)

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
Cognitive Systems Group
Vogt-Kölln-Straße 30
D-22527 Hamburg, Germany

email: nuetzel@kogs.informatik.uni-hamburg.de
@home: Dieter.Nuetzel@hamburg.de
