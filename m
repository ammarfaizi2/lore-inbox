Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280670AbRKFXfs>; Tue, 6 Nov 2001 18:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280673AbRKFXfi>; Tue, 6 Nov 2001 18:35:38 -0500
Received: from philotas.hosting.pacbell.net ([216.100.99.24]:65501 "EHLO
	philotas.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S280670AbRKFXf3>; Tue, 6 Nov 2001 18:35:29 -0500
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Linux kernel 2.4 and TCP terminations per second.
Date: Tue, 6 Nov 2001 15:34:23 -0800
Message-ID: <017e01c1671b$91ab38e0$3b10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <E161FY0-0002AE-00@the-village.bc.nu>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am running openssl with apache using modssl. I will have to look at
whether could I use openssl with TUX or zeus.

Thanks.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Alan Cox
Sent: Tuesday, November 06, 2001 3:22 PM
To: imran.badr@cavium.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel 2.4 and TCP terminations per second.


> Does anybody know , what is the maximum number of TCP (http)
> terminations/per second a server (single/dual/.. processor)  in todays
> market can do, without much CPU load. The server would be running linux
> kernel 2.4 and apache web server.

If you are running any kind of high performance connections/second load then
you dont run apache. That isnt what apache is good at

thttpd will do 2000/sec on a decent box. zeus (non free) more, and tux
(kernel http accelerator) holds some records
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

