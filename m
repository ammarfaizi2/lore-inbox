Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129031AbRBLV7e>; Mon, 12 Feb 2001 16:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129433AbRBLV7Y>; Mon, 12 Feb 2001 16:59:24 -0500
Received: from ip290.boanxx1.adsl.tele.dk ([193.89.189.36]:3456 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130097AbRBLV7J>; Mon, 12 Feb 2001 16:59:09 -0500
From: "John B. Jacobsen" <jbj_ss@mail.tele.dk>
Message-Id: <200102122150.f1CLoNC00878@localhost.localdomain>
Subject: RedHat 7.0 4.1 / lpd warning
To: linux-kernel@vger.kernel.org
Date: Mon, 12 Feb 2001 22:50:23 +0100 (CET)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following warning when I compiled
kernel 2.4.0 and 2.4.1 :

Starting lpd: Warning - lp: cannot open lp device '/dev/lp0' - No such device
Warning - dj: cannot open lp device '/dev/lp0' - No such device

Why is that ? /dev/lp surely exists !

regards

John
  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
