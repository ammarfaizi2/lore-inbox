Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130522AbRBKWf7>; Sun, 11 Feb 2001 17:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130600AbRBKWfs>; Sun, 11 Feb 2001 17:35:48 -0500
Received: from rmx460-mta.mail.com ([165.251.48.47]:24457 "EHLO
	rmx460-mta.mail.com") by vger.kernel.org with ESMTP
	id <S130522AbRBKWfn>; Sun, 11 Feb 2001 17:35:43 -0500
Message-ID: <385378057.981930849661.JavaMail.root@web395-wra.mail.com>
Date: Sun, 11 Feb 2001 17:34:04 -0500 (EST)
From: Frank Davis <fdavis112@juno.com>
To: alan@lxorguk.ukuu.org.uk
Subject: 2.4.1-ac10 compile error
CC: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Mailer: mail.com
X-Originating-IP: 151.201.242.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    I received the following while compiling 2.4.1-ac10:
...
make[3]: *** No rule to make target '/usr/src/linux/drivers/pci/devlist.h', needed by names.o'. Stop
make[3]: Leaving directory '/usr/src/linux/drivers/pci'
make[2]: *** [first_rule] Error 2
...

I haven't looked into it, but the addition was between 2.4.1-ac9 and 2.4.1-ac10. 2.4.2-pre3 didn't have this problem.

Regards,
Frank


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
