Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266662AbRG0ESW>; Fri, 27 Jul 2001 00:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbRG0ESO>; Fri, 27 Jul 2001 00:18:14 -0400
Received: from SMTP5.ANDREW.CMU.EDU ([128.2.10.85]:53510 "EHLO
	smtp5.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S266662AbRG0ESF>; Fri, 27 Jul 2001 00:18:05 -0400
Date: Fri, 27 Jul 2001 00:18:04 -0400 (EDT)
From: Frank Davis <fdavis@andrew.cmu.edu>
To: linux-kernel@vger.kernel.org
cc: alan@lxorguk.ukuu.org.uk, fdavis112@juno.com
Subject: 2.4.7-ac1: ohci1394.c parse error
Message-ID: <Pine.GSO.4.21L-021.0107270015580.28563-100000@unix3.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello all,
 I haven't seen this posted. While 'make modules' on 2.4.7-ac1 , I
received the following error:
ohci1394.c:1451: parse error
make[2]: *** [ohci1394.o] Error 1
make[2]: Leaving directory '/usr/src/linux/drivers/ieee1394'
make[1]: *** [modsubdir_ieee1394] Error 2

Regards,
Frank

