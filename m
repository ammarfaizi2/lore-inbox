Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261561AbSLAJMh>; Sun, 1 Dec 2002 04:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261568AbSLAJMh>; Sun, 1 Dec 2002 04:12:37 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:50949 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S261561AbSLAJMg> convert rfc822-to-8bit;
	Sun, 1 Dec 2002 04:12:36 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.50] wrong permissions for vfat directories
References: <87hedyon77.fsf@gswi1164.jochen.org>
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Sat, 30 Nov 2002 22:20:05 +0100
In-Reply-To: <87hedyon77.fsf@gswi1164.jochen.org> (Jochen Hein's message of
 "Sat, 30 Nov 2002 21:30:10 +0100")
Message-ID: <87el92oiuy.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Hein <jochen@jochen.org> writes:

> I do mount vfat with autofs, and options umask=002 there.  

Ah, I need dmask=002 too.  

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
