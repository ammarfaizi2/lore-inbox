Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbQLXOKM>; Sun, 24 Dec 2000 09:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQLXOKD>; Sun, 24 Dec 2000 09:10:03 -0500
Received: from mailout00.sul.t-online.com ([194.25.134.16]:60678 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S129749AbQLXOJs>; Sun, 24 Dec 2000 09:09:48 -0500
Date: 24 Dec 2000 11:14:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <7sSHKzAmw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.21.0012221746160.320-100000@bee.lk>
Subject: Re: recommended gcc compiler version
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <E149NvR-0004Kz-00@the-village.bc.nu> <Pine.LNX.4.21.0012221746160.320-100000@bee.lk>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

anuradha@gnu.org (Anuradha Ratnaweera)  wrote on 22.12.00 in <Pine.LNX.4.21.0012221746160.320-100000@bee.lk>:

> On Fri, 22 Dec 2000, Alan Cox wrote:
>
> > For i386
> >
> > 2.2.18
> > 	gcc 2.7.2 or egcs-1.1.2
>
> Just a remainder for debian users. There is a debian package gcc272 which
> is said to be the "GNU C compiler's C part", for "backword compatibility
> purposes". I recompiled my kernel after an
>
>   apt-get install gcc272
>
> and after setting
>
>   HOSTGCC = gcc272
>
> in kernel source tree Makerile.

I recently compiled 2.2.18 and noticed that make-kpkg (from kernel-package  
- don't compile kernels on Debian without it!) did that automatically.

Incidentally, I really like the Flavours patch.


MfG Kai
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
