Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263264AbREMTGi>; Sun, 13 May 2001 15:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263265AbREMTG3>; Sun, 13 May 2001 15:06:29 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:34841 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S263264AbREMTGV>; Sun, 13 May 2001 15:06:21 -0400
Message-ID: <004b01c0dbdf$9d341500$3303a8c0@pnetz>
From: =?iso-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: <kernel@llamas.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <E14yHQW-0001Sg-00@the-village.bc.nu>
Subject: Re: Latest on Athlon Via KT133A chipset solution?
Date: Sun, 13 May 2001 21:04:58 +0200
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

 Give the current -ac a spin and tell me if it works/doesnt and if not how
> it fails

I tried 2.4.4-ac8.
It still hangs during boot if compiled for Athlon, but also crashes after a
while if compiled for 586. (I did a bonnie, did it a second time. The second
run doesn´t finished.) It is a complete system freeze, magic sysrq doesn´t
work.

Now i am going to try the new bios with a new version of the via fix. I will
report if this solution fix it for me/us.

greetings

Christian

