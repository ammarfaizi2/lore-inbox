Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKHDY4>; Tue, 7 Nov 2000 22:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbQKHDYq>; Tue, 7 Nov 2000 22:24:46 -0500
Received: from memphis.cbn.net.id ([202.158.3.16]:46088 "HELO
	memphis.cbn.net.id") by vger.kernel.org with SMTP
	id <S129050AbQKHDYg>; Tue, 7 Nov 2000 22:24:36 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
From: imel96@trustix.co.id
Subject: Re: [2.4.0-test10] zImage, pcmcia, and ufs(44bsd)
Date: Wed, 8 Nov 2000 03:27:31 GMT
X-Mailer: CBN WebMail v0.0.1
X-Mailer-OriginatingIP: 202.158.36.82
Message-Id: <20001108032437Z129050-31179+1882@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> imel96 wrote:
> > 
> >         hi all,
> > 
> >         just a few reports:
> > 
> >         1. zImage in test10 somehow isn't working
properly. i have a
> >         zImage sized a bit more than 500kb on my
harddrive which hangs at
> >         the loading process (the one showing dots).
> >         i write the image to a floppy, and it boots just
fine. if i
> >         recompiled my kernel so the zImage size is
around 490kb, the
> >         image gets loaded just fine.
> 
> make bzImage

	if someone remove zImage. the zImage built just fine.
	my problem is the zImage doesn't boot on a harddrive,
	while it's working just fine on floppy disk.



	
imel

----------------------------------------------------
This email was sent using http://webmail.cbn.net.id/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
