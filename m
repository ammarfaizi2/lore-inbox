Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263452AbTC2Siq>; Sat, 29 Mar 2003 13:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263454AbTC2Sip>; Sat, 29 Mar 2003 13:38:45 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:59664 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S263452AbTC2Sip>;
	Sat, 29 Mar 2003 13:38:45 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.65] tun not working
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
Date: Sat, 29 Mar 2003 19:27:40 +0100
In-Reply-To: <873clgh6t7.fsf@jupiter.jochen.org> (Jochen Hein's message of
 "Fri, 21 Mar 2003 20:13:08 +0100")
Message-ID: <87n0je58pv.fsf@echidna.jochen.org>
User-Agent: Gnus/5.090015 (Oort Gnus v0.15) Emacs/21.2
References: <873clgh6t7.fsf@jupiter.jochen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Hein <jochen@jochen.org> writes:

> I'm using tun to connect my virtual S/390 from hercules to the local
> machine.  That works pretty well with 2.4, but with 2.5.65 hercules
> fails with:
>
> root@gswi1164:~# hercules -f /etc/hercules/hercules.cnf
> Hercules Version 2.16.5

With hercules 2.17.1 it works.  Still on kernel 2.5.66.  Hm.

Jochen

-- 
#include <~/.signature>: permission denied
