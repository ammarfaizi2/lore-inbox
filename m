Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262036AbRE2Vcj>; Tue, 29 May 2001 17:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262052AbRE2Vc3>; Tue, 29 May 2001 17:32:29 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:39797 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S262036AbRE2VcP>; Tue, 29 May 2001 17:32:15 -0400
Message-ID: <001a01c0e886$5be3eea0$3303a8c0@pnetz>
From: =?iso-8859-1?Q?Christian_Borntr=E4ger?= <christian@borntraeger.net>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: PROMISE+ATHLON crashes with 2.4.3ac7 or higher. workaround?
Date: Tue, 29 May 2001 23:28:49 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I faced several system hangs with an ASUS A7V133 using a kernel 2.4.3ac7 or
higher. (I reported this some time ago)
Now I removed the 2 hard drives from the promise controller and attached
them an to the via controller.
After that step I could not reproduced the system freeze at least with
2.4.5.
So I __guess__ that the promise controller in combination with the VIA PCI
Interface leads to some trouble. I will do some further investigations, to
find out, if the promise controller was my problem.

Just ask if you need more information.

greetings

Christian Bornträger

