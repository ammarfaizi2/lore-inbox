Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262678AbREaGwx>; Thu, 31 May 2001 02:52:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262764AbREaGwn>; Thu, 31 May 2001 02:52:43 -0400
Received: from c4.h061013036.is.net.tw ([61.13.36.4]:5649 "EHLO
	exchsmtp.via.com.tw") by vger.kernel.org with ESMTP
	id <S262678AbREaGwd> convert rfc822-to-8bit; Thu, 31 May 2001 02:52:33 -0400
Message-ID: <611C3E2A972ED41196EF0050DA92E0760265D6B9@EXCHANGE2>
From: Yiping Chen <YipingChen@via.com.tw>
To: "'Frank Eichentopf'" <frei@hap-bb.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: via-rhine DFE-530TX rev A1
Date: Thu, 31 May 2001 14:52:29 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, please download the newest driver from D-Link, becuase the
Win98 will change to D3 mode after it boot.
So the Mac address can't be fetch in Linux.

-----Original Message-----
From: Frank Eichentopf [mailto:frei@hap-bb.de]
Sent: Thursday, May 31, 2001 2:27 PM
To: linux-kernel@vger.kernel.org
Subject: Re: via-rhine DFE-530TX rev A1


I have the same effect when booting from windows98 to linux ( 2.4.3 up to 
2.4.5). The windowsdriver less the card in a unbalanced state so that the
card
lost his information of there own mac adress. We must plug off the
powercable,
after plugin an start into linux the dlink card works. I don´t know what
kinds
of specific instruction in the windows driver, but when I only used this
cards
under linux, I doesn´t have this problem. 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
