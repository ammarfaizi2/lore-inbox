Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132461AbQLKAcs>; Sun, 10 Dec 2000 19:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132567AbQLKAci>; Sun, 10 Dec 2000 19:32:38 -0500
Received: from rmx195-mta.mail.com ([165.251.48.42]:41610 "EHLO
	rmx195-mta.mail.com") by vger.kernel.org with ESMTP
	id <S132461AbQLKAce>; Sun, 10 Dec 2000 19:32:34 -0500
Message-ID: <381711807.976492925796.JavaMail.root@web340-wra.mail.com>
Date: Sun, 10 Dec 2000 19:02:05 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: torvalds@transmeta.com
Subject: test12-pre8 ohci1394.c compile error
CC: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.242.214
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
   I also received this error:

ohci1394.c:1588: structure has no member named 'next'
make[2]:*** [ohci1394.o] Error 1
make[2]: Leaving directory '/usr/src/linux/drivers/ieee1394'
...
Its the same case with drivers/i2o/i2o_lan.c

I suspect there are more. Is there a simple patch that will fix all affected drivers?

Regards,
Frank


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
