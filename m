Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSK3Jmn>; Sat, 30 Nov 2002 04:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbSK3Jmn>; Sat, 30 Nov 2002 04:42:43 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:10244 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S262730AbSK3Jmn> convert rfc822-to-8bit;
	Sat, 30 Nov 2002 04:42:43 -0500
To: Lucio Maciel <abslucio@terra.com.br>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TRIVIAL PATCH 2.5] Re: [2.5.50] uninitialized timer
References: <87n0nsqmvb.fsf@gswi1164.jochen.org>
	<20021129170200.63a81b8d.abslucio@terra.com.br>
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
Date: Sat, 30 Nov 2002 10:37:38 +0100
In-Reply-To: <20021129170200.63a81b8d.abslucio@terra.com.br> (Lucio Maciel's
 message of "Fri, 29 Nov 2002 20:10:11 +0100")
Message-ID: <87smxjs8il.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Lucio Maciel <abslucio@terra.com.br> writes:

> Fix a unitialized timer in drivers/video/fbcon.c
>
> Its just a warning, try this patch

Thanks, that fixes it for me.

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.
