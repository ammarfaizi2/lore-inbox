Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbSK2Smn>; Fri, 29 Nov 2002 13:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267126AbSK2Smn>; Fri, 29 Nov 2002 13:42:43 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:21010 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S267124AbSK2Smk> convert rfc822-to-8bit;
	Fri, 29 Nov 2002 13:42:40 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.5.50] Module cannot be unloaded
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
Date: Fri, 29 Nov 2002 18:59:38 +0100
Message-ID: <87k7iwqmt1.fsf@gswi1164.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Don't know if anybody in interested in these messages:

root@gswi1164:~# dmesg | grep unsafe
Module yenta_socket cannot be unloaded due to unsafe usage in drivers/pcmcia/yenta.c:940
Module pcnet_cs cannot be unloaded due to unsafe usage in drivers/net/pcmcia/pcnet_cs.c:1033
Module irda cannot be unloaded due to unsafe usage in net/irda/af_irda.c:1146

Jochen

-- 
Wenn Du nicht weiﬂt was Du tust, tu's mit Eleganz.

