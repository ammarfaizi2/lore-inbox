Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270530AbRHHRJr>; Wed, 8 Aug 2001 13:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270528AbRHHRJ1>; Wed, 8 Aug 2001 13:09:27 -0400
Received: from ns1.austin.rr.com ([24.93.35.62]:56848 "EHLO ns1.austin.rr.com")
	by vger.kernel.org with ESMTP id <S270527AbRHHRJW>;
	Wed, 8 Aug 2001 13:09:22 -0400
From: "Rob" <rwideman@austin.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: configuring the kernel
Date: Wed, 8 Aug 2001 12:11:44 -0500
Message-ID: <LHEGJICMMCCGOHKDFALMOEMHCAAA.rwideman@austin.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a couple questions of which i am unsure of.  Last nite i did my first
kernel compilation and i am thinking that i might have been too tired for
doing this at 6A (yes stayed up all nite).  I might have said yes to a few
things and no to a few things that i shouldnt have and want to reconfigure
the kernel.  The only problem is i am not sitting through another 1.5 hrs of
Y/N questions on which 75% i am not sure of while not having any sleep for
about 25 hrs. I would rather install RH 2 or 3 before going through that
again.
I have RH 7.1 and want to update to 2.4.7. I have the most basic install
(the only thing i selected during isntall was kernel development and
development so i can compile and redo the kernel of course).

Qustions:
1-does "make menuconfig" require X to be installed? I dont have X, i just
have RH 7.1 with kernel dev and kernel sources installed (atleast those were
the ONLY things i had selected during install).
2-if i untared/unpacked the kernel to the folder /root/newkern (here is
where i did the "gzip -cd linux 2.4.7...... |tar xvf -" command) is it ok to
delete the newkern folder and unpack nd then do the "make menuconfig"?

