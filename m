Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276347AbRJPPo3>; Tue, 16 Oct 2001 11:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276364AbRJPPoI>; Tue, 16 Oct 2001 11:44:08 -0400
Received: from access-35.98.rev.fr.colt.net ([213.41.98.35]:25098 "HELO
	phoenix.linuxatbusiness.com") by vger.kernel.org with SMTP
	id <S276350AbRJPPoE> convert rfc822-to-8bit; Tue, 16 Oct 2001 11:44:04 -0400
Subject: parport compilation problem with 2.4.13-pre3
From: Philippe Amelant <philippe.amelant@free.fr>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.15 (Preview Release)
Date: 16 Oct 2001 16:39:38 +0200
Message-Id: <1003243178.21984.9.camel@avior>
Mime-Version: 1.0
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ieee1284_ops.c: In function `ecp_forward_to_reverse':
ieee1284_ops.c:365: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
this function)
ieee1284_ops.c:365: (Each undeclared identifier is reported only once
ieee1284_ops.c:365: for each function it appears in.)
ieee1284_ops.c: In function `ecp_reverse_to_forward':
ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in
this function)
make[2]: *** [ieee1284_ops.o] Erreur 1
make[2]: Quitte le répertoire
`/usr/src/linux-2.4.13-pre3/drivers/parport'
make[1]: *** [_modsubdir_parport] Erreur 2
make[1]: Quitte le répertoire `/usr/src/linux-2.4.13-pre3/drivers'
make: *** [_mod_drivers] Erreur 2

